var job = "";

$(function () {

    $(document).ready(() => {
        $('.container-loader').fadeOut('fast');
    })

    function display(bool) {
        if (bool) {
            $("#container").show();

            // Hide data
            $('#msgData').text("");
            $('#msgError').text("");
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
                //console.log("ENABLED TRUE");
            } else {
                display(false)
                //console.log("ENABLED FALSE");
            }
        }

        // Save job
        if (item.type === "job") {

            // Check mechanic
            if (item.job.toLowerCase() === 'mechanic') {
                $('#check').hide();
                $('.cont-mechanic').show();
            }

            this.job = item.job;
        }

        if (item.data != null || item.data != "") {
            $('.container-loader').fadeOut('fast');
            $('#msgData').text(item.data);
        }

            if (item.type === 'restart') {
                //console.log("RESTART");
                // Restart form
            $('input').val('');
        }
        

    })
    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://marker-billing/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $("#strId").val("");
        $.post('http://marker-billing/exit', JSON.stringify({}));
        return
    })

    // Buscar total billing usuario
    $("#check").click(function () {
        let strId = $("#strId").val();
        

        if (!strId) {
            $('#msgData').text("Indique un indentificador de usuario!");
            return
        }

    
        // Hide data
        $('#msgData').text("");
        $('.container-loader').fadeIn('fast');

        $.post('http://marker-billing/searchUser', JSON.stringify({
            strId: strId,
            strJob: job
            //date: GetFormatDate(new Date())
        }));
        return;
    })

    // Tramitar billing
    $("#billing").click(function () {
        let strId = $("#strId").val();
        let strDescription = $("#strDescription").val();
        let strNote = $("#strNote").val();
        let strTotal = $("#strTotal").val();

        if (job.toLowerCase() === 'mechanic') {
            
            if (!strId) {
                $('#msgData').text("Indique un indentificador de usuario.");
                return
            }

            if (!strDescription) {
                $('#msgData').text("Indique la descripción de la factura!");
                return
            }

            if (!strTotal) {
                $('#msgData').text("Indique el importe total de la factura!");
                return
            }
            
            $.post('http://marker-billing/billingMechanic', JSON.stringify({
                strId: strId,
                strDescription: strDescription,
                strNote: strNote,
                strTotal: strTotal,
                date: GetFormatDate(new Date())
            }));
            return;
        } else {
            // Hide data
            $('#msgData').text("");
            $('.container-loader').fadeIn('fast');

            $.post('http://marker-billing/billing', JSON.stringify({
                strId: strId,
                date: GetFormatDate(new Date())
            }));
            return;
        }
          
    })

    
    function GetFormatDate(strDate) {
        var date = new Date(strDate);
        
        var month = date.getMonth() + 1; 
          
        return (
        date.getFullYear() + '-' +
        (month.length == 1 ? '0' + month : month) + '-' +
        (date.getDate().toString().length == 1 ? '0' + date.getDate() :  date.getDate()) + ' ' + 
        (date.getHours().toString().length == 1 ? '0' + date.getHours() :  date.getHours()) + ":" + 
        (date.getMinutes().toString().length == 1 ? '0' + date.getMinutes() :  date.getMinutes()));
    }
    
})

// ------------------------------