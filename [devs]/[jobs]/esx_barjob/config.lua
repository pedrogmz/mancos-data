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
    { name = 'youga2',  label = 'Furgoneta Casino' },
}

Config.Blips = {
    
    Blip = {
      Pos     = { x = 924.21, y = 46.91, z = 91.11 },
      Sprite  = 93,
      Display = 4,
      Scale   = 0.0,
      Colour  = 59,
    },

}

Config.Zones = {
-- vestuario
    Cloakrooms = {
        Pos   = { x = 951.95, y = 24.49, z = 73.88 },
        Size  = { x = 1.5, y = 1.5, z = 2.0 },
        Color = { r = 255, g = 187, b = 255 },
        Type  = 23,
    },
-- armero
    Vaults = {
        Pos   = { x = -708.04, y = -904.29, z = 0.22 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 248, g = 248, b = 255 },
        Type  = 1,
    },
-- Venta
    Fridge = {	
        Pos   = { x = -705.65, y = -913.86, z = 18.22 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 248, g = 248, b = 255 },
        Type  = 23,
    },

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
		Pos   = { x = 978.04, y = 32.5, z = 73.88 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 23,
    },

-----------------------
-------- SHOPS --------
-- generador comida
    Flacons = {
        Pos   = { x = 966.94, y = 33.04, z = 73.88 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 238, g = 0, b = 0 },
        Type  = 23,
        Items = {
            { name = 'water',      label = _U('water'),   price = 1 },
            { name = 'steak',      label = _U('steak'),   price = 3 },
            { name = 'cheese',       label = _U('cheese'),    price = 2 }
        },
    },

}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
  burgershot_outfit = {
   male = {
        ['tshirt_1'] = 63,  ['tshirt_2'] = 0,
        ['torso_1'] = 23,   ['torso_2'] = 3,
        ['decals_1'] = 3,   ['decals_2'] = 0,
        ['arms'] = 12,
        ['pants_1'] = 24,   ['pants_2'] = 5,
        ['shoes_1'] = 1,    ['shoes_2'] = 1,
        ['chain_1'] = 0,    ['chain_2'] = 0
    },
    	female = {
        ['tshirt_1'] = 63,  ['tshirt_2'] = 0,
        ['torso_1'] = 23,   ['torso_2'] = 3,
        ['decals_1'] = 3,   ['decals_2'] = 0,
        ['arms'] = 12,
        ['pants_1'] = 24,   ['pants_2'] = 5,
        ['shoes_1'] = 1,   ['shoes_2'] = 1,
        ['chain_1'] = 0,  ['chain_2'] = 0
    }
  }
}
