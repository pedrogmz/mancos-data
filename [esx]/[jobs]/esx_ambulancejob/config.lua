Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 25, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
Config.MarkerSize                 = { x = 3.0, y = 3.0, z = 1.5 }

Config.ReviveReward               = 25  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = false -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

local getServerType = GetConvar("server_number", "Mancos01")
if getServerType == "MancosWL" then
	Config.isPublicServer = false
else
	Config.isPublicServer = true
end

-- Revivir en camilla
Config.Payrevive				  = 500
Config.RevivirCamillaMax		  = 0	
Config.EMS						  = 0
Config.MaxDistance = 1.5

Config.EnableESXIdentity          = true

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

Config.RemoveTattooCost = 200

Config.RespawnPoint = { coords = vector3(-496.65, -336.09, 34.5), heading = 262.47 }

Config.BedList = {
	{
		text = '[~g~E~w~] para ser atendido.',
		heading = 80.0,
		objCoords  = {x = 334.02, y = -578.48, z = 42.60},---pillbox bed
	}
}

Config.Zones = {

	VehicleSpawnPoint = {
		Pos     = {x = 364.4, y = -590.87, z = 28.69},
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Type    = -1, Rotate = false,
		Heading = 157.21
	},

	VehicleSpawnPointHelicopter = {	
		Pos   = {x = 449.0, y = -980.93, z = 43.69}, 
		Type    = -1, Rotate = false,
		Heading = 201.59
	},

	VehicleDeleter = {	
		Pos   = {x = 330.01, y = -554.77, z = 27.74},
		Size  = {x = 3.0, y = 3.0, z = 0.25},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1, Rotate = false
	},

	VehicleDeleterHelicopter = {
		Pos   = {x = 351.88, y = -588.13, z = 73.17},
		Size  = {x = 6.0, y = 6.0, z = 0.25},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1, Rotate = false
	},

	
}

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(292.57, -587.35, 45.18),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(310.51, -598.96, 42.31)
		},
		--[[Pharmacies = {
			vector3(267.5, -1362.1, 23.5)
		},]]--
		Baul = {
			vector3(309.44, -602.53, 42.31)
		},

		RemoveTattoo = {
			vector3(346.98, -576.14, 28.53)
		},

		Vehicles = {
			{
				Spawner = vector3(370.05, -593.55, 28.87),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(364.8, -595.42, 28.33), heading = 158.93, radius = 4.0, firetruk = vector3(366.28, -586.5, 28.35), heading = 157.04, radius = 6.0 },
					{ coords = vector3(361.21, -593.97, 28.31), heading = 158.02, radius = 4.0 },
					{ coords = vector3(366.28, -586.5, 28.35), heading = 157.04, radius = 6.0 },
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
		FastTravelElevatorUp = {
			{ --Subida al hospital de arriba
				From = vector3(340.25, -595.21, 27.81),
				To = { coords = vector3(332.85, -573.95, 42.32), heading = 159.0 },
				Marker = { type = 25, x = 2.0, y = 2.0, z = 0.5, r = 93, g = 233, b = 247, a = 100, rotate = false }
				
			}
		},
		FastTravelElevatorhelicopter = {			
			{ --Subir el helicopter
				From = vector3(340.25, -584.49, 73.20),
				To = { coords = vector3(337.49, -594, 27.79), heading = 0.0 },
				Marker = { type = 25, x = 2.0, y = 2.0, z = 0.5, r = 93, g = 233, b = 247, a = 100, rotate = false }
			}
		},
		FastTravelElevatorDown = {
			
			{ --bajada al hospital de abajo
				From = vector3(325.03, -598.66, 42.31),
				To = { coords = vector3(315.61, -582.6, 28.79), heading = 198.0 },
				Marker = { type = 25, x = 2.0, y = 2.0, z = 0.5, r = 93, g = 233, b = 247, a = 100, rotate = false }
			}
		},

		FastTravels = {
			--[[  
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

			          ------DE MOMENTO NO SE USARA
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
				Marker = { type = 25, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(256.5, -1357.7, 36.0),
				To = { coords = vector3(235.4, -1372.8, 26.3), heading = 0.0 },
				Marker = { type = 25, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			}
		}

	},
	CentralLosSantosUp = {

		Vehicles = {
			{
				Spawner = vector3(300.08, -575.4, 43.26),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(293.08, -571.12, 42.92), heading = 60.74, radius = 4.0, firetruk = vector3(292.47, -611.26, 43.44), heading = 60.74, radius = 4.0 },
					{ coords = vector3(293.08, -571.12, 42.92), heading = 60.74, radius = 4.0 },
					{ coords = vector3(293.08, -571.12, 42.92), heading = 60.74, radius = 6.0 }
				}
			}
		}

	}
}

Config.AuthorizedVehicles = {
	Shared = {
		{ model = 'ambulance', label = 'Ambulancia estándar'},
		{ model = 'firetruk', label = 'Camión de bomberos'}
	},
	paramedico = {

	},
	medico = {
		
	},
	cirujano = {
		--{ model = 'ems2', label = 'Vehículo rápido'}	
	},
	
	psicologo = {
		--{ model = 'ems2', label = 'Vehículo rápido'}	
	},
	
	viceboss = {
		--{ model = 'ems2', label = 'Vehículo rápido'}	
	},

	boss = {
		--{ model = 'ems2', label = 'Vehículo rápido'}
	}
}

