$(document).ready(function() {
	$('#friend_selector').change(function(){
	$('#in_p').show(); //show progress bars running, to let user know the search is taking place
	$('#posts_content').hide(); 
	var selected_friend= $("#friend_selector option:selected").val();	
	var friend_name = $("#friend_selector option:selected").text();	
	$.post("/facebook/fetch_posts", {selected_friend: selected_friend, friend_name: friend_name}, function(){
		
	var data_string = $("#chart_data").attr("value");
	 if((data_string != "") && (typeof data_string != "undefined") && (data_string != null)){
			$('chart_head').show(); // if data is available for a chart to be rendered - then display chart heading along with chart( in ajax functionality)
			// value is set as a string, this needs to be converted to an array and the elemnts need to be parsed for calculations to be made to plot the chart.
			data_string = data_string.slice(0, -1);
			var array = data_string.split(",");
			var data = [];
			var counter = 0;
			for(var i = 0; i<array.length-1; i++){
			  data[counter] = { label: ""+array[i], data: parseInt(array[i+1]) } //creating [label : object, data: object] format for plotting library
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
				$('chart_head').hide(); // if no data to render chart - don't display heading as chart won't be rendered either.
		  	alert("Oops - This friend hasn't had any comments for a very long time! Try another.");
		  }
	})
	    .error(function() { // if request timesout or any req error occurrs - The user is notified.
				alert("Request Error - There seems to be a connection error. Please try again later."); 
				$('#in_p').hide();
		});
	});
	
	function pieHover(event, pos, obj) 
	{
		if (!obj)
	                return;
		percent = parseFloat(obj.series.percent).toFixed(2);
		$("#hover_percentile").html('<span style="text-align: center; margin-left: 250; font-size: 25px; font-weight: bold; color: '+obj.series.color+'">'+percent+'%</span>');

		$("#hover_name").html('<span style="text-align: center; margin-left: 250; font-size: 15px; font-weight: bold; color: '+obj.series.color+'">'+obj.series.label+'</span>');
	}

	function pieClick(event, pos, obj) 
	{
		if (!obj)
	                return;
		percent = parseFloat(obj.series.percent).toFixed(2);
		alert(''+obj.series.label+': '+percent+'%');
	}
	
});
