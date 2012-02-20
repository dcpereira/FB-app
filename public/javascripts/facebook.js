$(document).ready(function() {
	$('#friend_selector').change(function(){
	alert('works');
	var selected_friend= $("#friend_selector option:selected").val();	
	$.post("/facebook/fetch_posts", {selected_friend: selected_friend});
	
	
	});
});


	
	
	  