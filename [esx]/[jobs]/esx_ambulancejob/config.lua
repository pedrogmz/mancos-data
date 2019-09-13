Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }

Config.ReviveReward               = 300  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'es'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 10 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 10 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true
Config.MaxInService               = 10

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = { coords = vector3(353.19, -565.13, 28.79), heading = 48.13 }

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(364.45, -591.78, 28.69),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(336.07, -580.48, 27.79)
		},
		--[[Pharmacies = {
			vector3(267.5, -1362.1, 23.5)
		},]]--
		Baul = {
			vector3(334.44, -587.12, 27.79)
		},



		Vehicles = {
			{
				Spawner = vector3(370.05, -593.55, 28.87),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(364.8, -595.42, 28.33), heading = 158.93, radius = 4.0 },
					{ coords = vector3(361.21, -593.97, 28.31), heading = 158.02, radius = 4.0 },
					{ coords = vector3(366.28, -586.5, 28.35), heading = 157.04, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(355.06, -581.75, 74.17),
				InsideShop = vector3(305.6, -1419.7, 41.5),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(351.17, -587.44, 74.07), heading = 243.21, radius = 10.0 }
				}
			}
		},

		FastTravels = {
			{ --EMPIEZA LA SUBIDA HACIA EL TEJADO
				From = vector3(340.25, -584.49, 73.17),
				To = { coords = vector3(337.49, -594, 27.79), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(340.71, -595.17, 27.79),
				To = { coords = vector3(344, -585.15, 73.17), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			}, -- TERMINA LA SUBIDA AL TEJADO

			--[[           ------DE MOMENTO NO SE USARA
			{
				From = vector3(247.3, -1371.5, 23.5),
				To = { coords = vector3(333.1, -1434.9, 45.5), heading = 138.6 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(335.5, -1432.0, 45.50),
				To = { coords = vector3(249.1, -1369.6, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(234.5, -1373.7, 20.9),
				To = { coords = vector3(320.9, -1478.6, 28.8), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(317.9, -1476.1, 28.9),
				To = { coords = vector3(238.6, -1368.4, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			}]]--
		},

		FastTravelsPrompt = {
			{
				From = vector3(237.4, -1373.8, 26.0),
				To = { coords = vector3(251.9, -1363.3, 38.5), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(256.5, -1357.7, 36.0),
				To = { coords = vector3(235.4, -1372.8, 26.3), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			}
		}

	}
}

Config.AuthorizedVehicles = {

	paramedico = {
		{ model = 'ambulance', label = 'Ambulancia estándar', price = 1}
	},

	medico = {
		{ model = 'ambulance', label = 'Ambulancia estándar', price = 1},
	},
	
	cirujano = {
		{ model = 'ambulance', label = 'Ambulancia estándar', price = 1},
		{ model = 'mbcla45ems', label = 'Vehículo rápido', price = 1}	
	},
	
	psicologo = {
		{ model = 'ambulance', label = 'Ambulancia estándar', price = 1},
		{ model = 'mbcla45ems', label = 'Vehículo rápido', price = 1}	
	},
	
	viceboss = {
		{ model = 'ambulance', label = 'Ambulancia estándar', price = 1},
		{ model = 'mbcla45ems', label = 'Vehículo rápido', price = 1}	
	},

	boss = {
		{ model = 'ambulance', label = 'Ambulancia estándar', price = 1},
		{ model = 'mbcla45ems', label = 'Vehículo rápido', price = 1}
	}

}

Config.AuthorizedHelicopters = {
	boss = {
		{ model = 'ah72ems', label = 'Helicóptero', price = 300000 }
		--{ model = 'seasparrow', label = 'Helicóptero anfibio', price = 300000 }
	}
}
