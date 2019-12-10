var elements = [];

$(function() {

    $(document).ready(() => {

    })

    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false);

    window.addEventListener('message', function(event) {

        var item = event.data;

        if (item.type == "ui") {
            if (item.status == true) {
                display(true)

                addElement(item.data);

            }
        }

        if (item.type == "inRoute") {
            $('.elements').find('div').first().remove();

            $('<div class="display"><p>Aviso confirmado. Pulsa <span class="red-text"><b>[F10]</b></span> para cancelar.</p></div>').appendTo('.inRoute');
        }

        if (item.type == "delRoute") {

            if (item.delete == true) {
                $('.elements').find('div').first().remove();
            }
            //$('.elements').find('div').first().remove();

            $('.inRoute').empty();
        }
    })

});


function addElement(item) {

    if (item != null) {

        var hash = GetHash();

        $('<div class="display p' + hash + '"><p>' + item.Id + " - " + item.Description + '<span class="green-text"><b>[F9]</b></span><span class="red-text"><b>[F10]</b></span><span class="counter"><b class="timer' + hash + '">[30]</b></span></p></div>').appendTo('.elements');

        timer(hash, item); // Timer

    }
};


function GetHash() {
    var date = new Date();

    var month = date.getMonth() + 1;

    return (
        date.getFullYear() +
        (month.length = 1 ? '0' + month : month) +
        (date.getDate().toString().length == 1 ? '0' + date.getDate() : date.getDate()) +
        (date.getHours().toString().length == 1 ? '0' + date.getHours() : date.getHours()) +
        (date.getMinutes().toString().length == 1 ? '0' + date.getMinutes() : date.getMinutes()) + date.getUTCMilliseconds());
}

function timer(hash, item) {

    var counter = 30;

    setInterval(function() {

        if (counter == 0) {

            $('.p' + hash).remove();

            clearInterval($(this));

            $.post('http://esx_aviso/delElement', JSON.stringify(item));

        }

        $('.timer' + hash).text("[" + counter + "]");

        counter--;
    }, 1000);
}