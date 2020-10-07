Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableHelicopters          = false
Config.EnableMoneyWash            = false
Config.MaxInService               = 4
Config.Locale                     = 'es'

Config.EnableBlackMoney = true

Config.MissCraft                  = 10 -- %

--[[Config.AuthorizedVehicles = {
	{ name = "mule3", label = 'Camión' },
	{ name = "burrito", label = 'Furgoneta' },
	{ name = "buffalo", label = 'Coche 4 puertas' },
	{ name = "sanchez2", label = 'Moto' },
}--]]

Config.Warehouse = {
	Warehouse_in = {
		Pos          = { x = 486.24, y = -591.66, z = 25.21 },
		Teleport     = { x = 997.5, y = -3200.7, z = -36.39 },  
		Size         = { x = 1.5, y = 1.5, z = 1.0 },
		Color        = { r = 92, g = 16, b = 140 },
		Type         = -1,
		Status       = "in"
	},
	Warehouse_out = {
		Pos          = { x = 997.5, y = -3200.7, z = -37.39 },
		Teleport     = { x = 486.24, y = -591.66, z = 26.21 },
		Size         = { x = 1.5, y = 1.5, z = 1.0 },
		Color        = { r = 92, g = 16, b = 140 },
		Type         = 23,
		Status       = "out"
	}
}


Config.Zones = {

	-- Vestuario
	Cloakrooms = {
		Pos   = { x = -93.13, y = -64.22, z = 57.15 },
		Size  = { x = 1.5, y = 1.5, z = 2.0 },
		Color = { r = 92, g = 16, b = 140 },
		Type  = 23,
	},

	-- Armero
	Vaults = {
		Pos   = { x = -95.14, y = -68.8, z = 57.13 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 92, g = 16, b = 140 },
		Type  = 23,
	},

	Fridge = {
		Pos   = { x = -93.24, y = -72.68, z = 61.74 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 92, g = 16, b = 140 },
		Type  = 23,
	},

	BossActions = {
		Pos   = { x = -95.72, y = -66.15, z = 61.74 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 92, g = 16, b = 140 },
		Type  = 23,
	},

	--[[Vehicles = {
		Pos          = { x = -104.17, y = -63.83, z = 0 },
		SpawnPoint   = { x = -97.67, y = -57.85, z = 0, h = 253.05 },
		Size         = { x = 1.8, y = 1.8, z = 1.0 },
		Color        = { r = 255, g = 255, b = 0 },
		Type         = 23,
		Heading      = 359.45,
	},

	VehicleDeleters = {
		Pos   = { x = -97.67, y = -57.85, z = 55.69 },
		Size  = { x = 3.0, y = 3.0, z = 0.2 },
		Color = { r = 255, g = 255, b = 0 },
		Type  = 23,
	},]]--
}
