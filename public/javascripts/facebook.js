$(document).ready(function() {
	$('#analyze_button').click(function(){
	var selected_friend= $("#friend_selector option:selected").val();	
	var cdd= $("#chart_data").val();
	alert(cdd);
	

	      google.load("visualization", "1", {packages:["corechart"]});
	      google.setOnLoadCallback(drawChart);
	      function drawChart() {
	        var data = new google.visualization.DataTable();
	        data.addColumn('string', 'Task');
	        data.addColumn('number', 'Hours per Day');
	        var pie_data = document.getElementById('chart_data');
	        data.addRows([
	          ['Work',    11],
	          ['Eat',      2],
	          ['Commute',  2],
	          ['Watch TV', 2],
	          ['Sleep',    7]
	        ]);

	        var options = {
	          width: 450, height: 300,
	          title: 'My Daily Activities'
	        };

	        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
	        chart.draw(data, options);
	      }

	
	$.post("/facebook/fetch_posts", {selected_friend: selected_friend});
	});
});


	
	
	  