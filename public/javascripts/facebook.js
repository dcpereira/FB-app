$(document).ready(function() {
	$('#analyze_button').click(function(){
	var selected_friend= $("#friend_selector option:selected").val();	
	$.post("/facebook/fetch_posts", {selected_friend: selected_friend}, function(chart_data) {
		google.load("visualization", "1", {packages:["corechart"]});
    google.setOnLoadCallback(drawChart);
    function drawChart(chart_data) {
      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Task');
      data.addColumn('number', 'Hours per Day');
      data.addRows(chart_data);

      var options = {
        width: 450, height: 300,
        title: 'MMy Top Commenters'
      };

      var chart = new google.visualization.PieChart(document.getElementById('results'));
      chart.draw(data, options);
    }
		});
	});
});


	
	
	  