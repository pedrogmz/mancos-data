Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 249, g = 10, b = 3 }
Config.EnablePlayerManagement     = false -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 20

Config.BuyTimer = 5					-- Timer between one buy and another (in seconds)

Config.Locale                     = 'es'
Config.LicenseEnable = false -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Zones = {

	ShopEntering = {
		Pos   = { x = -1127.04, y = -1703.87, z = 3.45 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 1
	},

	ShopInside = {
		Pos     = { x = -1138.81, y = -1713.09, z = 4.44 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 215.50,
		Type    = -1
	},

	ShopOutside = {
		Pos     = { x = -1139.06, y = -1695.74, z = 4.02 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 281.46,
		Type    = -1
	},

	BossActions = {
		Pos   = { x = -32.065, y = -1114.277, z = 25.422 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},

	GiveBackVehicle = {
		Pos   = { x = -18.227, y = -1078.558, z = 25.675 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Type  = (Config.EnablePlayerManagement and 1 or -1)
	},
}
