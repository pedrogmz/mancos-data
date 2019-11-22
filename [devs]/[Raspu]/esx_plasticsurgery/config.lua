Config = {}
Config.Locale = 'en'

Config.MarkerType   = -1
Config.DrawDistance = 100.0
Config.MarkerSize   = {x = 2.0, y = 2.0, z = 1.0}
Config.MarkerColor  = {r = 102, g = 102, b = 204}

Config.BlipPlasticSurgery = {
	Sprite = 403,
	Color = 0,
	Display = 2,
	Scale = 1.0
}

Config.Price = 1700 -- Edit to your liking.

Config.EnableUnemployedOnly = true -- If true it will only show Blips to Unemployed Players | false shows it to Everyone.
Config.EnableBlips = true -- If true then it will show blips | false does the Opposite.
Config.EnablePeds = true -- If true then it will add Peds on Markers | false does the Opposite.

Config.Locations = {
	{ x = 329.15, y = -573.1, z = 27.79, heading = 284.41 }, -- Police Booking Room
	{ x = 330.64, y = -573.68, z = 27.79, heading = 57.07 } -- Hospital Bottom Floor
	--{ x = 340.0, y = -581.9, z = 27.79, heading = 281.39 } -- Pillbox Hill MLO
}

Config.Zones = {}

for i=1, #Config.Locations, 1 do
	Config.Zones['Shop_' .. i] = {
		Pos   = Config.Locations[i],
		Size  = Config.MarkerSize,
		Color = Config.MarkerColor,
		Type  = Config.MarkerType
	}
end
