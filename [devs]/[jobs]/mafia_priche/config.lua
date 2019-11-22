Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableHelicopters          = true
Config.EnableMoneyWash            = true
Config.MaxInService               = -1
Config.Locale                     = 'es'

Config.MissCraft                  = 50 -- %


Config.AuthorizedVehicles = {
    { name = 'cognoscenti',  label = 'Cognoscenti' },
}

Config.Zones = {
--vestuario
    Cloakrooms = {
        Pos   = { x = -1595.03, y = 2101.7, z = 68.3 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 255, g = 187, b = 255 },
        Type  = 27,
    },
--vestiario personal	
	Armario = {
        Pos   = { x = -1594.63, y = 2097.13, z = 68.3 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 255, b = 0 },
        Type  = 27,
    },
--caja fuerte
    Vaults = {
        Pos   = { x = -1590.75, y = 2107.47, z = 66.50 },
        Size  = { x = 1.3, y = 1.3, z = 1.0 },
        Color = { r = 30, g = 144, b = 255 },
        Type  = 23,
    },
--nevera
    Fridge = {
        Pos   = { x = -1602.47, y = 2120.45, z = 67.50 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 248, g = 248, b = 255 },
        Type  = 23,
    },
--sacar vehiculo
    -- Vehicles = {
        -- Pos   = { x = -1570.91, y = 2114.47, z = 62.91 },
        -- SpawnPoint   = { x = -1566.98, y = 2128.65, z = 59.1 },
        -- Size         = { x = 1.8, y = 1.8, z = 1.0 },
        -- Color        = { r = 255, g = 255, b = 0 },
        -- Type         = 23,
        -- Heading      = 267.44,
    -- },
--guardar vehiculo
    -- VehicleDeleters = {
        -- Pos   = { x = -1566.98, y = 2128.65, z = 59.1 },
        -- Size  = { x = 2.5, y = 2.5, z = 2.0 },
        -- Color = { r = 249, g = 3, b = 3 },
        -- Type  = 23,
    -- },
--sacar helicoptero
    Helicopters = {
        Pos          = { x = -1597.6, y = 2126.28, z = 72.58 },
        SpawnPoint   = { x = -1602.08, y = 2117.32, z = 72.58 },
        Size         = { x = 1.8, y = 1.8, z = 1.0 },
        Color        = { r = 255, g = 255, b = 0 },
        Type         = 23,
        Heading      = 223.09,
    },
--guardar helicoptero
    HelicopterDeleters = {
        Pos   = { x = -1602.08, y = 2117.32, z = 72.58 },
        Size  = { x = 9.0, y = 9.0, z = 9.2 },
        Color = { r = 249, g = 3, b = 3 },
        Type  = 23,
    },
--aciones jefe
    BossActions = {
        Pos   = { x = -1597.34, y = 2090.86, z = 68.59 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 1,
    },

-----------------------
-------- SHOPS --------
--[[
    Flacons = {
        Pos   = { x = -1001.97, y = -2933.31, z = 13.95 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 238, g = 0, b = 0 },
        Type  = 23,
        Items = {
            { name = 'empunhadura2',    label = _U('empunhadura2'), price = 5000 }
        },
    },

    NoAlcool = {
        Pos   = { x = -1004.97, y = -2933.31, z = 13.95 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 238, g = 110, b = 0 },
        Type  = 23,
        Items = {
            { name = 'cano',        label = _U('cano'),     price = 400 }
        },
    },

    Apero = {
        Pos   = { x = -1007.97, y = -2933.31, z = 13.95 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 142, g = 125, b = 76 },
        Type  = 23,
        Items = {
            { name = 'bolcacahuetes',   label = _U('bolcacahuetes'),    price = 7 },
            { name = 'bolnoixcajou',    label = _U('bolnoixcajou'),     price = 10 },
            { name = 'bolpistache',     label = _U('bolpistache'),      price = 15 },
            { name = 'bolchips',        label = _U('bolchips'),         price = 5 },
            { name = 'saucisson',       label = _U('saucisson'),        price = 25 },
            { name = 'grapperaisin',    label = _U('grapperaisin'),     price = 15 }
        },
    },

    Ice = {
        Pos   = { x = -1009.97, y = -2933.31, z = 13.95 },
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
  -- EnterBuilding = {
    -- Pos       = { x = -1585.73, y = 2098.07, z = 68.38 },
    -- Size      = { x = 1.2, y = 1.2, z = 0.1 },
    -- Color     = { r = 3, g = 18, b = 249 },
    -- Marker    = 1,
    -- Hint      = _U('e_to_enter_1'),
    -- Teleport  = { x = -1587.82, y = 2096.27, z = 68.99 }
  -- },

  -- ExitBuilding = {
    -- Pos       = { x = -1587.82, y = 2096.27, z = 68.99 },
    -- Size      = { x = 1.2, y = 1.2, z = 0.1 },
    -- Color     = { r = 3, g = 18, b = 249 },
    -- Marker    = 1,
    -- Hint      = _U('e_to_exit_1'),
    -- Teleport  = { x = -1585.73, y = 2098.07, z = 68.38 },
  -- },

  EnterHeliport = {
    Pos       = { x = -1610.57, y = 2100.58, z = 65.3 },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 3, g = 18, b = 249 },
    Marker    = 1,
    Hint      = _U('e_to_enter_2'),
    Teleport  = { x = -1595.32, y = 2121.02, z =  72.56 }
  },

  ExitHeliport = {
    Pos       = { x = -1595.32, y = 2121.02, z = 72.56 },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 3, g = 18, b = 249 },
    Marker    = 1,
    Hint      = _U('e_to_exit_2'),
    Teleport  = { x = -1610.57, y = 2100.58, z = 65.3 },
  },
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	--Negocios
  skin_1 = {
    male = {
        ['tshirt_1'] = 31,  ['tshirt_2'] = 0,
        ['torso_1'] = 32,   ['torso_2'] = 0,
        ['arms'] = 1,
        ['bags_1'] = 0,
        ['pants_1'] = 24,    ['pants_2'] = 0,
        ['chain_1'] = 0,  ['chain_2'] = 0,
        ['shoes_1'] = 10,   ['shoes_2'] = 0
    },
    female = {
        ['tshirt_1'] = 41,   ['tshirt_2'] = 0,
        ['torso_1'] = 139,    ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 0,
        ['bags_1'] = 0,
        ['pants_1'] = 37,   ['pants_2'] = 0,
        ['shoes_1'] = 0,    ['shoes_2'] = 0,
        ['chain_1'] = 2,    ['chain_2'] = 1
    }
  },
  --Sicario
  skin_2 = {
    male = {
        ['tshirt_1'] = 57,  ['tshirt_2'] = 0,
        ['torso_1'] = 111,   ['torso_2'] = 3,
        ['arms'] = 33,
        ['bags_1'] = 45,
        ['pants_1'] = 59,   ['pants_2'] = 9,
        ['shoes_1'] = 25,   ['shoes_2'] = 0,
        ['chain_1'] = 17,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 8,    ['torso_2'] = 2,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 5,
        ['pants_1'] = 44,   ['pants_2'] = 4,
        ['shoes_1'] = 0,    ['shoes_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 2
    }
  },
  --Moro
  skin_3 = {
    male = {
        ['tshirt_1'] = 57,  ['tshirt_2'] = 0,
        ['torso_1'] = 209,   ['torso_2'] = 3,
        ['arms'] = 14,
        ['bags_1'] = 41,
        ['pants_1'] = 86,    ['pants_2'] = 9,
        ['shoes_1'] = 35,   ['shoes_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 8,    ['torso_2'] = 2,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 5,
        ['pants_1'] = 44,   ['pants_2'] = 4,
        ['shoes_1'] = 0,    ['shoes_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 2
    }
  },
  }