Config.AuthorizedHelicopters = {
	Shared = {
		
	},
	boss = {
		{ model = 'heliems1', label = 'Helicóptero de intervención'}
	}
}

Config.Uniforms = {
	practicas_wear = {
		male = {
			['tshirt_1'] = 129,  ['tshirt_2'] = 0,
			['torso_1'] = 73,   ['torso_2'] = 15,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 85,
			['pants_1'] = 52,   ['pants_2'] = 2,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['chain_1'] = 126,    ['chain_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 159,  ['tshirt_2'] = 0,
			['torso_1'] = 224,   ['torso_2'] = 23,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 109,
			['pants_1'] = 54,   ['pants_2'] = 2,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['chain_1'] = 96,    ['chain_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	paramedico_wear = {
		male = {
			['tshirt_1'] = 129,  ['tshirt_2'] = 0,
			['torso_1'] = 73,   ['torso_2'] = 15,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 85,
			['pants_1'] = 52,   ['pants_2'] = 2,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['chain_1'] = 126,    ['chain_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 159,  ['tshirt_2'] = 0,
			['torso_1'] = 224,   ['torso_2'] = 23,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 109,
			['pants_1'] = 54,   ['pants_2'] = 2,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['chain_1'] = 96,    ['chain_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	medico_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 249,   ['torso_2'] = 1,
			['decals_1'] = 59,   ['decals_2'] = 0,
			['arms'] = 88,
			['pants_1'] = 52,   ['pants_2'] = 2,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['chain_1'] = 126,    ['chain_2'] = 0,
			['bproof_1'] = 1,  ['bproof_2'] = 0,			
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 1,  ['tshirt_2'] = 0,
			['torso_1'] = 257,   ['torso_2'] = 1,
			['decals_1'] = 67,   ['decals_2'] = 0,
			['arms'] = 104,
			['pants_1'] = 54,   ['pants_2'] = 2,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['chain_1'] = 96,    ['chain_2'] = 0,
			['bproof_1'] = 1,  ['bproof_2'] = 0,			
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	cirujano_wear = {
		male = {
			['tshirt_1'] = 129,  ['tshirt_2'] = 0,
			['torso_1'] = 250,   ['torso_2'] = 0,
			['decals_1'] = 58,   ['decals_2'] = 0,
			['arms'] = 85,
			['pants_1'] = 24,   ['pants_2'] = 5,
			['shoes_1'] = 66,   ['shoes_2'] = 1,
			['chain_1'] = 126,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 159,  ['tshirt_2'] = 0,
			['torso_1'] = 258,   ['torso_2'] = 0,
			['decals_1'] = 66,   ['decals_2'] = 1,
			['arms'] = 160,
			['pants_1'] = 23,   ['pants_2'] = 0,
			['shoes_1'] = 57,   ['shoes_2'] = 0,
			['chain_1'] = 96,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	fisotera_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 13,   ['torso_2'] = 2,
			['decals_1'] = 57,   ['decals_2'] = 0,
			['arms'] = 92,
			['pants_1'] = 24,   ['pants_2'] = 5,
			['shoes_1'] = 66,   ['shoes_2'] = 1,
			['chain_1'] = 126,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 159,  ['tshirt_2'] = 0,
			['torso_1'] = 258,   ['torso_2'] = 0,
			['decals_1'] = 66,   ['decals_2'] = 1,
			['arms'] = 160,
			['pants_1'] = 23,   ['pants_2'] = 0,
			['shoes_1'] = 57,   ['shoes_2'] = 0,
			['chain_1'] = 96,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	pisco_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 13,   ['torso_2'] = 1,
			['decals_1'] = 57,   ['decals_2'] = 0,
			['arms'] = 92,
			['pants_1'] = 24,   ['pants_2'] = 1,
			['shoes_1'] = 66,   ['shoes_2'] = 1,
			['chain_1'] = 126,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 159,  ['tshirt_2'] = 0,
			['torso_1'] = 258,   ['torso_2'] = 0,
			['decals_1'] = 66,   ['decals_2'] = 1,
			['arms'] = 160,
			['pants_1'] = 23,   ['pants_2'] = 0,
			['shoes_1'] = 57,   ['shoes_2'] = 0,
			['chain_1'] = 96,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	boss_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 249,   ['torso_2'] = 1,
			['decals_1'] = 58,   ['decals_2'] = 0,
			['arms'] = 88,
			['pants_1'] = 52,   ['pants_2'] = 2,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['chain_1'] = 126,    ['chain_2'] = 0,
			['bproof_1'] = 1,  ['bproof_2'] = 0,			
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 1,  ['tshirt_2'] = 0,
			['torso_1'] = 257,   ['torso_2'] = 1,
			['decals_1'] = 66,   ['decals_2'] = 0,
			['arms'] = 104,
			['pants_1'] = 54,   ['pants_2'] = 2,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['chain_1'] = 96,    ['chain_2'] = 0,
			['bproof_1'] = 1,  ['bproof_2'] = 0,			
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	clear_wear = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['bproof_1'] = -1,  ['bproof_2'] = 0,
			['decals_1'] = -1,   ['decals_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['bproof_1'] = -1,  ['bproof_2'] = 0,
			['decals_1'] = -1,   ['decals_2'] = 0
		}
	}
}
