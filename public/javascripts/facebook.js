$(document).ready(function() {
	$('#analyze_button').click(function(){
	var selected_friend= $("#friend_selector option:selected").val();	
	alert(selected_friend);
	$.post("/facebook/fetch_posts", {selected_friend: selected_friend});
	});
});