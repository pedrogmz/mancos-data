$(document).ready(function(){
	window.addEventListener("message", function(event) {
		if (event.data.action == "updateJobsOnline") {
			$('.job#ambulance .job_count').html(event.data.emsonline);
			$('.job#police .job_count').html(event.data.policeonline);
			$('.job#mechanic .job_count').html(event.data.mechaniconline);
			$('.job#taxi .job_count').html(event.data.taxionline);
		} 
	});
});
