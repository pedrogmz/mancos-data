-- Github Project
-- https://github.com/ESX-PUBLIC/esx_npcdrugsales

Config                  =   {}
Config.MinCops          =   0     -- Número mínimo de policias  [Por defecto no hay mínimo]
Config.EnableBlipCircle =   false  -- Mostrar círculo en el mapa [Opción de desarollador]
Config.Locale           =   'es'

Config.Zones = {                  -- Zonas de venta de droga

	Pier = {
        Pos                 = {x = -1597.17, y = -1128.43, z = 1.75},
        Coords              = vector3(-1597.17,-1128.43, 1.78),
        Dist                = 245.0,
        Authorized_drugs    = { "porros", "cocaine" }, -- Drogas para vender en la zona
        Prices = {
            Police0 = 40,
            Police1 = 250,
            Police2 = 300,
            Police3 = 350,
            Police4 = 450
        }
	},

	Playa = {	
        Pos   = { x = -1539.0, y = -1539.95, z = 1.11 },
        Coords  = vector3(-1539.0,-1271.95, 1.11),
        Dist    = 245.0,
        Authorized_drugs    = { "porros", "cocaine" },
        Prices = {
            Police0 = 40,
            Police1 = 250,
            Police2 = 300,
            Police3 = 350,
            Police4 = 450
        }
	},

    GrooveSt = {	
        Pos   = { x = 35.16, y = -1881.69, z = 22.02 },
        Coords  = vector3(35.16,-1881.69, 22.02),
        Dist    = 245.0,
        Authorized_drugs    = { "meth" },
        Prices = {
            Police0 = 40,
            Police1 = 250,
            Police2 = 300,
            Police3 = 350,
            Police4 = 450
        }
	},
	
}