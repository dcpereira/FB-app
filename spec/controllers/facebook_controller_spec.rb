require 'spec_helper'

describe FacebookController do

  describe 'index with GET' do
    before do
      @user = User.new(mock('graph'), 55)
      @oauth = mock('oauth')
      @graph = mock('graph')
      Koala::Facebook::OAuth.should_receive(:new).and_return(@oauth)
    end

    context 'when logged into facebook' do
      before do
        user_info = {'access_token' => '1234567890', 'uid' => 55}
        @oauth.should_receive(:get_user_info_from_cookie).and_return(user_info)
        Koala::Facebook::API.should_receive(:new).with('1234567890').and_return(@graph)
        User.should_receive(:new).and_return(@user)
        @friends = mock('friends')
        @user.should_receive(:get_friends).and_return(@friends)
        get :index
      end

      it do
        response.should be_success
      end

      it 'should render ' do
        response.should render_template("facebook/index")
      end
    end

    context 'when not logged into facebook' do
      before do
        @oauth.should_receive(:get_user_info_from_cookie).and_return(nil)
        get :index
      end

      it 'should redirect to the login page' do
        response.should redirect_to(:action => :login)
      end
    end
  end

  describe 'login with GET' do
    before do
      get :login
    end

    it do
      response.should be_success
    end
  end
end
