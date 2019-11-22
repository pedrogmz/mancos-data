var inputPenal = {};
var arrayArticle = [];
var strId = 0;
var strName = "";
var penalty = {
    description: [],
    amount: 0,
    term: 0
}

$(function () {

    $(document).ready(() => {
        $('.container-loader').fadeOut('fast');
    })

    function display(bool) {
        if (bool) {
            $("#container").show();
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

                strId = item.id;
                strName = item.playername;

                // Display data
                $('#input').val(item.id);
                $('#userName').text("Nombre: " + item.playername);
            } else {
                display(false)
            }
        }

        // Print penal code
        if (item.type === "penal") {
            printPenal(item.data);
        }

        // Show message
        if (item.type === "money") {
            $('#msgError').text(item.data);
        }

        // Restart data
        if (item.type === "restart") {
            
            penalty = {
                description: [],
                amount: 0,
                term: 0
            }

            $('.penal').remove();

            // Ocultar lista
            if (penalty.description.length == 0) {
                $('.collection').fadeOut("fast", () => {
                    $('#msgEmpty').fadeIn("fast");
                    $('#totalAmount').fadeOut("fast");
                });
            }
        }
    })

    $("#close").click(function () {
        $.post('http://esx_policejob/exit', JSON.stringify({}));
        return
    })


    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://esx_policejob/exit', JSON.stringify({}));
            return
        }
    };


    function printPenal(data) {
        
        var obj = JSON.parse(data);
        var name;

        obj.forEach(function(element) {

            var item =  {
                tablargename: element['TABANAME'] + " - " + element['TABADESCRIPTION'],
                id: element['id'],
                tabaidchapter: element['TABAIDCHAPTER'],
                tabaname: element['TABANAME'],
                tabadescription: element['TABADESCRIPTION'],
                tabaamount: element['TABAAMOUNT'],
                tabaterm: element['TABATERM'],
                tabalastupdate: element['TABALASTUPDATE']
            }
            
            arrayArticle.push(item);

            name = element['TABANAME'] + " - " + element['TABADESCRIPTION'];
            inputPenal[name] = null;

            //  inputUsers.<?php echo (str_replace(' ', '',$row['firstname'])."_".str_replace(' ', '', $row['lastname'])); ?> = 'views/images/uploads/police/' + "<?php echo $image; ?>";
        });
    
        $('input.autocomplete').autocomplete({
            data: inputPenal,
            onAutocomplete: function (value, callback) {
                $('#autocomplete-input').val("");

                addPenal(value);

                $('#autocomplete-input').focus()
            }
        });
        
    }

    // Add penal element
    function addPenal(value) {

        var split = value.split('-');

        // Buscamos el artículo
        var article = arrayArticle.find(function(obj) {
            return obj.tablargename == value;
        });

        var penal = penalty.description.find(function(obj) {
            return obj.name == article.tabaname;
        });

        if (penal != undefined) {
            $('#msgError').text("El artículo penal ya fue asignado anteriormente!");
        } else {
            penalty.description.push({ id: article.id, name: article.tabaname, description: article.tabadescription, amount: article.tabaamount, term: article.tabaterm });
            penalty.amount = parseInt(penalty.amount) + parseInt(article.tabaamount);
            penalty.term = parseInt(penalty.term) + parseInt(article.tabaterm);

            // Añadir elemento al html
            $('<li class="collection-item grey darken-3 penal""><p><span class="new badge teal darken-3" data-badge-caption="" style="float: left; margin: 0px 15px 0px 0px;">' + split[0] + '</span><div>' + split[1]+ '<a href="#!" class="secondary-content"><i id="' + article.id + '" class="material-icons white-text" onclick="delElement(this)">close</i></a></div></li>').appendTo('.collection');

            $('#totalAmount').text("Total : " + penalty.amount + "€");
            
            // Mensaje ok!
            $('#msgError').text("Artículo añadido!");

            // Mostrar lista
            if (penalty.description.length > 0) {
                $('.collection').fadeIn("fast", () => {
                    $('#msgEmpty').fadeOut("fast");

                    $('#totalAmount').fadeIn("fast");
                });
            }
        }
    }

})

  // Delete penal element
  function delElement(element) {

    var id = $(element).attr('id');

    var penal = arrayArticle.find(function(obj) {
        return obj.id == id;
      });

    var pos = penalty.description.map(function(e) { return e.id; }).indexOf(id);

    // Remove elements
    penalty.description.splice(pos, 1);
    penalty.amount -= parseInt(penal.tabaamount);
    penalty.term -= parseInt(penal.tabaterm);

    // Remove element from list
    $(element).parent().parent().parent().remove();

    // Add total amount / mostrar total
    $('#totalAmount').text("Total : " + penalty.amount + "€");
    
     // Mensaje ok!
     $('#msgError').text("Artículo eliminado!");

    // Ocultar lista
    if (penalty.description.length == 0) {
        $('.collection').fadeOut("fast", () => {
            $('#msgEmpty').fadeIn("fast");
            $('#totalAmount').fadeOut("fast");
        });
    }
     
}

// Aplicar multas / delitos
function processPenal() {
    if (penalty.description.length == 0) {
        $('#msgError').text("Ningún delito seleccionado!");
    } else {
        $.post('http://esx_policejob/processPenal', JSON.stringify({
            strId: strId,
            strData: JSON.stringify(penalty),
            strDate: GetFormatDate(new Date()),
            strName: strName
        }));
    }
}

// Get Format date
function GetFormatDate(strDate) {
	var date = new Date(strDate);
	
	var month = date.getMonth() + 1; 
	  
	return (
    date.getFullYear() + '-' +
    (month.length = 1 ? '0' + month : month) + '-' +
	(date.getDate().toString().length == 1 ? '0' + date.getDate() :  date.getDate()) + ' ' + 
    (date.getHours().toString().length == 1 ? '0' + date.getHours() :  date.getHours()) + ":" + 
    (date.getMinutes().toString().length == 1 ? '0' + date.getMinutes() :  date.getMinutes()));
}





// ------------------------------