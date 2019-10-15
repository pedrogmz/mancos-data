$(document).ready(function(){
	window.addEventListener("message", function(event) {
		let action = event.data.action;
		if (action == "setValue") {
			setValue(event.data.key, event.data.value);
		} else if (action == "updateJobsOnline") {
			jobOnlineColor(event.data.emsonline, '.job#ambulance .job_count');
			jobOnlineColor(event.data.policeonline, '.job#police .job_count');
			jobOnlineColor(event.data.mechaniconline, '.job#mechanic .job_count');
			jobOnlineColor(event.data.taxionline, '.job#taxi .job_count');
		} else if (action == "updateStatus") {
			updateStatus(event.data.status);
		} else if (action == "updateHealth") {
			updateHealth(event.data.status);
		} else if (action == "toggle_watermark") {
			if (event.data.show) {
				$('#imageserver').show();
			} else {
				$('#imageserver').hide();
			}
		} else if (action == "toggle") {
			if (event.data.show) {
				$('body').show();
			} else {
				$('body').hide();
			}
		} else if (action == "openMenu") {
			OpenMenuAnim(event.data.menu);
		}
	});
	
	function OpenMenuAnim(menu) {
		$('.action#'+menu).toggleClass('active');
	}
	
	function jobOnlineColor(online, selector) {
		if (online >= 0 || online < 3) {
			$(selector).css('background-color', '#fa2f2f');
		} else if (online == 3) {
			$(selector).css('background-color', '#ff6c00');
		} else if (online > 3) {
			$(selector).css('background-color', '#20b751');
		}
	}
	
	function setValue(key, value) {
		$('#'+key+' span').html(value)
	}
	
	// Hunger Thrist
	function updateStatus(status) {
		var hunger = status[0];
		var thirst = status[1];
		$('#hunger_bar').width( (Math.round(hunger.percent))+'%' );
		$('#thirst_bar').width( (Math.round(thirst.percent))+'%' );
	}
	
	function updateHealth(status) {
		var health = status['health'];
		var	stamina = status['stamina'];
		$('#health_bar').width( health+'%' );
		$('#stamina_bar').width( stamina+'%' );
	}
});
