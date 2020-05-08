$(document).keyup(function(e) {
    if (e.key === "Escape") {
        $('.container-fluid').css('display', 'none');
        $.post('http://mancos_joblisting/fechar', JSON.stringify({}));
    }
});

$(document).ready(function() {
    window.addEventListener('message', function(event) {
        var item = event.data;
        var line = 1;
        var count = 1;
        var row = 1;

        if (item.ativa == true) {

            $('.inner').empty(); // Dejar el container vacio


            $('.container-fluid').css('display', 'block');

            $('.container-fluid').show();
            $.each(item.jobs, function(index, job) {


                if (line == 1) {
                    $("<div>").addClass("row cont-jquery row" + row).appendTo(".inner");
                }

                $("<div>").addClass("col s4 col" + count).appendTo(".row" + row);
                $("<div>").addClass("card card" + count).appendTo(".col" + count);
                $("<div>").addClass("card-image card-image" + count).appendTo(".card" + count);
                //$("<img>").attr("src", "images/jobs/" +job.job+".png").appendTo(".card-image" + count);

                $('<div>').css('background-image', 'url(images/jobs/' + job.job + '.png)').addClass('background-card background-card' + count).appendTo(".card-image" + count);

                $("<div>").addClass("card-content card-content" + count).appendTo(".card" + count);
                $("<p>").addClass("p1" + count).text(job.label).appendTo(".card-content" + count);
                $("<div>").addClass("card-action card-action" + count).appendTo(".card" + count);
                $("<a>").addClass("black-text interview").attr("id", job.job).text('Aceptar trabajo').appendTo(".card-action" + count);

                //$(".inner").append('<div class="job"><button class="tittle">'+job.label+'</button><img src="images/jobs/'+job.job+'.png" height="100" width="100"><button id="'+job.job+'" class="interview">Aceptar trabajo</button></div>');

                if (line == 3) {
                    line = 1;
                    row++;
                } else {
                    line++;
                }

                count++;

            });
            //mapCards();

        } else if (item.ativa == false) {
            $('.container-fluid').css('display', 'none');
        }
    });
})

$("body").on('click', '.interview', function() {
    $.post('http://mancos_joblisting/setJob', JSON.stringify({
        job: $(this).attr('id')
    }));
    $.post('http://mancos_joblisting/fechar', JSON.stringify({}));
});

let scale = 0;
const cards = Array.from(document.getElementsByClassName("job"));
const inner = document.querySelector(".inner");

function slideAndScale() {
    cards.map((card, i) => {
        card.setAttribute("data-scale", i + scale);
        inner.style.transform = "translateX(" + scale * 8.5 + "em)";
    });
}

function mapCards() {
    slideAndScale();
    cards.map((card, i) => {
        card.addEventListener("click", () => {
            const id = card.getAttribute("data-scale");
            if (id !== 2) {
                scale -= id - 2;
                slideAndScale();
            }
        }, false);
    });
}