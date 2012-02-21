$(document).ready(function() {
	$('#friend_selector').change(function(){
	$('#in_p').show();
	$('#posts_content').hide();
	var selected_friend= $("#friend_selector option:selected").val();	
	$.post("/facebook/fetch_posts", {selected_friend: selected_friend})
	.error(function() { alert("Oops! - Looks like we're experiencing some connection problems - Sorry. Please try again later!")})
		); 
	});
});
