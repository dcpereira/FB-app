$(document).ready(function() {
	$('#friend_selector').change(function(){
		
		    REDIPS.dialog.hide('undefined');
		    REDIPS.dialog.show(150, 120, 'Simple dialog');
		    setTimeout(myHide, 5000);
		
	var selected_friend= $("#friend_selector option:selected").val();	
	$.post("/facebook/fetch_posts", {selected_friend: selected_friend});
	
	
	});
});


	
	
	  