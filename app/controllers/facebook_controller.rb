require 'net/http'
require 'uri'
require 'open-uri'

class FacebookController < ApplicationController

  before_filter :facebook_auth
  before_filter :require_login, :except => :login

  helper_method :logged_in?, :current_user
  
  def index
    @likes_by_category = current_user.likes_by_category
    @friends = current_user.get_friends
    # @friends=[{"name"=>"Xavier Malcolm Gomes", "id"=>"285001398"}, {"name"=>"Farha Iqbal", "id"=>"502122425"}]
  end

  def login    
  end
  
  def fetch_posts
    # friend_uid =
    # c_user = User.new(@graph, friend_uid)
    # @friend_feed = c_user.get_friend_feed friend_uid
    
    # @friend_feed = []
    @friend_feed ||= @graph.get_connections(params[:selected_friend], "feed")
    @message,counter = [], 0
    # unless @friend_feed.nil?
    results ||= @friend_feed.next_page
    while((result != nil) || (counter <= 5 && results.next_page != nil)) 
      counter += 1
      results = results.next_page
      @message << results
    end
      
    # end
    #    @messages << f['message'] if f['message']
    # @next_page = @friend_feed.next_page
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
        @graph = Koala::Facebook::GraphAPI.new(fb_user_info['access_token'])
        @user = User.new(@graph, fb_user_info['user_id'])
      end
    end
end
