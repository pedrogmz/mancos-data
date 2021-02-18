Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableHelicopters          = false
Config.EnableMoneyWash            = true
Config.MaxInService               = -1
Config.Locale                     = 'es'

Config.MissCraft                  = 10 -- %


Config.AuthorizedVehicles = {
    { name = 'tourbus',  label = 'Bahamas Bus' },
	{ name = 'stretch',  label = 'Limusina' },
	{ name = 'patriot2', label = 'Limusina 4x4' },
}

Config.Blips = {
    
    Blip = {
      Pos     = { x = -1395.58, y = -605.05, z = 30.32 },
      Sprite  = 93,
      Display = 4,
      Scale   = 0.8,
      Colour  = 27,
    },

}

Config.Zones = {

    Cloakrooms = {
        Pos   = { x = -1381.84, y = -632.96, z = 29.82 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 255, g = 187, b = 255 },
        Type  = 27,
    },

    Vaults = {
        Pos   = { x = -1389.13, y = -610.8, z = 29.32 },
        Size  = { x = 1.3, y = 1.3, z = 1.0 },
        Color = { r = 30, g = 144, b = 255 },
        Type  = 23,
    },

    Fridge = {
        Pos   = { x = -1379.95, y = -630.9, z = 29.82 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 248, g = 248, b = 255 },
        Type  = 23,
    },
    Fridge2 = {
        Pos   = { x = -1391.1, y = -605.53, z = 29.40 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 248, g = 248, b = 255 },
        Type  = 23,
    },

    Vehicles = {
        Pos          = { x = -1382.16, y = -584.03, z = 29.28 },
        SpawnPoint   = { x = -1375.0, y = -575.91, z = 30.16 },
        Size         = { x = 1.8, y = 1.8, z = 1.0 },
        Color        = { r = 255, g = 255, b = 0 },
        Type         = 23,
        Heading      = 32.19,
    },

    VehicleDeleters = {
        Pos   = { x = -1406.9, y = -589.53, z = 29.29 },
        Size  = { x = 3.0, y = 3.0, z = 0.2 },
        Color = { r = 255, g = 255, b = 0 },
        Type  = 1,
    },

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

    BossActions = {
        Pos   = { x = -1374.46, y = -623.75, z = 29.82 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 27,
    },

	BossActions2 = {
		Pos   = { x = 1407.16, y = 1147.75, z = 113.33 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 92, g = 16, b = 140 },
        Type  = 23,
    },


-----------------------
-------- SHOPS --------

    Flacons = {
        Pos   = { x = -1373.36, y = -627.43, z = 29.82 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 238, g = 0, b = 0 },
        Type  = 23,
        Items = {
            { name = 'energy',      label = _U('energy'),   price = 3 },
            { name = 'drpepper',    label = _U('drpepper'), price = 2 },
            { name = 'jager',      label = _U('jager'),   price = 7 },
            { name = 'limonade',    label = _U('limonade'), price = 1 },
            { name = 'martini',    label = _U('martini'), price = 5 },
            { name = 'rhum',       label = _U('rhum'),    price = 4 },
            { name = 'soda',        label = _U('soda'),     price = 3 },
            { name = 'icetea',      label = _U('icetea'),   price = 3 },
            { name = 'tequila',    label = _U('tequila'), price = 6 },
            { name = 'vodka',      label = _U('vodka'),   price = 7 },
            { name = 'whisky',     label = _U('whisky'),  price = 7 },            
            { name = 'jusfruit',    label = _U('jusfruit'), price = 3 }
                       
        },
    },

    Flacons2 = {
        Pos   = { x = -1389.51, y = -607.94, z = 29.32 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 238, g = 0, b = 0 },
        Type  = 23,
        Items = {
            { name = 'energy',      label = _U('energy'),   price = 3 },
            { name = 'drpepper',    label = _U('drpepper'), price = 2 },
            { name = 'jager',      label = _U('jager'),   price = 7 },
            { name = 'limonade',    label = _U('limonade'), price = 1 },
            { name = 'martini',    label = _U('martini'), price = 5 },
            { name = 'rhum',       label = _U('rhum'),    price = 4 },
            { name = 'soda',        label = _U('soda'),     price = 3 },
            { name = 'icetea',      label = _U('icetea'),   price = 3 },
            { name = 'tequila',    label = _U('tequila'), price = 6 },
            { name = 'vodka',      label = _U('vodka'),   price = 7 },
            { name = 'whisky',     label = _U('whisky'),  price = 7 },            
            { name = 'jusfruit',    label = _U('jusfruit'), price = 3 }
                       
        },
    },

   --[[ NoAlcool = {
        Pos   = { x = -1374.45, y = -628.15, z = 29.82 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 238, g = 110, b = 0 },
        Type  = 23,
        Items = {
            { name = 'soda',        label = _U('soda'),     price = 4 },
            { name = 'jusfruit',    label = _U('jusfruit'), price = 3 },
            { name = 'icetea',      label = _U('icetea'),   price = 4 },
            { name = 'energy',      label = _U('energy'),   price = 7 },
            { name = 'drpepper',    label = _U('drpepper'), price = 2 },
            { name = 'limonade',    label = _U('limonade'), price = 1 }
        },
    },--]]

    Apero = {
        Pos   = { x = -1375.74, y = -629.1, z = 29.82 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 142, g = 125, b = 76 },
        Type  = 23,
        Items = {
            { name = 'bolnoixcajou',    label = _U('bolnoixcajou'),     price = 8 },
            { name = 'bolcacahuetes',   label = _U('bolcacahuetes'),    price = 5 },
            { name = 'ice',             label = _U('ice'),              price = 1 },
            { name = 'menthe',          label = _U('menthe'),           price = 2 },
            { name = 'bolchips',        label = _U('bolchips'),         price = 5 },
            { name = 'bolpistache',     label = _U('bolpistache'),      price = 10 },
            { name = 'grapperaisin',    label = _U('grapperaisin'),     price = 15 },
            { name = 'saucisson',       label = _U('saucisson'),        price = 20 }
        },
    },

    Apero2 = {
        Pos   = { x = -1391.29, y = -601.2, z = 29.32 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 142, g = 125, b = 76 },
        Type  = 23,
        Items = {
            { name = 'bolnoixcajou',    label = _U('bolnoixcajou'),     price = 8 },
            { name = 'bolcacahuetes',   label = _U('bolcacahuetes'),    price = 5 },
            { name = 'ice',             label = _U('ice'),              price = 1 },
            { name = 'menthe',          label = _U('menthe'),           price = 2 },
            { name = 'bolchips',        label = _U('bolchips'),         price = 5 },
            { name = 'bolpistache',     label = _U('bolpistache'),      price = 10 },
            { name = 'grapperaisin',    label = _U('grapperaisin'),     price = 15 },
            { name = 'saucisson',       label = _U('saucisson'),        price = 20 }
        },
    },

  --[[  Ice = {
        Pos   = { x = -1377.27, y = -630.09, z = 29.82 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 255, g = 255, b = 255 },
        Type  = 23,
        Items = {
            { name = 'ice',     label = _U('ice'),      price = 1 },
            { name = 'menthe',  label = _U('menthe'),   price = 2 }
        },
    },]]--

}


-----------------------
----- TELEPORTERS -----

Config.TeleportZones = {
  EnterBuilding = {
    Pos       = { x = -1386.37, y = -627.4, z = 29.82 },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 128, g = 128, b = 128 },
    Marker    = 1,
    Hint      = _U('e_to_enter_1'),
    Teleport  = { x = -1371.4, y = -626.05, z = 30.82 }
  },

  ExitBuilding = {
    Pos       = { x = -1371.4, y = -626.05, z = 29.82 },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 128, g = 128, b = 128 },
    Marker    = 1,
    Hint      = _U('e_to_exit_1'),
    Teleport  = { x = -1386.37, y = -627.4, z = 30.82 },
  },
    EnterBuilding2 = {                                             --Entrada a la barra de fuera
    Pos       = { x = -1389.33, y = -591.61, z = 29.30 },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 128, g = 128, b = 128 },
    Marker    = 1,
    Hint      = _U('e_to_enter_1'),
    Teleport  = { x = -1385.5, y = -606.77, z = 29.30 },
    },

  ExitBuilding2 = {
    Pos       = { x = -1385.5, y = -606.77, z = 29.30 },        --Interior de la barra de fuera
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 128, g = 128, b = 128 },
    Marker    = 1,
    Hint      = _U('e_to_exit_1'),
    Teleport  = { x = -1389.33, y = -591.61, z = 29.30 },
	},
