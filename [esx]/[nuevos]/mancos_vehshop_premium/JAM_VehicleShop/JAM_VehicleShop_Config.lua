JAM.VehicleShop = {}
local JVS = JAM.VehicleShop
JVS.ESX = JAM.ESX

JVS.DrawTextDist = 4.0
JVS.MenuUseDist = 3.0
JVS.SpawnVehDist = 50.0
JVS.VehRetDist = 5.0

JVS.CarDealerJobLabel = "mancosclub"
JVS.DealerMarkerPos = vector3(-203.4, -1342.69, 30.89)

-- Why vector4's, you ask?
-- X, Y, Z, Heading.

JVS.PurchasedCarPos = vector4(-205.77, -1313.14, 31.20, 358.49) --Salida del vehiculo comprado
--JVS.PurchasedUtilPos = vector4(-17.88, -1113.94, 26.67, 158.04) -- grua para embargar

JVS.SmallSpawnVeh = 'chiron'
JVS.SmallSpawnPos = vector4(-211.81, -1324.41, 30.89, 28.22)

--JVS.LargeSpawnVeh = 'towtruck'
--JVS.LargeSpawnPos = vector4(-18.57, -1103.14, 26.67, 159.95)

JVS.DisplayPositions = {
	[1] = vector4(-223.33, -1330.52, 30.89, 300.75),
	[2] = vector4(-223.38, -1322.58, 30.89, 227.48),
	--[3] = vector4(-211.81, -1323.41, 30.89, 28.22), --LFERRARI
	--[4] = vector4(-209.21, -1324.41, 30.89, 355.355),
	[5] = vector4(-223.36, -1326.73, 30.89, 268.66),
	--[6] = vector4(-206.02, -1324.77, 30.89, 276.87),
}

JVS.Blips = {
	CityShop = {
		Zone = "Benny's",
		Sprite = 523,
		Scale = 1.0,
		Display = 4,
		Color = 8,
		Pos = { x = -205.48, y = -1306.92, z = 31.00 },
	},
}
