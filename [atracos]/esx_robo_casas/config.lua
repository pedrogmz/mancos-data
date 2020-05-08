Config = {}

Config.Items = {
    {Label = 'Semillas hembra', Name = 'lowgradefemaleseed', Amount = math.random (1,3)},
    {Label = 'Rolex', Name = 'rolex', Amount = math.random (0,1)},
    {Label = 'Diamante', Name = 'diamond', Amount = 1},
    {Label = 'Maceta', Name = 'plantpot', Amount = math.random (1,3)},
    {Label = 'Fertilizante', Name = 'lowgradefert', Amount = math.random (1,3)},
    {Label = 'Agua purificada', Name = 'purifiedwater', Amount = math.random (1,3)},
    {Label = 'Semillas macho+', Name = 'highgrademaleseed', math.random (0,2)},
    {Label = 'Lingote de oro', Name = 'gold', Amount = math.random (0,1)},
    {Label = 'Caña de pescar', Name = 'fishingrod', Amount = math.random (0,1)},
    {Label = 'Diamantes', Name = 'fishbait', Amount = math.random (0,1)},
} 


Config.GhettoPeds = { -- https://wiki.gt-mp.net/index.php/Peds
    588969535,
    -198252413,
    -1492432238,
    599294057
}

Config.GhettoWeapons = { -- armas de los spawns NPC
    "WEAPON_PISTOL" 
	}

Config.WeaponChance = 70 -- % de que lleven armas

Config.Burglary = {
    [1] = {
        Door = {Object = "v_ilev_fa_frontdoor", Coords = vector3(-14.36, -1441.58, 30.22), Frozen = true, Heading = 180.0, Health = 1000}, -- estado de la puerta
        Type = 'ghetto',
        Cops = 2,
        Peds = {
			vector3(16.12, -1445.77, 30.54),
			vector3(-6.72, -1482.03, -30.33),
			vector3(-16.78, -1492.03, -30.33),
			vector3(-15.81, -1491.45, -30.33),
			vector3(-17.82, -1792.64, -30.34),
			vector3(-1.66, -1442.97, 30.96),
			vector3(4.71,  -1445.34, 30.55),
			vector3(4.63,  -1448.24, 35.55),
			vector3(-58.67, -1482.44, 32.06),
			vector3(-36.797, -1492.05, 31.22)			
        },
        MultipleSearch = {
            {Items = 2, Position = vector3(-17.85, -1432.38, 30.22), Heading = 331.55, Text = 'Comoda -', Name = 'comoda'},
            {Items = 2, Position = vector3(-14.87, -1440.19, 30.22), Heading = 93.55, Text = 'Recibidor -', Name = 'recibidor'},
            {Items = 2, Position = vector3(-12.29, -1434.98, 30.22), Heading = 87.47, Text = 'Estanteria -', Name = 'estanteria'},
            {Items = 2, Position = vector3(-9.36, -1434.79, 30.22), Heading = 215.48, Text = 'Mueble -', Name = 'mueble'},
            {Items = 1, Position = vector3(-18.4, -1440.59, 30.22), Heading = 100.32, Text = 'Mesita -', Name = 'mesita'},
        },
    },

   --[[ [2] = {
        Door = {Object = 'v_ilev_trev_doorfront', Coords = vector3(-1150.14, -1521.71, 9.75), Frozen = true, Heading = 35.0, Health = 1000}, -- estado de la puerta
        Type = 'city',
        Cops = 0,
        MultipleSearch = {
            {Items = 1, Position = vector3(-1147.57, -1511.07, 9.75), Heading = 34.56, Text = 'Mesita', Name = 'mesita'},
            {Items = 1, Position = vector3(-1149.87, -1512.61, 9.75), Heading = 37.75, Text = 'Mesita ', Name = 'mesita'},
            {Items = 2, Position = vector3(-1158.12, -1518.2, 9.75), Heading = 37.85, Text = 'Estanteria', Name = 'estanteria'},
            {Items = 2, Position = vector3(-1155.52, -1523.76, 9.75), Heading = 216.29, Text = 'Estanteria', Name = 'estanteria'},
        },
    } --]]
}