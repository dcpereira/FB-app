require 'net/http'
require 'uri'
require 'open-uri'

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
    posts = @graph.fql_query("
          SELECT fromid 
          FROM comment 
          WHERE post_id IN 
            (SELECT post_id 
             FROM stream 
             WHERE source_id = '#{params[:selected_friend]}'  limit 100) 
             AND fromid != '#{params[:selected_friend]}'
    ")
    
      # @friends_friends ||= @graph.get_connections(params[:selected_friend],'friends')
    commenter_ids = []
    stats = Hash.new(0)
    posts.each do |id|
      stats[id['fromid']] += 1
      commenter_ids << id['fromid']
    end
    commenter_ids = commenter_ids.join(",")
    @names = @graph.fql_query(" 
     SELECT name 
     FROM user 
     WHERE uid IN (#{commenter_ids})
       ")
    @friend_feed = stats
    
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
