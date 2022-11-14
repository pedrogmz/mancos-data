Config               = {}

Config.DrawDistance  = 0
Config.Size          = { x = 1.5, y = 1.5, z = 0.2 }
Config.Color         = { r = 0, g = 128, b = 255 }
Config.Type          = 1

Config.Locale        = 'es'

Config.LicenseEnable = true -- only turn this on if you are using esx_license
Config.LicensePrice  = 0

Config.Zones = {

	GunShop = {
		Legal = true,
		Items = {},
		Locations = {
			vector3(22.59, -1106.88, 29.8),
			
		}
	},

	BlackWeashop = {
		Legal = false,
		Items = {},
		Locations = {
			vector3(980.73, -3200.29, 5.99),
		}
	}

}
