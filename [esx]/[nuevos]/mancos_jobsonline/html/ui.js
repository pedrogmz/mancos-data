$(document).ready(function() {
    window.addEventListener("message", function(event) {
        let action = event.data.action;
        let data = event.data;

        // Update jobs online
        if (action == "updateJobsOnline") {
            jobOnlineColor(event.data.emsonline, '.job#ambulance .job_count', 'ambulance');
            jobOnlineColor(event.data.policeonline, '.job#police .job_count', 'police');
            jobOnlineColor(event.data.mechaniconline, '.job#mechanic .job_count', 'mechanic');
            jobOnlineColor(event.data.barmanonline, '.job#barman .job_count', 'barman');
            jobOnlineColor(event.data.taxionline, '.job#taxi .job_count', 'taxi');
            jobOnlineColor(event.data.cardeleronline, '.job#cardealer .job_count', 'cardealer');
            jobOnlineColor(event.data.tenderonline, '.job#tendero .job_count', 'tendero');
            jobOnlineColor(event.data.bahamasonline, '.job#bahamas .job_count', 'tendero');
            jobOnlineColor(event.data.mancosclubonline, '.job#mancosclub .job_count', 'tendero');
        }

        if (action == "toggle") {
            if (event.data.show) {
                $('body').show();
            } else {
                $('body').hide();
            }
        }

    });

    function jobOnlineColor(online, selector, job) {

        var color = ""

        if (online == undefined || online == "" || online == null) {
            online = 0;
        }

        online = parseInt(online);

        /*
		if (online >= 0 && online < 3) {
            color = "#fa2f2f";
		} else if (online == 3) {
            color = "#ff6c00";
		} else if (online > 3) {
            color = "#20b751";
		}
		*/

        if (job != 'police') {
            if (online == 0) {
                color = "#fa2f2f";
            } else {
                color = "#20b751";
            }
        } else {
            if (online == 0) {
                color = "#fa2f2f";
            } else if (online == 1) {
                color = "#ff6c00";
            } else if (online == 2 || online == 3) {
                color = '#f4ff81'
            } else if (online >= 4) {
                color = "#20b751";
            }
        }

		$(selector).text( online > 3 ? '3+' : online );
        $(selector).css("background-image", "url()");
        $(selector).css('background-color', color);
    }
});