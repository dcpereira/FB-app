$(document).ready(function() {
	$('#friend_selector').change(function(){
	$('#in_p').show();
	$('#posts_content').hide();
	var selected_friend= $("#friend_selector option:selected").val();	
	$.post("/facebook/fetch_posts", {selected_friend: selected_friend},
	function() {
	      alert("success");
	    })
	    .success(function() { alert("second success"); })
	    .error(function() { alert("error"); })
	    .complete(function() { alert("complete"); });
	});
});
