class User
  attr_accessor :uid, :graph

  def initialize(graph, uid)
    @graph = graph
    @uid = uid
  end

  def likes
    @likes ||= graph.get_connections(uid, 'likes')
  end

  def likes_by_category
    @likes_by_category ||= likes.sort_by {|l| l['name']}.group_by {|l| l['category']}.sort
  end
  
  def get_friends
    @friends ||= graph.get_connections(uid,'friends')
  end
  
  def get_friend_feed friend_id
    # @friend_feed ||= @graph.get_connections(friend_uid, 'feed')
     @friend_feed ||= graph.get_connections('Amy', "feed")
    
  end
end
