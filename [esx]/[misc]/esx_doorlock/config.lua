Config = {}
Config.Locale = 'es'

Config.DoorList = {
    -- Puertas del banco central    
    {
        objName = 'hei_v_ilev_bk_gate2_pris',
	   objCoords  = vector3(261.99899291992, 221.50576782227, 106.68346405029),
	   textCoords = vector3(261.99899291992, 221.50576782227,  107.68346405029),
	   authorizedJobs = { 'police' },
	   locked = true,
	   distance = 12,
	   size = 2
    },

	-- Puertas La Cosa Nostra
	{
		textCoords = vector3(1395.97, 1141.82, 114.65),
		authorizedJobs = { 'medellin' },
		locked = true,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_ra_door4l', --puerta izquierda
				objYaw = -90.0,
				objCoords = vector3(1395.920, 1142.904, 114.700)
			},

			{
				objName = 'v_ilev_ra_door4r', -- puerta derecha
				objYaw = 90.0,
				objCoords = vector3(1395.919, 1140.704, 114.790)
			}
		}
	},
    --
    -- AMBULANCE
    --
    -- PUERTA CENTRAL DE TAQUILLAS
    	{
		objName = 'v_ilev_cor_firedoorwide',
		objYaw = -110.0,
		objCoords  = vector3(337.2274, -584.0469, 28.81494),
		textCoords = vector3(337.5, -583.28, 29.3),
		authorizedJobs = { 'ambulance' },
		locked = true
	},
    --DOBLE PUERTAS DE LA IZQUIERDA
    	{
		textCoords = vector3(334.37, -592.5, 29.3),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_cor_firedoor',
				objYaw = -110.0,
				objCoords  = vector3(333.7885, -593.4055, 28.80277),
			},

			{
				objName = 'v_ilev_cor_firedoor',
				objYaw = 70.0,
				objCoords = vector3(334.5754, -591.2445, 28.80277),
			}
		}
	},
	    --DOBLE PUERTAS DE LA DERECHA
    	{
		textCoords = vector3(341.98, -571.50, 29.3),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_cor_firedoor',
				objYaw = -110.0,
				objCoords  = vector3(341.392, -572.5071, 28.81897),
			},

			{
				objName = 'v_ilev_cor_firedoor',
				objYaw = 70.0,
				objCoords = vector3(342.1784, -570.3473, 28.81897),
			}
		}
	},
	    --DOBLE PUERTAS DE ATRAS (parking)
    	{
		textCoords = vector3(319.90, -560.15, 29.3),
		authorizedJobs = { 'ambulance' },
		locked = true,
		distance = 2.5,
		doors = {
			{
				objName = 'hei_prop_heist_cutscene_doorc_r',
				objYaw = 25.0,
				objCoords  = vector3(321.0088, -559.9609, 28.88031),
			},

			{
				objName = 'hei_prop_heist_cutscene_doorc_r',
				objYaw = -153.0,
				objCoords = vector3(318.7677, -561.0198, 28.88031),
			}
		}
	},

	    --DOBLE PUERTAS INGRESOS, CAMAS
    	-- {
		-- textCoords = vector3(346.0, -568.31, 29.3),
		-- authorizedJobs = { 'ambulance' },
		-- locked = false,
		-- distance = 2.5,
		-- doors = {
			-- {
				-- objName = 'v_ilev_cor_firedoor',
				-- objYaw = 161.0,
				-- objCoords  = vector3(345.0586, -567.9648, 28.82051),
			-- },

			-- {
				-- objName = 'v_ilev_cor_firedoor',
				-- objYaw = -20.0,
				-- objCoords = vector3(347.2267, -568.7333, 28.82051),
			-- }
		-- }
	-- },
	    --DOBLE PUERTAS URGENCIAS!
    	{
		textCoords = vector3(346.26, -573.0, 29.3),
		authorizedJobs = { 'ambulance' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_cor_firedoor',
				objYaw = 69.0,
				objCoords  = vector3(346.8181, -572.0256, 28.7973),
			},

			{
				objName = 'v_ilev_cor_firedoor',
				objYaw = -109.0,
				objCoords = vector3(346.031, -574.1888, 28.7973),
			}
		}
	},

	--
	-- Mission Row First Floor
	--

	-- Entrance Doors
	{
		textCoords = vector3(434.7, -982.0, 31.5),
		authorizedJobs = { 'police' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_ph_door01',
				objYaw = -90.0,
				objCoords = vector3(434.7, -980.6, 30.8)
			},

			{
				objName = 'v_ilev_ph_door002',
				objYaw = -90.0,
				objCoords = vector3(434.7, -983.2, 30.8)
			}
		}
	},

	-- To locker room & roof
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 90.0,
		objCoords  = vector3(449.6, -986.4, 30.6),
		textCoords = vector3(450.1, -986.3, 31.7),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Rooftop
	{
		objName = 'v_ilev_gtdoor02',
		objYaw = 90.0,
		objCoords  = vector3(464.3, -984.6, 43.8),
		textCoords = vector3(464.3, -984.0, 44.8),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Hallway to roof
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = 90.0,
		objCoords  = vector3(461.2, -985.3, 30.8),
		textCoords = vector3(461.5, -986.0, 31.5),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Armory
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = -90.0,
		objCoords  = vector3(452.6, -982.7, 30.6),
		textCoords = vector3(453.0, -982.6, 31.7),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Captain Office
	{
		objName = 'v_ilev_ph_gendoor002',
		objYaw = -180.0,
		objCoords  = vector3(447.2, -980.6, 30.6),
		textCoords = vector3(447.2, -980.0, 31.7),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- To downstairs (double doors)
	{
		textCoords = vector3(444.6, -989.4, 31.7),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 180.0,
				objCoords = vector3(443.9, -989.0, 30.6)
			},

			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 0.0,
				objCoords = vector3(445.3, -988.7, 30.6)
			}
		}
	},

	--
	-- Mission Row Cells
	--

	-- Main Cells
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 0.0,
		objCoords  = vector3(463.8, -992.6, 24.9),
		textCoords = vector3(463.3, -992.6, 25.1),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = -90.0,
		objCoords  = vector3(462.3, -993.6, 24.9),
		textCoords = vector3(461.8, -993.3, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 2
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.3, -998.1, 24.9),
		textCoords = vector3(461.8, -998.8, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- Cell 3
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.7, -1001.9, 24.9),
		textCoords = vector3(461.8, -1002.4, 25.0),
		authorizedJobs = { 'police' },
		locked = true
	},

	-- To Back
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(463.4, -1003.5, 25.0),
		textCoords = vector3(464.0, -1003.5, 25.5),
		authorizedJobs = { 'police' },
		locked = true
	},

	--
	-- Mission Row Back
	--

	-- Back (double doors)
	{
		textCoords = vector3(468.6, -1014.4, 27.1),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_rc_door2',
				objYaw = 0.0,
				objCoords  = vector3(467.3, -1014.4, 26.5)
			},

			{
				objName = 'v_ilev_rc_door2',
				objYaw = 180.0,
				objCoords  = vector3(469.9, -1014.4, 26.5)
			}
		}
	},

	-- Back Gate
	{
		objName = 'hei_prop_station_gate',
		objYaw = 90.0,
		objCoords  = vector3(488.8, -1017.2, 27.1),
		textCoords = vector3(488.8, -1020.2, 30.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	},

	--
	-- Sandy Shores
	--

	-- Entrance
	{
		objName = 'v_ilev_shrfdoor',
		objYaw = 30.0,
		objCoords  = vector3(1855.1, 3683.5, 34.2),
		textCoords = vector3(1855.1, 3683.5, 35.0),
		authorizedJobs = { 'police' },
		locked = false
	},

	--
	-- Paleto Bay
	--

	-- Entrance (double doors)
	{
		textCoords = vector3(-443.5, 6016.3, 32.0),
		authorizedJobs = { 'police' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_shrf2door',
				objYaw = -45.0,
				objCoords  = vector3(-443.1, 6015.6, 31.7),
			},

			{
				objName = 'v_ilev_shrf2door',
				objYaw = 135.0,
				objCoords  = vector3(-443.9, 6016.6, 31.7)
			}
		}
	},

	--
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1844.9, 2604.8, 44.6),
		textCoords = vector3(1844.9, 2608.5, 48.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1818.5, 2604.8, 44.6),
		textCoords = vector3(1818.5, 2608.4, 48.0),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 12,
		size = 2
	},
	
	--verja priche delantera
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(-1546.223, 2149.0740, 54.3138),
		textCoords = vector3(-1545.42, 2145.85, 56.5),
		authorizedJobs = { 'priche' },
		locked = true,
		distance = 14,
		size = 2
	},
	
	--verja priche cascada
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(-1621.201, 2092.8684, 63.5272),
		textCoords = vector3(-1619.45, 2089.82, 65.5),
		authorizedJobs = { 'priche' },
		locked = true,
		distance = 14,
		size = 2
	},
	
	--verja lost
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(963.3070, -141.8311, 73.4987),
		textCoords = vector3(959.85, -140.06, 76.0),
		authorizedJobs = { 'lost' },
		locked = true,
		distance = 14,
		size = 2
	},
	
	--verja medellin izquierda
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(1312.4084, 1184.9861, 105.8989),
		textCoords = vector3(1313.24, 1188.73, 108.0),
		authorizedJobs = { 'medellin' },
		locked = true,
		distance = 14,
		size = 2
	},
	
	--verja medellin derecha
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(1314.0038, 1101.1686, 104.7209),
		textCoords = vector3(1314.0, 1105.12, 108.0),
		authorizedJobs = { 'medellin' },
		locked = true,
		distance = 14,
		size = 2
	},
	
	--verja yakuza1
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(2441.4248, 4847.0469, 36.0958),
		textCoords = vector3(2437.75, 4847.0, 38.5),
		authorizedJobs = { 'yakuza' },
		locked = true,
		distance = 14,
		size = 2
	},
	
	--verja yakuza2
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(2524.6321, 4893.3760, 36.6127),
		textCoords = vector3(2527.37, 4895.88, 38.5),
		authorizedJobs = { 'yakuza' },
		locked = true,
		distance = 14,
		size = 2
	},
	
	--verja yakuza3
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(2377.2180, 5096.4463, 46.2558),
		textCoords = vector3(2375.54, 5093.45, 48.5),
		authorizedJobs = { 'yakuza' },
		locked = true,
		distance = 14,
		size = 2
	},
	
	--verja yakuza4
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(2367.9197, 4923.5615, 41.1142),
		textCoords = vector3(2370.95, 4921.03, 43.5),
		authorizedJobs = { 'yakuza' },
		locked = true,
		distance = 14,
		size = 2
	},
	
	--mecanico puerta 1
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(-360.0802, -182.9115, 36.3997),
		textCoords = vector3(-356.75, -181.34, 38.50),
		authorizedJobs = { 'mechanic' },
		locked = true,
		distance = 14,
		size = 2
	},
	
	--mecanico puerta 2
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(-407.8112, -83.3168, 41.0279),
		textCoords = vector3(-410.76, -85.02, 42.50),
		authorizedJobs = { 'mechanic' },
		locked = true,
		distance = 14,
		size = 2
	},
	
	--mecanico puerta 3
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(-393.9390, -61.8815, 43.8190),
		textCoords = vector3(-396.56, -64.39, 45.50),
		authorizedJobs = { 'mechanic' },
		locked = true,
		distance = 14,
		size = 2
	},
	
	--bennys puerta 1
	{
		objName = 'hei_PROP_STATION_gate',
		objCoords  = vector3(-244.0590, -1302.751, 30.2982),
		textCoords = vector3(-244.35, -1305.74, 32.5),
		authorizedJobs = { 'mancosclub' },
		locked = true,
		distance = 14,
		size = 2
	},
	
	--bennys puerta 2
	{
		objName = 'PROP_facgate_07b',
		objCoords  = vector3(-172.5941, -1292.921, 30.3161),
		textCoords = vector3(-183.84, -1293.17, 32.5),
		authorizedJobs = { 'mancosclub' },
		locked = true,
		distance = 16,
		size = 2
	},

	--
	-- Addons
	--

	-- Entrance Gate (Mission Row mod) https://www.gta5-mods.com/maps/mission-row-pd-ymap-fivem-v1
	{
		objName = 'prop_gate_airport_01',
		objCoords  = vector3(412.7, -1026.55, 29.39),
		textCoords = vector3(412.66, -1021.00, 32.00),
		authorizedJobs = { 'police' },
		locked = true,
		distance = 14,
		size = 2
	}
}