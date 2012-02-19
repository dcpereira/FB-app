$(document).ready(function() {
	$('#analyze_button').click(function(){
	var selected_friend= $("#friend_selector option:selected").val();	
	var cdd= $("#chart_data").val();
	alert(cdd);
	$.post("/facebook/fetch_posts", {selected_friend: selected_friend});
	
	
	});
	
	
	// data

	var data_array = $("#chart_data").attr("value");
	for(var i in data_array){
	  data[i] = { label: data_array[i][0], data: data_array[i][1] }
	}
	// var data = [
	// { label: "Series1", data: 10},
	// { label: "Series2", data: 30},
	// { label: "Series3", data: 90},
	// { label: "Series4", data: 70},
	// { label: "Series5", data: 80},
	// { label: "Series6", data: 110}
	// ];

	// for( var i = 0; i<data.length; i++)
	// {
	// data[i] = { label: "Series"+(i+1), data: Math.floor(Math.random()*100)+1 }
	// }

		$.plot($("#donut"), data,
		{
			series: {
				pie: {
					innerRadius: 0.5,
					show: true
				}
			}
		});
});


	
	
	  