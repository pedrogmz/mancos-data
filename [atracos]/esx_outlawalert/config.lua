Config = {}

Config.Locale = 'es'

-- Set the time (in minutes) during the player is outlaw
Config.Timer = 1

-- Set if show alert when player use Function
Config.GunshotAlert = true
Config.ATMAlert = true
Config.TruckRobberyAlert = true
Config.RobNPCAlert = true
Config.HoldUpAlert = true
Config.CarJackingAlert = true
Config.MeleeAlert = false
Config.DrugAlert = true

-- In seconds
Config.BlipGunTime = 30
Config.BlipTruckRobberyTime = 30
Config.BlipMeleeTime = 7
Config.BlipRobNPCTime = 15
Config.BlipHoldUpTime = 30
Config.BlipJackingTime = 10
Config.BlipDrugTime = 15

-- Blip radius, in float value!
Config.BlipGunRadius = 50.0
Config.BlipTruckRobberyRadius = 40.0
Config.BlipMeleeRadius = 50.0
Config.BlipRobNPCRadius = 100.0
Config.BlipHoldUpRadius = 100.0
Config.BlipJackingRadius = 50.0
Config.BlipDrugRadius = 100.0

-- Show notification when cops steal too?
Config.ShowCopsMisbehave = true

-- Jobs in this table are considered as cops
Config.WhitelistedCops = {
	'police'
}

Config.AlertJacking = 50

Config.AlertShooting = 200

Config.AlertMelee = 100