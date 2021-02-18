Config = {}
Config.Locale = 'es'

Config.Marker = {
	r = 250, g = 0, b = 0, a = 100,  -- red color
	x = 1.0, y = 1.0, z = 1.0,       -- tiny, cylinder formed circle
	DrawDistance = 15.0, Type = 29    -- default circle type, low draw distance due to indoors area
}

Config.PoliceNumberRequired = 2
Config.TimerBeforeNewRob    = 3600 -- The cooldown timer on a store after robbery was completed / canceled, in seconds

Config.MaxDistance    = 20   -- max distance from the robbary, going any longer away from it will to cancel the robbary
Config.GiveBlackMoney = true -- give black money? If disabled it will give cash instead

Stores = {
	["littleseoul_twentyfourseven"] = {
		position = {
			x = -709.59,
			y = -904.18,
			z = 19.50
		},
		reward = math.random(8000, 10000),
		nameOfStore = "24/7 (Tienda)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["littleseoul_twentyfourseven2"] = {
		position = {
			x = 379.3,
			y = 332.28,
			z = 104.57
		},
		reward = math.random(8000, 10000),
		nameOfStore = "24/7 (Tienda)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["littleseoul_twentyfourseven3"] = {
		position = {
			x = 2550.17,
			y = 386.17,
			z = 109.62
		},
		reward = math.random(8000, 10000),
		nameOfStore = "24/7 (Tienda)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["littleseoul_twentyfourseven4"] = {
		position = {
			x = -3047.38,
			y = 587.09,
			z = 9.91
		},
		reward = math.random(8000, 10000),
		nameOfStore = "24/7 (Tienda)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["littleseoul_twentyfourseven5"] = {
		position = {
			x = -3249.08,
			y = 1005.33,
			z = 13.83
		},
		reward = math.random(8000, 10000),
		nameOfStore = "24/7 (Tienda)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["littleseoul_twentyfourseven6"] = {
		position = {
			x = 545.2,
			y = 2663.61,
			z = 43.16
		},
		reward = math.random(8000, 10000),
		nameOfStore = "24/7 (Tienda)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["littleseoul_twentyfourseven7"] = {
		position = {
			x = 1960.82,
			y = 3748.87,
			z = 33.34
		},
		reward = math.random(8000, 10000),
		nameOfStore = "24/7 (Tienda)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["littleseoul_twentyfourseven8"] = {
		position = {
			x = 2674.16,
			y = 3287.51,
			z = 56.24
		},
		reward = math.random(8000, 10000),
		nameOfStore = "24/7 (Tienda)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["littleseoul_twentyfourseven9"] = {
		position = {
			x = 1736.53,
			y = 6419.02,
			z = 36.04
		},
		reward = math.random(8000, 10000),
		nameOfStore = "24/7 (Tienda)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	}
}
