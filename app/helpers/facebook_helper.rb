module FacebookHelper
  def facebook_login_button(size='large')
    content_tag("fb:login-button", nil , {
      :scope => 'user_likes, friends_likes, read_stream',
      :id => "fb_button_out",
      :autologoutlink => 'true',
      :size => size,
      :onlogin => 'location = "/"'})
  end

  def friend_select
    # creates drop down - using array "ID("select" option's value), Name("select" option's text)" pairs
    friends = []
    @friends.each do |f|
      friends << [f['name'], f['id']]
    end 
      select_tag 'friend', options_for_select(friends.sort), {:id => 'friend_selector'}
  end
end
