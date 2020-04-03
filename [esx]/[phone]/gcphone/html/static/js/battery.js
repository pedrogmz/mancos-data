window.addEventListener('message', (event) => {
	const eventType = event.data.event
	if (eventType == 'updateBatteryLevel') {
		batteryLevel = event.data.batteryLevel / 100 * 13;
		$('.batterie1').css('height', batteryLevel);
	}
})

