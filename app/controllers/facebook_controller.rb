class FacebookController < ApplicationController

  before_filter :facebook_auth
  before_filter :require_login, :except => :login
  helper_method :logged_in?, :current_user
  
  #gets list of friends from your friends profile.
  def index
    @friends = current_user.get_friends 
  end

  def login    
  end
  
  # 2 queries statements: First gets a set of id's for the first 100 posts. 
  # Using those id's a second select searches for all the ID's of the users who commented on list of posts.
  def fetch_posts
    @sel_friend = params[:friend_name] # for display in the chart's heading
    posts = @graph.fql_query("
          SELECT fromid 
          FROM comment 
          WHERE post_id IN 
            (SELECT post_id 
             FROM stream 
             WHERE source_id = '#{params[:selected_friend]}'  limit 150) 
             AND fromid != '#{params[:selected_friend]}' 
    ") # "The AND fromid != '#{params[:selected_friend]}" in this query removes the users own ID. 
    commenter_ids = []
    stats = Hash.new(0)
    posts.each do |id|
      stats[id['fromid']] += 1  #counting each comment made and adding to totals under each user's id(fromid)
      commenter_ids << id['fromid']
    end
    commenter_ids = commenter_ids.join(",")
    names = @graph.fql_query(" 
     SELECT name , uid
     FROM user 
     WHERE uid IN (#{commenter_ids})
       ")
    # At this point there are two sets of results. namely "posts([ID, Number of comments])" and "names([name of commenter, ID])"
    # The desired result is [Name of commenter, Number of comments]
    @statistics = ""
    unsorted_statistics = []
    names.each do |name|
      unsorted_statistics << [stats[name['uid']], name['name']]
    end
    #Once merged, sorted and rversered to appear in an ascending order
    unsorted_statistics.sort!.reverse!  
    # A user could have 10 friends who comment often or 10 000 who comment often. 
    # Which means theres a posibility of having something crazy like 2000+ friends who have all commented at least once.
    # selecting the Top ten ensures only the highest ranking commentors are shown.
    unsorted_statistics.first(10).each {|a| @statistics << "#{a[1]}," << "#{a[0]},"} 
  end
  
  protected

    def logged_in?
      !!@user
    end

    def current_user
      @user
    end

    def require_login
      unless logged_in?
        redirect_to :action => :login
      end
    end

    def facebook_auth
      @oauth = Koala::Facebook::OAuth.new(FACEBOOK_APP_ID, FACEBOOK_SECRET_KEY)
      if fb_user_info = @oauth.get_user_info_from_cookie(request.cookies)
        @graph = Koala::Facebook::API.new(fb_user_info['access_token'])
        @user = User.new(@graph, fb_user_info['user_id'])
      end
    end
end
