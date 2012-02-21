class FacebookController < ApplicationController

  before_filter :facebook_auth
  before_filter :require_login, :except => :login
  helper_method :logged_in?, :current_user
  
  def index
    @friends = current_user.get_friends 
  end

  def login    
  end
  
  def fetch_posts
    @sel_friend = params[:selected_friend]
    posts = @graph.fql_query("
          SELECT fromid 
          FROM comment 
          WHERE post_id IN 
            (SELECT post_id 
             FROM stream 
             WHERE source_id = '#{@sel_friend}'  limit 300) 
             AND fromid != '#{@sel_friend}'
    ")
    commenter_ids = []
    stats = Hash.new(0)
    posts.each do |id|
      stats[id['fromid']] += 1
      commenter_ids << id['fromid']
    end
    commenter_ids = commenter_ids.join(",")
    names = @graph.fql_query(" 
     SELECT name , uid
     FROM user 
     WHERE uid IN (#{commenter_ids})
       ")
    @statistics = ""
    unsorted_statistics = []
    names.each do |name|
      unsorted_statistics << [stats[name['uid']], name['name']]
    end
    unsorted_statistics.sort!.reverse!
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
