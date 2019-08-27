(function () {
	$('.btn').click(function () {
		$(this).toggleClass('active');
		return $(this).parent('.content').find('.box').toggleClass('open');
	});
}).call(this);

$(".play-char").click(function () {
	let charid = $(this).attr('id');
	let ischar = $(this).attr('data-ischar');
    $.post("http://esx_kashacters/CharacterChosen", JSON.stringify({
        charid: charid,
        ischar: ischar
    }));
    Kashacter.CloseUI();
});

$(".delete-char").click(function () {
    $.post("http://esx_kashacters/DeleteCharacter", JSON.stringify({
        charid: $(this).attr("id"),
    }));
    Kashacter.CloseUI();
});

(() => {
    Kashacter = {};

    Kashacter.ShowUI = function(data) {
        $('.main-container').css({"display":"block"});
        if(data.characters !== null) {
            $.each(data.characters, function (index, char) {
                if (char.charid !== 0) {
                    var charid = char.identifier.charAt(4);
					$('.character-container').append('<div class="profile"><div class="photo"><img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/764024/profile/profile-512.jpg"/></div><div class="content"><div class="text"><h3>'+ char.firstname +' '+ char.lastname +'</h3><h6>'+ char.job +'</h6></div><div class="btn"><span></span></div></div><div class="box"><i class="fa fa-play play-char" data-ischar="true" id="'+charid+'"></i><i class="fa fa-trash-alt delete-char" id="'+charid+'" data-toggle="modal" data-target="#delete-char"></i></div></div>');
                }
            });
        }
    };

    Kashacter.CloseUI = function() {
        $('.main-container').css({"display":"none"});
    };
	
    window.onload = function(e) {
        window.addEventListener('message', function(event) {
            switch(event.data.action) {
                case 'openui':
                    Kashacter.ShowUI(event.data);
                    break;
            }
        })
    }

})();