--[[
  EnterHeliport = {
    Pos       = { x = 126.843, y = -729.012, z = 241.201 },
    Size      = { x = 2.0, y = 2.0, z = 0.2 },
    Color     = { r = 204, g = 204, b = 0 },
    Marker    = 1,
    Hint      = _U('e_to_enter_2),
    Teleport  = { x = -65.944, y = -818.589, z =  320.801 }
  },

  ExitHeliport = {
    Pos       = { x = -67.236, y = -821.702, z = 320.401 },
    Size      = { x = 2.0, y = 2.0, z = 0.2 },
    Color     = { r = 204, g = 204, b = 0 },
    Marker    = 1,
    Hint      = _U('e_to_exit_2'),
    Teleport  = { x = 124.164, y = -728.231, z = 241.801 },
  },
]]--
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
  barman_outfit = {
    male = {
        ['tshirt_1'] = 6,  ['tshirt_2'] = 0,
        ['torso_1'] = 25,   ['torso_2'] = 2,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 11,
        ['pants_1'] = 24,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
        ['chain_1'] = 22,  ['chain_2'] = 3,
        ['mask_1'] = 99,    ['mask_2'] = 2
    },
    female = {
        ['tshirt_1'] = 24,   ['tshirt_2'] = 4,
        ['torso_1'] = 28,    ['torso_2'] = 9,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 85,
        ['pants_1'] = 37,   ['pants_2'] = 0,
        ['shoes_1'] = 0,    ['shoes_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['mask_1'] = 99,    ['mask_2'] = 4
        
    }
  },
  chofer_outfit = {
    male = {
        ['tshirt_1'] = 22,  ['tshirt_2'] = 0,
        ['torso_1'] = 40,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 11,
        ['pants_1'] = 24,   ['pants_2'] = 0,
        ['shoes_1'] = 9,   ['shoes_2'] = 2,
        ['helmet_1'] = 29,  ['helmet_2'] = 1
    },
    female = {
        ['tshirt_1'] = 24,   ['tshirt_2'] = 4,
        ['torso_1'] = 28,    ['torso_2'] = 9,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 85,
        ['pants_1'] = 37,   ['pants_2'] = 0,
        ['shoes_1'] = 0,    ['shoes_2'] = 0,
        ['helmet_1'] = 0,    ['helmet_2'] = 0
    }
  },
  security_outfit = {
    male = {
        ['tshirt_1'] = 16,  ['tshirt_2'] = 0,
        ['torso_1'] = 18,   ['torso_2'] = 3,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 19,
        ['pants_1'] = 52,   ['pants_2'] = 1,
        ['shoes_1'] = 25,   ['shoes_2'] = 0,
        ['chain_1'] = 0,  ['chain_2'] = 0,
        ['mask_1'] = 99,    ['mask_2'] = 1
    },
    female = {
        ['tshirt_1'] = 9,   ['tshirt_2'] = 0,
        ['torso_1'] = 45,    ['torso_2'] = 3,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 31,
        ['pants_1'] = 61,   ['pants_2'] = 0,
        ['shoes_1'] = 25,    ['shoes_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['mask_1'] = 99,    ['mask_2'] = 1
    }
  },
  boss_outfit = {
    male = {
        ['tshirt_1'] = 6,  ['tshirt_2'] = 0,
        ['torso_1'] = 25,   ['torso_2'] = 2,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 11,
        ['pants_1'] = 24,   ['pants_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 0,
        ['chain_1'] = 22,  ['chain_2'] = 3,
        ['mask_1'] = 99,    ['mask_2'] = 5
    },
    female = {
        ['tshirt_1'] = 24,   ['tshirt_2'] = 4,
        ['torso_1'] = 28,    ['torso_2'] = 9,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 85,
        ['pants_1'] = 37,   ['pants_2'] = 0,
        ['shoes_1'] = 0,    ['shoes_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['mask_1'] = 99,    ['mask_2'] = 4
    }
  },
  dancer_outfit_1 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 40,
        ['pants_1'] = 61,   ['pants_2'] = 9,
        ['shoes_1'] = 16,   ['shoes_2'] = 9,
        ['chain_1'] = 118,  ['chain_2'] = 0,
        ['mask_1'] = 99,    ['mask_2'] = 2
    },
    female = {
        ['tshirt_1'] = 14,   ['tshirt_2'] = 0,
        ['torso_1'] = 5,    ['torso_2'] = 3,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 108,   ['pants_2'] = 15,
        ['shoes_1'] = 23,    ['shoes_2'] = 2,
        ['chain_1'] = 61,    ['chain_2'] = 1,
        ['mask_1'] = 99,    ['mask_2'] = 4
    }
  },
  dancer_outfit_2 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 62,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 14,
        ['pants_1'] = 4,    ['pants_2'] = 0,
        ['shoes_1'] = 34,   ['shoes_2'] = 0,
        ['chain_1'] = 118,  ['chain_2'] = 0,
        ['mask_1'] = 99,    ['mask_2'] = 2
    },
    female = {
        ['tshirt_1'] = 14,   ['tshirt_2'] = 0,
        ['torso_1'] = 5,   ['torso_2'] = 12,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 108,   ['pants_2'] = 0,
        ['shoes_1'] = 14,   ['shoes_2'] = 14,
        ['chain_1'] = 40,    ['chain_2'] = 1,
        ['mask_1'] = 99,    ['mask_2'] = 4
    }
  },
  dancer_outfit_3 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 4,    ['pants_2'] = 0,
        ['shoes_1'] = 34,   ['shoes_2'] = 0,
        ['chain_1'] = 118,  ['chain_2'] = 0,
        ['mask_1'] = 99,    ['mask_2'] = 2
    },
    female = {
        ['tshirt_1'] = 15,   ['tshirt_2'] = 0,
        ['torso_1'] = 170,   ['torso_2'] = 5,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 91,   ['pants_2'] = 20,
        ['shoes_1'] = 14,   ['shoes_2'] = 13,
        ['chain_1'] = 10,    ['chain_2'] = 0,
        ['mask_1'] = 99,    ['mask_2'] = 4
    }
  },
  dancer_outfit_4 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 61,   ['pants_2'] = 5,
        ['shoes_1'] = 34,   ['shoes_2'] = 0,
        ['chain_1'] = 118,  ['chain_2'] = 0,
        ['mask_1'] = 99,    ['mask_2'] = 2
    },
    female = {
        ['tshirt_1'] = 14,   ['tshirt_2'] = 0,
        ['torso_1'] = 287,   ['torso_2'] = 12,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 10,
        ['pants_1'] = 113,   ['pants_2'] = 12,
        ['shoes_1'] = 87,   ['shoes_2'] = 12,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['mask_1'] = 134,    ['mask_2'] = 12
    }
  },
  --[[dancer_outfit_5 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 21,   ['pants_2'] = 0,
        ['shoes_1'] = 34,   ['shoes_2'] = 0,
        ['chain_1'] = 118,  ['chain_2'] = 0,
        ['mask_1'] = 99,    ['mask_2'] = 4
    },
    female = {
        ['tshirt_1'] = 14,   ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 5,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 63,   ['pants_2'] = 2,
        ['shoes_1'] = 41,   ['shoes_2'] = 2,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['mask_1'] = 99,    ['mask_2'] = 5
    }
  },
  dancer_outfit_6 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 81,   ['pants_2'] = 0,
        ['shoes_1'] = 34,   ['shoes_2'] = 0,
        ['chain_1'] = 118,  ['chain_2'] = 0,
        ['mask_1'] = 99,    ['mask_2'] = 4
    },
    female = {
        ['tshirt_1'] = 14,   ['tshirt_2'] = 0,
        ['torso_1'] = 18,   ['torso_2'] = 3,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 63,   ['pants_2'] = 10,
        ['shoes_1'] = 41,   ['shoes_2'] = 10,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['mask_1'] = 99,    ['mask_2'] = 5
    }
  },
  dancer_outfit_7 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 40,
        ['pants_1'] = 61,   ['pants_2'] = 9,
        ['shoes_1'] = 16,   ['shoes_2'] = 9,
        ['chain_1'] = 118,  ['chain_2'] = 0,
        ['mask_1'] = 99,    ['mask_2'] = 4
    },
    female = {
        ['tshirt_1'] = 14,   ['tshirt_2'] = 0,
        ['torso_1'] = 111,  ['torso_2'] = 6,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 63,   ['pants_2'] = 6,
        ['shoes_1'] = 41,   ['shoes_2'] = 6,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['mask_1'] = 99,    ['mask_2'] = 5
    }--]]
  
}
