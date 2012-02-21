class User
  attr_accessor :uid, :graph

  def initialize(graph, uid)
    @graph = graph
    @uid = uid
  end

  #Gets all friends of user who logged in.
  def get_friends
    @friends ||= graph.get_connections(uid,'friends')
  end

end
