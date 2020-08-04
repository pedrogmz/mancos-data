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
		Pos   = { x = 75.57, y = -1966.71, z = 20.22 },
		Size  = { x = 1.5, y = 1.5, z = 2.0 },
		Color = { r = 92, g = 16, b = 140 },
		Type  = 23,
	},

	-- Armero
	Vaults = {
		Pos   = { x = 78.72, y = -1964.12, z = 20.12 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 92, g = 16, b = 140 },
		Type  = 23,
	},

	BossActions = {
		Pos   = { x = 82.41, y = -1960.99, z = 20.12 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 92, g = 16, b = 140 },
		Type  = 23,
	},

	Vehicles = {
		Pos          = { x = 110.8, y = -1921.59, z = 20.85 },
		SpawnPoint   = { x = 109.74, y = -1930.59, z = 20.66, h = 359.45 },
		Size         = { x = 1.8, y = 1.8, z = 1.0 },
		Color        = { r = 255, g = 255, b = 0 },
		Type         = 23,
		Heading      = 359.45,
	},

	VehicleDeleters = {
		Pos   = { x = 109.74, y = -1930.59, z = 20.66 },
		Size  = { x = 3.0, y = 3.0, z = 0.2 },
		Color = { r = 255, g = 255, b = 0 },
		Type  = 23,
	},
}

-- Trajes
Config.Uniforms = {
	pandillero_outfit = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 83,   ['torso_2'] = 1,
			['decals_1'] = -1,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 0,   ['pants_2'] = 2,
			['shoes_1'] = 26,    ['shoes_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0
		},
			female = {
			['tshirt_1'] = 14,  ['tshirt_2'] = 0,
			['torso_1'] = 76,   ['torso_2'] = 1,
			['decals_1'] = -1,   ['decals_2'] = 0,
			['arms'] = 9,
			['pants_1'] = 1,   ['pants_2'] = 3,
			['shoes_1'] = 3,   ['shoes_2'] = 3,
			['chain_1'] = 0,  ['chain_2'] = 0
		}
	},
	teniente_outfit = {
		male = {
			['tshirt_1'] = 56,  ['tshirt_2'] = 0,
			['torso_1'] = 193,   ['torso_2'] = 0,
			['decals_1'] = 42,   ['decals_2'] = 0,
			['arms'] = 42,
			['bproof_1'] = 13,  ['bproof_2'] = 0,
			['bags_1'] = 52,	['bags_2'] = 9,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['hemmet_2'] = 0,
			['chain_1'] = 6,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0
		},
		female = {
			['tshirt_1'] = 51,  ['tshirt_2'] = 0,
			['torso_1'] = 195,   ['torso_2'] = 0,
			['decals_1'] = 50,   ['decals_2'] = 0,
			['arms'] = 52,
			['bags_1'] = 52,	['bags_2'] = 9,
			['bproof_1'] = 14,  ['bproof_2'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 52,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 6,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 0
		}
	},
	clear_wear = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['bproof_1'] = -1,  ['bproof_2'] = 0,
			['decals_1'] = -1,   ['decals_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bags_1'] = 0, ['bags_2'] = -1,
			['mask_1'] = -1 , ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['bproof_1'] = -1,  ['bproof_2'] = 0,
			['decals_1'] = -1,   ['decals_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bags_1'] = 0, ['bags_2'] = -1,
			['mask_1'] = -1 , ['mask_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0
		}
	}
}
