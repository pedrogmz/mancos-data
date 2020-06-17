window.addEventListener('message', function (event) {
	
	var action = event.data.action
	
	if (action == "updateStatusHud") {
		$("body").css("display", event.data.show ? "block" : "none");
		$("#boxSetHealth").css("width", event.data.health + "%");
		$("#boxSetArmour").css("width", event.data.armour + "%");
		widthHeightSplit(event.data.oxygen, $("#boxSetOxygen"));
	}
	
	if (action == "updateStatus") {
		updateStatus(event.data.status);
	}
});

function widthHeightSplit(value, ele) {
    let height = 25.5;
    let eleHeight = (value / 100) * height;
    let leftOverHeight = height - eleHeight;

    ele.css("height", eleHeight + "px");
    ele.css("top", leftOverHeight + "px");
};

function updateStatus(status) {
	var hunger = status[0];
	var thirst = status[1];
	var stress = status[2];
	widthHeightSplit(hunger.percent, $("#boxSetHunger"));
	widthHeightSplit(thirst.percent, $("#boxSetThirst"));
	widthHeightSplit(stress.percent, $("#boxSetStress"));
}