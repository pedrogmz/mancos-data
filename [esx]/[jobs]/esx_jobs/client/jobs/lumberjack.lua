Config.Jobs.lumberjack = {

	BlipInfos = {
		Sprite = 237,
		Color = 4
	},

	Vehicles = {

		Truck = {
			Spawner = 1,
			Hash = "burrito3",
			HasCaution = true
		}

	},

	Zones = {

		CloakRoom = {
			Pos = {x = 1200.63, y = -1276.87, z = 35.38},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 39,
			Blip = true,
			Name = _U("lj_locker_room"),
			Type = "cloakroom",
			Hint = _U("cloak_change")
		},

		Wood = {
			Pos = {x = -534.32, y = 5373.79, z = 69.50},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			Color = {r = 255, g = 0, b = 0},
			Marker = 11,
			Blip = true,
			Name = _U("lj_mapblip"),
			Type = "work",
			Item = {
				{
					name = _U("lj_wood"),
					db_name = "wood",
					time = 4500,
					max = 100,
					add = 1,
					remove = 1,
					requires = "nothing",
					requires_name = "Nothing",
					drop = 100
				}
			},
			Hint = _U("lj_pickup")
		},

		CuttedWood = {
			Pos = {x = -551.19, y = 5331.24, z = 75.08},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			Color = {r = 255, g = 0, b = 0},
			Marker = 12,
			Blip = true,
			Name = _U("lj_cutwood"),
			Type = "work",
			Item = {
				{
					name = _U("lj_cutwood"),
					db_name = "cutted_wood",
					time = 5000,
					max = 50,
					add = 1,
					remove = 2,
					requires = "wood",
					requires_name = _U("lj_wood"),
					drop = 100
				}
			},
			Hint = _U("lj_cutwood_button")
		},

		Planks = {
			Pos = {x = -501.75, y = 5281.29, z = 80.62},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			Color = {r = 255, g = 0, b = 0},
			Marker = 13,
			Blip = true,
			Name = _U("lj_board"),
			Type = "work",
			Item = {
				{
					name = _U("lj_planks"),
					db_name = "packaged_plank",
					time = 5000,
					max = 100,
					add = 1,
					remove = 2,
					requires = "cutted_wood",
					requires_name = _U("lj_cutwood"),
					drop = 100
				}
			},
			Hint = _U("lj_pick_boards")
		},

		VehicleSpawner = {
			Pos = {x = 1212.71, y = -1262.61, z = 35.23},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			Color = {r = 0, g = 255, b = 0},
			Marker = 39,
			Blip = true,
			Name = _U("spawn_veh"),
			Type = "vehspawner",
			Spawner = 1,
			Hint = _U("spawn_veh_button"),
			Caution = 200
		},

		VehicleSpawnPoint = {
			Pos = {x = 1207.75, y = -1260.95, z = 34.04},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Marker = -1,
			Blip = true,
			Name = _U("service_vh"),
			Type = "vehspawnpt",
			Spawner = 1,
			Heading = 175.36
		},

		VehicleDeletePoint = {
			Pos = {x = 1195.74, y = -1261.51, z = 34.25},
			Size = {x = 4.0, y = 4.0, z = 1.0},
			Color = {r = 255, g = 0, b = 0},
			Marker = 25,
			Blip = true,
			Name = _U("return_vh"),
			Type = "vehdelete",
			Hint = _U("return_vh_button"),
			Spawner = 1,
			Caution = 200,
			GPS = 0,
			Teleport = 0
		},

		Delivery = {
			Pos = {x = 1218.55, y = -1267.0, z = 36.42},
			Color = {r = 3, g = 145, b = 232},
			Size = {x = 1.0, y = 1.0, z = 1.0},
			Marker = 29,
			Blip = true,
			Name = _U("delivery_point"),
			Type = "delivery",
			Spawner = 1,
			Item = {
				{
					name = _U("delivery"),
					time = 500,
					remove = 1,
					max = 100, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
					price = 33,
					requires = "packaged_plank",
					requires_name = _U("lj_planks"),
					drop = 100
				}
			},
			Hint = _U("lj_deliver_button")
		}

	}
}
