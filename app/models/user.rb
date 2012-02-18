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
    @friends ||= @graph.get_connections(uid,'friends')
  end
  
  def get_friend_feed friend_uid
    @friend_feed ||= @graph.get_object(friend_uid,'feed')
    
  end
end
