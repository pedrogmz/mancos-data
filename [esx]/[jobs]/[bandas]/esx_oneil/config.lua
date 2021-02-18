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

Config.AuthorizedVehicles = {
	{ name = "mule3", label = 'Camión' },
	{ name = "burrito", label = 'Furgoneta' },
	{ name = "buffalo", label = 'Coche 4 puertas' },
	{ name = "sanchez2", label = 'Moto' },
}

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
		Pos   = { x = 2455.9, y = 4993.98, z = 45.81 },
		Size  = { x = 1.5, y = 1.5, z = 2.0 },
		Color = { r = 92, g = 16, b = 140 },
		Type  = 23,
	},

	-- Armero
	Vaults = {
		Pos   = { x = 2444.54, y = 4966.3, z = 45.81 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 92, g = 16, b = 140 },
		Type  = 23,
	},

	Fridge = {
		Pos   = { x = 2440.72, y = 4974.82, z = 45.81 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 92, g = 16, b = 140 },
		Type  = 23,
	},

	BossActions = {
		Pos   = { x = 2445.23, y = 4988.67, z = 45.81 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 92, g = 16, b = 140 },
		Type  = 23,
	},

	Vehicles = {
		Pos          = { x = 2437.02, y = 4943.49, z = 43.98 },
		SpawnPoint   = { x = 2436.32, y = 4942.9, z = 45.06, h = 226.89 },
		Size         = { x = 1.8, y = 1.8, z = 1.0 },
		Color        = { r = 255, g = 255, b = 0 },
		Type         = 23,
		Heading      = 226.89,
	},

	VehicleDeleters = {
		Pos   = { x = 2432.73, y = 4949.99, z = 44.86 },
		Size  = { x = 3.0, y = 3.0, z = 0.2 },
		Color = { r = 255, g = 255, b = 0 },
		Type  = 23,
	},
}
