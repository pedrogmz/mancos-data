Config              = {}
Config.DrawDistance = 100.0
Config.CopsRequired = 2
Config.BlipUpdateTime = 5000 --In milliseconds. I used it on 3000. If you want instant update, 50 is more than enough. Even 100 is good. I hope it doesn't kill FPS and the server.
Config.CooldownMinutes = 180
Config.Locale = 'es'

Config.Zones = {
	VehicleSpawner = {
		Pos   = {x = -1015.67, y = -1907.39, z = 14.48},
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Color = {r = 255, g = 0, b = 0},
		Type  = 36,
		Colour    = 1, --BLIP
	},
}

Config.VehicleSpawnPoint = {
      Pos   = {x = -1012.22, y = -1900.17, z = 13.62},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Type  = 1,
}

Config.Delivery = {
	--1 Norte Sandy Shore # VALIDO
	--Trevor Airfield 8.011KM 
	Delivery1 = {
		Pos      = {x = 2130.68, y = 4781.32, z = 39.87},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1,
		Payment  = math.random(5000,25000),
		Cars = {'zentorno','t20','reaper'},
	},
	--2 Faro Sandy Shore # VALIDO
	--Lighthouse 8.598KM
	Delivery4 = {
		Pos      = {x = 3333.51, y = 5159.91, z = 17.20},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1,
		Payment  = math.random(5000,25000),
		Cars = {'sultanrs','osiris','cyclone'},
	},
	--3 Oeste Paleto Pueblo # VALIDO
	--House in Paleto 9.569KM
	Delivery7 = {
		Pos      = {x = -359.24, y = 6254.51, z = 31.49},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1,
		Payment  = math.random(5000,25000),
		Cars = {'entityxf','sheava'},
	},
	--4 Autovia Oeste # VALIDO
	--Chumash Norte 8.180KM
	Delivery10 = {
		Pos      = {x = -2220.62, y = 4231.85, z = 46.18},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1,
		Payment  = math.random(5000,25000),
		Cars = {'nero','seven70'},
	},
	--5 Granero Rojo Sur Sandy Shore # VALIDO
	--Desierto de Gran Señora 5.734KM
	Delivery13 = {
		Pos      = {x = 190.41, y = 2456.73, z = 54.71},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1,
		Payment  = math.random(5000,25000),
		Cars = {'specter','xa21','vagner'},
	},
	--6 Casa roja # VALIDO
	--Colinas de Tongva 6.392KM 
	Delivery13 = {
		Pos      = {x = -2597.71, y = 1929.8, z = 166.31},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1,
		Payment  = math.random(5000,25000),
		Cars = {'pfister811','gp1'},
	},
	--7 Garaje Roto Sandy Shore pegado al lago # VALIDO
	--Sandy Shore 6.792
	Delivery13 = {
		Pos      = {x = 895.02, y = 3603.87, z = 30.72},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1,
		Payment  = math.random(5000,25000),
		Cars = {'turismor','italigtb'},
	},
	--8 Granja de vacas # VALIDO
	--Monte Chiliad 9.68015KM
	Delivery13 = {
		Pos      = {x = 432.13, y = 6466.27, z = 27.76},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1,
		Payment  = math.random(5000,25000),
		Cars = {'neon','tempesta'},
	},
	--9 Garaje centro Paleto Bay # VALIDO
	--Paleto Bay 9.72215KM
	Delivery13 = {
		Pos      = {x = -24.59, y = 6460.09, z = 30.41},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1,
		Payment  = math.random(5000,25000),
		Cars = {'raiden','nightshade'},
	},
	--10 Tienda Ropa 14 # VALIDO
	--Rio Zancudo 6.339KM
	Delivery13 = {
		Pos      = {x = -1130.83, y = 2699.28, z = 17.8},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1,
		Payment  = math.random(5000,25000),
		Cars = {'banshee2','ruston'},
	},
	--11 Casa Lago Norte # VALIDO
	--Alamo Sea - North Calafia Way 7.379KM
	Delivery13 = {
		Pos      = {x = 706.07, y = 4180.19, z = 39.71},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1,
		Payment  = math.random(5000,25000),
		Cars = {'sc1','comet5'},
	},
}
