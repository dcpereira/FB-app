require 'spec_helper'

describe User do
  before do
    @graph = mock('graph api')
    @uid = 55
    @user = User.new(@graph, @uid)
  end

  describe 'retrieving friends' do
    before do
      @friends = [
            {
               "name"=> "Bruce Willis",
               "id"=> "284741398"
            },
            {
               "name"=> "Tom Jones",
               "id"=> "504562425"
            },
            {
               "name"=> "The Queen",
               "id"=> "6627242827"
            },
            {
               "name"=> "Chuck Norris",
               "id"=> "584913702"
            }
          ]
      @graph.should_receive(:get_connections).with(@uid, 'friends').once.and_return(@friends)
    end
    
    describe 'get_friends' do
      it 'should retrieve friends using the graph api' do
        @user.get_friends.should equal(@friends)
      end
    end
    
    it 'should memorize the result after the first call' do
      friends1 = @user.get_friends
      friends2 = @user.get_friends
      friends2.should equal(friends1)
    end
  end
end

