Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableHelicopters          = false
Config.EnableMoneyWash            = false
Config.MaxInService               = 8
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
		Pos          = { x = 116.32, y = -1088.73, z = 28.26 },
		Teleport     = { x = 1121.02, y = -3152.48, z = -37.06 },  
		Size         = { x = 1.5, y = 1.5, z = 1.0 },
		Color        = { r = 92, g = 16, b = 140 },
		Type         = -1,
		Status       = "in"
	},
	Warehouse_out = {
		Pos          = { x = 1121.0 , y = -3152.08, z = -38.03 },
		Teleport          = { x = 116.32, y = -1088.73, z = 29.23 },
		Size         = { x = 1.5, y = 1.5, z = 1.0 },
		Color        = { r = 255, g = 255, b = 255 },
		Type         = 9,
		Status       = "out"
	}
}

Config.Zones = {
	-- vestuario
	Cloakrooms = {
		Pos   = { x = 971.99, y = -98.72, z = 73.85 },
		Size  = { x = 1.5, y = 1.5, z = 2.0 },
		Color = { r = 131, g = 76, b = 1 },
		Type  = 25,
	},

	-- armero
	Vaults = {
		Pos   = { x = 976.68, y = -103.79, z = 73.85 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 131, g = 76, b = 1 },
		Type  = 25,
	},

	BossActions = {
		Pos   = { x = 953.9, y = -113.87, z = 74.12 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 131, g = 76, b = 1 },
		Type  = 25,
	},
	
	Vehicles = {
		Pos          = { x = 957.64, y = -120.28, z = 260.33 },
		SpawnPoint   = { x = 950.36, y = -122.3, z = 224.14, h = 359.45 },
		Size         = { x = 1.8, y = 1.8, z = 1.0 },
		Color        = { r = 255, g = 255, b = 0 },
		Type         = 23,
		Heading      = 359.45,
	},

	VehicleDeleters = {
		Pos   = { x = 950.36, y = -122.30, z = 224.14 },
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
