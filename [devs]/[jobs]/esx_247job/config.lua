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
    { name = 'youga2',  label = 'Furgoneta 24/7' },
}

Config.Blips = {
    
    Blip = {
      Pos     = { x = -710.53, y = -911.18, z = 19.22 },
      Sprite  = 106,
      Display = 4,
      Scale   = 0.0,
      Colour  = 59,
    },

}

Config.Zones = {
-- vestuario
    Cloakrooms = {
        Pos   = { x = -705.3, y = -904.8, z = 18.22 },
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
        Pos   = { x = -705.84, y = -907.93, z = -117.78 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 248, g = 248, b = 255 },
        Type  = 23,
    },


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
		Pos   = { x = -709.56, y = -906.84, z = 18.22 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 0, g = 100, b = 0 },
        Type  = 23,
    },

-----------------------
-------- SHOPS --------
-- generador comida
    Flacons = {
        Pos   = { x = -705.7, y = -913.57, z = 19.22 },
        Size  = { x = 1.0, y = 1.0, z = 1.0 },
        Color = { r = 240, g = 240, b = 240 },
        Type  = 29,
        Items = {
            { name = 'bread',           label = _U('bread'),  price = 0 },
			{ name = 'water',      		label = _U('water'),   price = 0 },
			{ name = 'hamburger',       label = _U('hamburger'),   price = 0 },
			{ name = 'pasteldecarne',   label = _U('pasteldecarne'),   price = 0 },
			{ name = 'potatoes',        label = _U('potatoes'),   price = 0 },
			{ name = 'sopa',            label = _U('sopa'),   price = 0 },
			{ name = 'ecola',           label = _U('ecola'),   price = 0 },
			{ name = 'sprunk',          label = _U('sprunk'),   price = 0 },
			{ name = 'fishingrod',      label = _U('fishingrod'),   price = 0 },
			{ name = 'fishbait',        label = _U('fishbait'),   price = 0 },
            { name = 'turtlebait',      label = _U('turtlebait'),   price = 0 },
			{ name = 'phone',     		label = _U('phone'),  		 price = 0 },
			{ name = 'jumelles',        label = _U('jumelles'),  		 price = 0 },
			{ name = 'condon',      	label = _U('condon'),  		 price = 0 },
			{ name = 'dildo',     		label = _U('dildo'),   		price = 0 },
			{ name = 'cigarrett',      label = _U('cigarrett'),   price = 0 },
			{ name = 'dopebag',      label = _U('dopebag'),   price = 0 }
        },
    },

}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
  burgershot_outfit = {
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
  }
}
