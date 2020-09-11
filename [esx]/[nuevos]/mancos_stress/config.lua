-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

MF_Stress = {}
local MFS = MF_Stress

MFS.Version = '1.0.10'

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
Citizen.CreateThread(function(...)
  while not ESX do 
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end) 
    Citizen.Wait(0)
  end
end)

MFS.GetSickAt       = 60 -- only change the first value (percent player gets sick at)
MFS.ExtremelySickAt = 90 -- only change the first value (percent player vomits at)

MFS.CoughTimer      = 30 -- seconds between cough
MFS.VomitTimer      = 45 -- seconds between vomit
MFS.VomitHealthLoss = 10 -- from vomiting

MFS.DrugsTimer      = 60 -- how long drugs last (seconds)
MFS.SmokeRelief     = 100 -- from smoking cigarette
MFS.JointRelief     = 20 -- from smoking joint
MFS.AlchoholRelief  = 20 -- from drinking alchohol beverage
MFS.DrinkingRelief  = 10 -- from drinking non-alchoholic beverage

MFS.StaticRelief    = 0.2 -- % stress relieved over time from events like swimming, riding bikes, etc.
MFS.StaticAdder     = 0.3 -- % stress gained over time from things like driving too fast.
MFS.CombatAdder     = 1.0 -- % stress gained while in combat
MFS.ShootingAdder   = 0.7 -- % stress gained while shooting
MFS.StressAtSpeed   = 190 -- kph
MFS.RelaxAtSpeed    = 20  -- kph

-- Stress Zones [Zonas de descanso]
MFS.Zones = {
	--[[Badulaque = {
		Pos = {x = -705.7, y = -911.33, z = 19.22},
		Coords = vector3(-705.7,-911.33, 19.22),
		Dist = 50.0, -- Rango de la zona,
		Stress = 10000, -- Total de estrés a quitar cada x tiempo
		Whait = 60000 -- Tiempo de espera entre descanso y descanso [60 segundos - 60000]
	},]]
	Police = {
		Pos = {x = 455.8, y = -991.39, z = 30.26},
		Coords = vector3(455.8, -991.39, 30.26),
		Dist = 5.0, -- Rango de la zona,
		Stress = 10000, -- Total de estrés a quitar cada x tiempo
		Whait = 60000 -- Tiempo de espera entre descanso y descanso [60 segundos - 60000]
	},
	Hospital = {
		Pos = {x = 334.8, y = -582.39, z = 28.79},
		Coords = vector3(334.8, -582.39, 28.79),
		Dist = 5.0, -- Rango de la zona,
		Stress = 10000, -- Total de estrés a quitar cada x tiempo
		Whait = 60000 -- Tiempo de espera entre descanso y descanso [60 segundos - 60000]
	},
	Pier = {
		Pos = {x = -3371.54, y = 967.39, z = 8.29},
		Coords = vector3(-3371.8, 967.39, 8.29),
		Dist = 20.0, -- Rango de la zona,
		Stress = 10000, -- Total de estrés a quitar cada x tiempo
		Whait = 60000 -- Tiempo de espera entre descanso y descanso [60 segundos - 60000]
	},
	VinewoodLook = {
		Pos = {x = -426.0, y = 1120.24, z = 325.86},
		Coords = vector3(-426.0, 1120.24, 325.86),
		Dist = 20.0, -- Rango de la zona,
		Stress = 10000, -- Total de estrés a quitar cada x tiempo
		Whait = 60000 -- Tiempo de espera entre descanso y descanso [60 segundos - 60000]
	},
	Piscina = {
		Pos = {x = -3027.92, y = 37.28, z = 10.16},
		Coords = vector3(-3027.92, 37.28, 10.16),
		Dist = 20.0, -- Rango de la zona,
		Stress = 10000, -- Total de estrés a quitar cada x tiempo
		Whait = 60000 -- Tiempo de espera entre descanso y descanso [60 segundos - 60000]
	},
	Bosque = {
		Pos = {x = 501.37, y = 5601.84, z = 796.75},
		Coords = vector3(501.37,5601.84, 796.75),
		Dist = 10.0, -- Rango de la zona,
		Stress = 10000, -- Total de estrés a quitar cada x tiempo
		Whait = 60000 -- Tiempo de espera entre descanso y descanso [60 segundos - 60000]
	},
	Stress1 = {
		Pos = {x = -922.68, y = -743.56, z = 19.92},
		Coords = vector3(-922.68, -743.56, 19.92),
		Dist = 50.0, -- Rango de la zona,
		Stress = 10000, -- Total de estrés a quitar cada x tiempo
		Whait = 60000 -- Tiempo de espera entre descanso y descanso [60 segundos - 60000]
	},
	Stress2 = {
		Pos = {x = 186.77, y = -665.68, z = 43.32},
		Coords = vector3(186.77, -665.68, 43.32),
		Dist = 50.0, -- Rango de la zona,
		Stress = 10000, -- Total de estrés a quitar cada x tiempo
		Whait = 60000 -- Tiempo de espera entre descanso y descanso [60 segundos - 60000]
	},
	Stress3 = {
		Pos = {x = 114.06, y = -1290.12, z = 28.26},
		Coords = vector3(114.06, -1290.12, 28.26),
		Dist = 20.0, -- Rango de la zona,
		Stress = 10000, -- Total de estrés a quitar cada x tiempo
		Whait = 60000 -- Tiempo de espera entre descanso y descanso [60 segundos - 60000]
	},
	Cafe = {
		Pos = {x = 281.47, y = -965.05, z = 29.50},
		Coords = vector3(281.47, -965.05, 29.50),
		Dist = 5.0, -- Rango de la zona,
		Stress = 10000, -- Total de estrés a quitar cada x tiempo
		Whait = 60000 -- Tiempo de espera entre descanso y descanso [60 segundos - 60000]
	},
	Bahamas = {
		Pos = {x = -1391.8, y = -611.92, z = 30.30},
		Coords = vector3(-1391.8, -611.92, 30.30),
		Dist = 10.0, -- Rango de la zona,
		Stress = 10000, -- Total de estrés a quitar cada x tiempo
		Whait = 60000 -- Tiempo de espera entre descanso y descanso [60 segundos - 60000]
	},
	Tequila = {
		Pos = {x = -560.0, y = 287.0, z = 37.00},
		Coords = vector3(-560.0, 287.0, 37.00),
		Dist = 10.0, -- Rango de la zona,
		Stress = 10000, -- Total de estrés a quitar cada x tiempo
		Whait = 60000 -- Tiempo de espera entre descanso y descanso [60 segundos - 60000]
	},
}
