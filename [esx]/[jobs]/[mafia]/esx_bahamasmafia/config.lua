Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableHelicopters          = false
Config.EnableMoneyWash            = true
Config.MaxInService               = 4
Config.Locale                     = 'es'

Config.EnableBlackMoney = true

Config.MissCraft                  = 20 -- %

Config.AuthorizedVehicles = {
	{ name = "toros", label = 'Toros' },
	{ name = "guardian", label = 'Guardian' },
	{ name = "buffalo", label = 'Coche 4 puertas' },
	{ name = "hakuchou", label = 'Hakuchou' },
}

Config.Warehouse = {
	Warehouse_in = {
		Pos          = { x = 1446.8, y = 1152.11, z = 114.33 },
		Teleport     = { x = 1446.8, y = 1152.11, z = 114.33 },  
		Size         = { x = 1.5, y = 1.5, z = 1.0 },
		Color        = { r = 92, g = 16, b = 140 },
		Type         = -1,
		Status       = "in"
	},
	Warehouse_out = {
		Pos          = { x = 1446.8, y = 1152.11, z = 114.33 },
		Teleport     = { x = 1446.8, y = 1152.11, z = 114.33 },
		Size         = { x = 1.5, y = 1.5, z = 1.0 },
		Color        = { r = 92, g = 16, b = 140 },
		Type         = 23,
		Status       = "out"
	}
}

Config.Zones = {

	-- Vestuario
	Cloakrooms = {
		Pos   = { x = 1398.53, y = 1157.0, z = 113.33 },
		Size  = { x = 1.5, y = 1.5, z = 2.0 },
		Color = { r = 92, g = 16, b = 140 },
		Type  = 23,
	},

	-- Armero
	Vaults = {
		Pos   = { x = 1397.98, y = 1163.75, z = 113.33 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 92, g = 16, b = 140 },
		Type  = 23,
	},

	Fridge = {
		Pos   = { x = 1394.58, y = 1149.77, z = 113.33 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 92, g = 16, b = 140 },
		Type  = 23,
	},

	--[[BossActions = {
		Pos   = { x = 1407.16, y = 1147.75, z = 113.33 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 92, g = 16, b = 140 },
		Type  = 23,
	},]]--

	Vehicles = {
		Pos          = { x = 1399.71, y = 1115.1, z = 113.84 },
		SpawnPoint   = { x = 1396.16, y = 1117.25, z = 114.18, h = 90.0 },
		Size         = { x = 1.8, y = 1.8, z = 1.0 },
		Color        = { r = 255, g = 255, b = 0 },
		Type         = 23,
		Heading      = 359.45,
	},

	VehicleDeleters = {
		Pos   = { x = 1395.92, y = 1116.6, z = 113.84 },
		Size  = { x = 3.0, y = 3.0, z = 0.2 },
		Color = { r = 255, g = 255, b = 0 },
		Type  = 23,
	},
}
