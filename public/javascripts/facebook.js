$(document).ready(function() {
	$('#friend_selector').change(function(){
	alert('works');
	$('#in_p').show();
	var selected_friend= $("#friend_selector option:selected").val();	
	$.post("/facebook/fetch_posts", {selected_friend: selected_friend});
	
	
	});
});


	
	
	  