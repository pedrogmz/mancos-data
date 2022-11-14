Config = {}

Config.Locale = 'es'

Config.Delays = {
	WeedProcessing = 1000 * 10,
	CokeProcessing = 1000 * 10
}

Config.DrugDealerItems = {
	bagofdope = 400,
	coke_pooch = 1000
}

Config.LicenseEnable = false -- enable processing licenses? The player will be required to buy a license in order to process drugs. Requires esx_license

Config.LicensePrices = {
	weed_processing = {label = _U('license_weed'), price = 15000},
	coke_processing = {label = _U('license_coke'), price = 15000}
}

Config.GiveBlack = true -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {
	WeedField = {coords = vector3(-1653.13, 4584.02, 42.89), name = _U('blip_weedfield'), color = 25, sprite = 496, radius = 100.0},
	WeedProcessing = {coords = vector3(-11, -1433.73, 31.12), name = _U('blip_weedprocessing'), color = 25, sprite = 496, radius = 0.0},
	CokeField = {coords = vector3(-1833.4, 2176.7, 107.2), name = _U('blip_cokefield'), color = 25, sprite = 496, radius = 100.0},
	CokeProcessing = {coords = vector3(1392.22, 3607.64, 38.94), name = _U('blip_cokeprocessing'), color = 25, sprite = 496, radius = 0.0},
	DrugDealer = {coords = vector3(1444.23, 1131.77, 114.33), name = _U('blip_drugdealer'), color = 6, sprite = 378, radius = 25.0},
	DrugDealerCoke = {coords = vector3(1268.97, -1710.16, 54.77), name = _U('blip_drugdealer'), color = 6, sprite = 378, radius = 25.0},
}
