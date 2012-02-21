$(document).ready(function() {
	$('#friend_selector').change(function(){
	$('#in_p').show();
	$('#posts_content').hide();
	var selected_friend= $("#friend_selector option:selected").val();	
	var friend_name = $("#friend_selector option:selected").text();	
	$.post("/facebook/fetch_posts", {selected_friend: selected_friend, friend_name: friend_name}, function(){
		
	var data_string = $("#chart_data").attr("value");
	 if((data_string != "") && (typeof data_string != "undefined") && (data_string != null)){
			$('chart_head').show();
			data_string = data_string.slice(0, -1);
			var array = data_string.split(",");
			var data = [];
			var counter = 0;
			for(var i = 0; i<array.length-1; i++){
			  data[counter] = { label: ""+array[i], data: parseInt(array[i+1]) }
				counter++;
				i++;
			}
			$.plot($("#interactive"), data,
			{
				series: {
					pie: {
						innerRadius: 0.65,
						show: true
					}
				},
		     grid: {
		       hoverable: true,
		       clickable: true
		      },
					legend: {
						show: true
					},
					xaxis: {
						show: false
					}
			});
			$("#interactive").bind("plothover", pieHover);
			$("#interactive").bind("plotclick", pieClick);
		}
		else
		  {
		  alert("Oops - This friend hasn't had any comments for a very long time! Try another.");
		  }
	})
	    .error(function() { 
				alert("Request Error - There seems to be a connection error. Please try again later."); 
				$('#in_p').hide();
		});
	});
});
