class User
  attr_accessor :uid, :graph

  def initialize(graph, uid)
    @graph = graph
    @uid = uid
  end

  def get_friends
    @friends ||= @graph.get_connections(uid,'friends').sort
  end

end
