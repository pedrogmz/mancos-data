Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableHelicopters          = false
Config.EnableMoneyWash            = false
Config.MaxInService               = -1
Config.Locale                     = 'fr'

Config.MissCraft                  = 10 -- %


--[[
Config.AuthorizedVehicles = {
    { name = 'stalion2',  label = 'Stalion BurgerShot' },
}
]]--
Config.Blips = {
    
    Blip = {
      Pos     = { x = -710.53, y = -911.18, z = 19.22 },
      Sprite  = 106,
      Display = 4,
      Scale   = 1.2,
      Colour  = 59,
    },

}

Config.Zones = {
-- vestuario
    Cloakrooms = {
        Pos   = { x = -705.4, y = -905.68, z = 19.22 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 255, g = 187, b = 255 },
        Type  = 1,
    },
-- 
    Vaults = {
        Pos   = { x = -708.04, y = -904.29, z = 19.22 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 248, g = 248, b = 255 },
        Type  = 1,
    },
-- Venta
    Fridge = {	
        Pos   = { x = -705.65, y = -913.86, z = 19.22 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 248, g = 248, b = 255 },
        Type  = 1,
    },

--[[
    Vehicles = {
        Pos          = { x = -1177.3461914063, y = -890.84027099609, z = 12.791997909546 },
        SpawnPoint   = { x = -1174.3291015625, y = -889.08239746094, z = 13.893969535828 },
        Size         = { x = 1.8, y = 1.8, z = 1.0 },
        Color        = { r = 255, g = 255, b = 0 },
        Type         = 1,
        Heading      = 207.43,
    },

    VehicleDeleters = {
        Pos   = { x = -1165.5532226563, y = -887.93658447266, z = 13.130926132202 },
        Size  = { x = 3.0, y = 3.0, z = 0.2 },
        Color = { r = 255, g = 255, b = 0 },
        Type  = 1,
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
        Pos   = { x = -716.82, y = -910.55, z = 19.22 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 1,
    },

-----------------------
-------- SHOPS --------
-- generador comida
    Flacons = {
        Pos   = { x = -709.56, y = -906.84, z = 19.22 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 238, g = 0, b = 0 },
        Type  = 1,
        Items = {
            { name = 'bread',      label = _U('bread'),   price = 1 },
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
