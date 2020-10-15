Config = {}
---------------------------------------------------------------
-- =====How long should it take for player to catch a fish=======--
---------------------------------------------------------------
-- Time in miliseconds
Config.FishTime = {
	a = 120000,
	b = 194000
}

--------------------------------------------------------
--=====Prices of the items players can sell==========--
--------------------------------------------------------
--First amount minimum price second maximum amount (the amount player will get is random between those two numbers)
Config.FishPrice = {a =  15, b = 15} --Will get clean money THIS PRICE IS FOR EVERY 5 FISH ITEMS (5 kg)
Config.TurtlePrice = {a = 4, b = 4} --Will get dirty money
Config.SharkPrice = {a = 4000, b = 6000} --Will get dirty money

--------------------------------------------------------
-- =====Locations where players can sell stuff========--
--------------------------------------------------------
Config.Sell = {{
	pos = vec3(-3251.2, 991.5, 11.49),
	type = "fish",
	sellText = "Comprador de Peces",
	Hide = false,
	BlipType = 356,
	BlipColour = 17,
	MarkerSize = vec3(2.0, 2.0, 2.0),
	MarkerColor = {r = 0, g = 70, b = 250, a = 100},
	MarkerType = 25,
}, {
	pos = vec3(3804.0, 4443.3, 3.20),
	type = "turtle",
	sellText = "Comprador de Tortugas",
	Hide = false,
	BlipType = 68,
	BlipColour = 49,
	MarkerSize = vec3(2.0, 2.0, 2.0),
	MarkerColor = {r = 255, g = 0, b = 0, a = 100},
	MarkerType = 25,
}, {
	pos = vec3(2517.6, 4218.0, 39.1),
	type = "shark",
	sellText = "Comprador de Tiburones",
	Hide = true,
	BlipType = 68,
	BlipColour = 49,
	MarkerSize = vec3(1.0, 1.0, 1.0),
	MarkerColor = {r = 255, g = 0, b = 0, a = 30},
	MarkerType = 25,
}}

--------------------------------------------------------
-- =====Locations where players can rent boats========--
--------------------------------------------------------
Config.MarkerZones = {{
	Marker = vec3(-3426.7, 955.66, 7.35), 	-- Rental Marker
	Spawn = vec3(-3426.2, 942.4, 1.1), 		-- Boat Spawn Point
	SpawnHeading = 90.0, 					-- Boat Heading
	Return = vec3(-3420.2, 996.51, -0.2) 	-- Boat Return Point
}, {
	Marker = vec3(-732.9, -1309.7, 4.0),
	Spawn = vec3(-725.7, -1351.5, 0.5),
	SpawnHeading = 135.0,
	Return = vec3(-712.78, -1338.49, 0.0)
}, {
	Marker = vec3(-281.25, 6632.1, 6.4),
	Spawn = vec3(-330.22, 6660.0, 1.0),
	SpawnHeading = 45.0,
	Return = vec3(-268.4, 6697.04, -0.2)
}, {
	Marker = vec3(3855.0, 4463.7, 1.6),
	Spawn = vec3(3885.2, 4507.2, 1.0),
	SpawnHeading = 300.0,
	Return = vec3(3862.1, 4440.4, -0.2)
}, {
	Marker = vec3(1330.8, 4226.6, 32.9),
	Spawn = vec3(1343.44, 4190.42, 30.0),
	SpawnSpawnHeading = 200.0,
	Return = vec3(1295.0, 4198.43, 30.0)
}}

-- 1/3 del precio será devuelto al jugador cuando devuelva el bote
Config.RentalBoats = {
	{ model = "dinghy4", price = 600 },
	{ model = "TORO", price = 900 },
	{ model = "MARQUIS", price = 1300 },
	{ model = "tug", price = 200 },
	{ model = "jetmax", price = 850 },
	{ model = "suntrap", price = 1180 },
	{ model = "seashark", price = 500 }
}
