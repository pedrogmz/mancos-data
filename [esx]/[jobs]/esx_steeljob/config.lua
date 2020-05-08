Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableHelicopters          = false
Config.EnableMoneyWash            = false
Config.MaxInService               = 4
Config.Locale                     = 'fr'

Config.MissCraft                  = 10 -- %

Config.AuthorizedVehicles = {
    { name = 'youga2',  label = 'Furgoneta Steel Thieves' },
}


Config.Warehouse = {
    Warehouse_in = {
        Pos          = { x = 495.67, y = -1340.73, z = 28.31 },
        Teleport     = { x = 1138.13, y = -3198.74, z = -39.67 },  
        Size         = { x = 1.5, y = 1.5, z = 1.0 },
        Color        = { r = 33, g = 145, b = 232 },
        Type         = -1,
        Status       = "in"
    },
    Warehouse_out = {
        Pos          = { x = 1138.13, y = -3198.68, z = -40.63 },
        Teleport     = { x = 495.67, y = -1340.73, z = 29.31 },
        Size         = { x = 1.5, y = 1.5, z = 1.0 },
        Color        = { r = 33, g = 145, b = 232 },
        Type         = 23,
        Status       = "out"
    }
}

Config.Zones = {

    -- vestuario
	--[[
    Cloakrooms = {
        Pos   = { x = 75.57, y = -1966.71, z = 20.22 },
        Size  = { x = 1.5, y = 1.5, z = 2.0 },
        Color = { r = 92, g = 16, b = 140 },
        Type  = 23,
    },
	]]--
    -- armero
    Vaults = {
        Pos   = { x = -600.04, y = -1611.38, z = 26.09 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 33, g = 145, b = 232 },
        Type  = 25,
    },    
    BossActions = {
		Pos   = { x = -596.67, y = -1611.82, z = 26.05 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 33, g = 145, b = 232 },
        Type  = 25,
    }
    

--[[ 
    Vehicles = {
        Pos          = { x = -703.72, y = -971.22, z = 19.39 },
        SpawnPoint   = { x = -695.45, y = -988.51, z = 19.39 },
        Size         = { x = 1.8, y = 1.8, z = 1.0 },
        Color        = { r = 255, g = 255, b = 0 },
        Type         = 23,
        Heading      = 359.45,
    },

    VehicleDeleters = {
        Pos   = { x = -695.45, y = -988.51, z = 19.39 },
        Size  = { x = 3.0, y = 3.0, z = 0.2 },
        Color = { r = 255, g = 255, b = 0 },
        Type  = 23,
    },
    ]]--
--[[
    Helicopters = {
        Pos          = { x = 137.177, y = -1278.757, z = 28.371 },
        SpawnPoint   = { x = 138.436, y = -1263.095, z = 28.626 },
        Size         = { x = 1.8, y = 1.8, z = 1.0 },
        Color        = { r = 255, g = 255, b = 0 },
        Type         = 23,
        Heading      = 207.43,
    },

    HelicopterDeleters = {
        Pos   = { x = 133.203, y = -1265.573, z = 28.396 },
        Size  = { x = 3.0, y = 3.0, z = 0.2 },
        Color = { r = 255, g = 255, b = 0 },
        Type  = 1,
    },
]]--

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



-- Arnedo5 | Entrada de vehiculos
Config.DrawDistance = 100.0

Config.Marker = {
	Type = 23,
	x = 3.5, y = 3.5, z = 0.5,
	r = 255, g = 55, b = 55
}

Config.Pads = {

	MartinHouseIn = {
		Text = 'Presiona ~INPUT_CONTEXT~ para acceder al procesado.',
		Marker = { x = 494.73, y = -1329.56, z = 29.34 },
		TeleportPoint = { x = -40.634, y = 42.128, z = 100.51, h = 0.77 }
	},

	MartinHouseOut = {
		Text = 'Press ~INPUT_CONTEXT~ para salir.',
		Marker = { x = 1400.49, y = 1129.61, z = 113.30 },
		TeleportPoint = { x = 1400.25, y = 1123.59, z = 20.84, h = 180.0 }
	}

}