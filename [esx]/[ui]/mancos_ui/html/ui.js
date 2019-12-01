$(document).ready(function(){
	window.addEventListener("message", function(event) {
        let action = event.data.action;
        let data = event.data;
        
        


        // Job / Money
		if (action == "setValue") {
			setValue(event.data.key, event.data.value);
        }
        
        // Update jobs online
        if (action == "updateJobsOnline") {
			jobOnlineColor(event.data.emsonline, '.job#ambulance .job_count');
			jobOnlineColor(event.data.policeonline, '.job#police .job_count');
            jobOnlineColor(event.data.mechaniconline, '.job#mechanic .job_count');
            jobOnlineColor(event.data.barmanonline, '.job#barman .job_count');
            jobOnlineColor(event.data.taxionline, '.job#taxi .job_count');
            jobOnlineColor(event.data.cardeleronline, '.job#cardealer .job_count');
            jobOnlineColor(event.data.tenderonline, '.job#tendero .job_count');
        }
        
        if (action == "updateStatus") {
			updateStatus(event.data.status);
        } 
        
        
        if (action == "updateHealth") {
			updateHealth(event.data.status);
        } 
        
        if (action == "toggle_watermark") {
			if (event.data.show) {
				$('#imageserver').show();
			} else {
				$('#imageserver').hide();
			}
        } 
        
        if (action == "toggle") {
			if (event.data.show) {
				$('body').show();
			} else {
				$('body').hide();
			}
        } 
        
        if (action == "openMenu") {
			OpenMenuAnim(event.data.menu);
        }
        
	});
	
	function OpenMenuAnim(menu) {
		console.log("TOOGLE");
		$('.action#'+menu).toggleClass('active');
	}
	
	function jobOnlineColor(online, selector) {

        var color = ""

        if (online == undefined || online == ""|| online == null) {
            online = 0;
        }

        online = parseInt(online);

		if (online >= 0 && online < 3) {
            color = "#fa2f2f";
		} else if (online == 3) {
            color = "#ff6c00";
		} else if (online > 3) {
            color = "#20b751";
        }
        
        $(selector).css("background-image", "url()");  
        $(selector).css('background-color', color);
        $(selector).text(online.toString());
	}
	
	function setValue(key, value) {

		value = value.toString();

		if (value.length >= 13 ) {
			value = value.slice(0, 10) + ' ...';
		}

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
