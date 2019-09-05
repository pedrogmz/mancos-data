$(document).keyup(function(e) {
	if (e.key === "Escape") {
		$('.container-fluid').css('display', 'none');
		$.post('http://mancos_joblisting/fechar', JSON.stringify({}));
	}
});

$(document).ready(function() {
	window.addEventListener('message', function(event) {
		var item = event.data;
		if (item.ativa == true) {
			$('.container-fluid').css('display', 'block');
			$.each(item.jobs, function (index, job) {
				$(".inner").append('<div class="job"><button class="tittle">'+job.label+'</button><img src="images/jobs/'+job.job+'.png" height="100" width="100"><button id="'+job.job+'" class="interview">Aceptar trabajo</button></div>');
			});
			mapCards();
		} else if (item.ativa == false) {
			$('.container-fluid').css('display', 'none');
		}
	});
})

$("body").on('click', '.interview',function() {
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
			console.log('cicked')
			console.log(card)
			console.log(i)
			const id = card.getAttribute("data-scale");
			if (id !== 2) {
				scale -= id - 2;
				slideAndScale();
			}
		}, false);
	});
}
