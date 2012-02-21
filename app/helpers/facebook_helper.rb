module FacebookHelper
  def facebook_login_button(size='large')
    content_tag("fb:login-button", nil , {
      :scope => 'user_likes, friends_likes, read_stream',
      :id => "fb_login",
      :autologoutlink => 'true',
      :size => size,
      :onlogin => 'location = "/"'})
  end

  def friend_select
    friends = []
    @friends.each do |f|
      friends << [f['name'], f['id']]
    end 
      select_tag 'friend', options_for_select(friends.sort),:prompt => "--- Select ---", {:id => 'friend_selector'}
  end
end
