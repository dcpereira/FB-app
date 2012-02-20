$(document).ready(function() {
	$('#friend_selector').change(function(){
	var selected_friend= $("#friend_selector option:selected").val();	
	var cdd= $("#chart_data").val();
	$('#wait').add('<p>Ranking wall - One moment please...</p>')
	$.post("/facebook/fetch_posts", {selected_friend: selected_friend});
	
	
	});
});


	
	
	  