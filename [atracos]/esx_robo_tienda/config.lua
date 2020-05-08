Config = {}
Config.Locale = 'en'

Config.Marker = {
	r = 250, g = 0, b = 0, a = 100,  -- red color
	x = 1.0, y = 1.0, z = 1.0,       -- tiny, cylinder formed circle
	DrawDistance = 15.0, Type = 29    -- default circle type, low draw distance due to indoors area
}

Config.PoliceNumberRequired = 2
Config.TimerBeforeNewRob    = 1800 -- The cooldown timer on a store after robbery was completed / canceled, in seconds

Config.MaxDistance    = 20   -- max distance from the robbary, going any longer away from it will to cancel the robbary
Config.GiveBlackMoney = true -- give black money? If disabled it will give cash instead

Stores = {
		["littleseoul_twentyfourseven"] = {
		position = { x = -709.59, y = -904.18, z = 19.50 },
		reward = math.random(6000, 8000),
		nameOfStore = "24/7 (Tienda)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	
	}
}
