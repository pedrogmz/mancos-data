$(function() {

	// Arnedo5 - New display
    function display(bool) {
        if (bool) {
			$('body').show();
            $("#container").show();
        } else {
			$('body').hide();
            $("#container").hide();
        }
    }

	display(false)
	
	window.addEventListener('message', function(event) {

		if (event.data.type == "enableui") {
			if (event.data.enable  == true) {
                display(true)
            } else {
                display(false)
            }
			// document.body.style.display = event.data.enable ? "block" : "none";
		}
		
	});

	document.onkeyup = function (data) {
		if (data.which == 27) { // Escape key
			$.post('http://esx_identity/escape', JSON.stringify({}));
		}
	};
	
	$("#signup-form").submit(function(event) {
		event.preventDefault(); // Prevent form from submitting
		
		// Verify date
		var date = $("#dob").val();
		var dateCheck = new Date($("#dob").val());

		if (dateCheck == "Invalid Date") {
			date == "invalid";
		}

		$.post('http://esx_identity/register', JSON.stringify({
			firstname: $("#firstname").val(),
			lastname: $("#lastname").val(),
			dateofbirth: date,
			sex: $("input[type='radio'][name='sex']:checked").val(),
			height: $("#height").val()
		}));
	});
});
