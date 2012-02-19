$(document).ready(function() {
	$('#analyze_button').click(function(){
	var selected_friend= $("#friend_selector option:selected").val();	
	var pie_data = $("#chart_data").val();
	$.post("/facebook/fetch_posts", {selected_friend: selected_friend});
		alert(pie_data);
	});
});


	
	
	  