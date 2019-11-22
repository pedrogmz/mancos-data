Config                            = {}
Config.Locale                     = 'en'

--- #### BASICS
Config.EnablePrice = true -- false = bikes for free
Config.EnableEffects = true
Config.EnableBlips = true


--- #### PRICES	
Config.PriceSanchez = 89
Config.PriceSanchez2 = 99
Config.PriceManchez = 129
Config.PriceBf400 = 109


--- #### MARKER EDITS
Config.TypeMarker = 2
Config.MarkerScale = {{x = 3.0,y = 3.0,z = 0.0}}
Config.MarkerColor = {{r = 0,g = 139,b = 255}}
	
Config.MarkerZones = { 

    {x = 2662.22,y = 3272.96,z = 54.24},
    {x = 109.59, y = 6627.65, z = 30.79},
    {x = 433.94,y = 3574.03,z = 32.28}, 
    
}


-- Edit blip titles
Config.BlipZones = { 

   {title="Alquiler Moto", colour=38, id=348, x = 2662.22,y = 3272.96,z = 54.24},
   {title="Alquiler Moto", colour=38, id=348, x = 109.59, y = 6627.65, z = 30.79},
   {title="Alquiler Moto", colour=38, id=348, x = 433.94,y = 3574.03,z = 32.28},
      
}
