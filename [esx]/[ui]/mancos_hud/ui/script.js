$(document).ready(function(){
	window.addEventListener("message", function(event) {
		if (event.data.action == "setValue") {
			setValue(event.data.key, event.data.value)
		} else if (event.data.action == "updateJobsOnline") {
			$('.job#ambulance .job_count').html(event.data.emsonline);
			$('.job#police .job_count').html(event.data.policeonline);
			$('.job#mechanic .job_count').html(event.data.mechaniconline);
			$('.job#taxi .job_count').html(event.data.taxionline);
		} else if (event.data.action == "updateStatus") {
			updateStatus(event.data.status);
		} else if (event.data.action == "toggle_watermark") {
			if (event.data.show) {
				$('#imageserver').show();
			} else {
				$('#imageserver').hide();
			}
		} else if (event.data.action == "toggle") {
			if (event.data.show) {
				$('body').show();
			} else {
				$('body').hide();
			}
		} else if (event.data.action == "setMugshot") {
			setMugshot(event.data.value);
		}
	});
	
	function setValue(key, value) {
		$('.number#'+key).html(value)
	}
	
	function setMugshot(url) {
		$('.profile img').attr("src", url)
	}
	
	function updateStatus(status) {
		var hunger = status[0];
		var thirst = status[1];
		$('.progress-hunger').width( (Math.round(hunger.percent)) );
		$('.progress-thirst').width( (Math.round(thirst.percent)) );
	}
});
