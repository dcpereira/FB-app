$(document).ready(function() {
	$('#friend_selector').change(function(){
	$('#in_p').show();
	$('#posts_content').hide();
	var selected_friend= $("#friend_selector option:selected").val();	
	$.post("/facebook/fetch_posts", {selected_friend: selected_friend})
	    .error(function() { 
				alert("Request Error - There seems to be a connection error. Please try again later."); 
				$('#in_p').hide();
		})
	});
});
