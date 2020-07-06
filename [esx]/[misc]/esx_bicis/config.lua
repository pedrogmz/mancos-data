Config                            = {}
Config.Locale                     = 'en'

--- #### BASICS
Config.EnablePrice = true -- false = bikes for free
Config.EnableEffects = true
Config.EnableBlips = true

--- #### PRICES	
Config.PriceTriBike = 19
Config.PriceScorcher = 27
Config.PriceCruiser = 35
Config.PriceBmx = 42

--- #### MARKER EDITS
Config.TypeMarker = 2
Config.MarkerScale = {{x = 3.0,y = 3.0,z = 0.0}}
Config.MarkerColor = {{r = 204,g = 255,b = 0}}
	
local getServerType = GetConvar("server_number", "Mancos01")
if getServerType == "MancosWL" then
	Config.MarkerZones = {
		{x = -475.01, y = -245.1, z = 34.96},
	}

	Config.BlipZones = {
		{title = "Alquiler Bici", colour = 2, id = 348, x = -475.01, y = -245.1, z = 34.96},
	}
else
	Config.MarkerZones = {
		{x = 300.62,y = -603.31,z = 42.5},
		{x = -60.99,y = -1099.58,z = 25.47},
		{x = -933.86,y = -781.81,z = 14.99}, 
		{x = -1262.36,y = -1438.98,z = 3.45},
		{x = -475.01,y = -245.1,z = 34.96},
	}

	Config.BlipZones = { 
		{title = "Alquiler Bici", colour = 2, id = 348, x = 300.62, y = -603.31, z = 42.5},
		{title = "Alquiler Bici", colour = 2, id = 348, x = -60.99, y = -1099.58, z = 25.47},
		{title = "Alquiler Bici", colour = 2, id = 348, x = -933.86, y = -781.81, z = 14.99},
		{title = "Alquiler Bici", colour = 2, id = 348, x = -1262.36, y = -1438.98, z = 3.45},
		{title = "Alquiler Bici", colour = 2, id = 348, x = -475.01, y = -245.1, z = 34.96},
	}
end

