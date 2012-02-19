$(document).ready(function() {
	$('#analyze_button').click(function(){
	var selected_friend= $("#friend_selector option:selected").val();	
	var cdd= $("#chart_data").val();
	alert(cdd);
	


	
	$.post("/facebook/fetch_posts", {selected_friend: selected_friend});
	});
});


	
	
	  