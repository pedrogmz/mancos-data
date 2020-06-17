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

MFS.GetSickAt       = 40 -- only change the first value (percent player gets sick at)
MFS.ExtremelySickAt = 70 -- only change the first value (percent player vomits at)

MFS.CoughTimer      = 30 -- seconds between cough
MFS.VomitTimer      = 45 -- seconds between vomit
MFS.VomitHealthLoss = 10 -- from vomiting

MFS.DrugsTimer      = 60 -- how long drugs last (seconds)
MFS.SmokeRelief     = 10 -- from smoking cigarette
MFS.JointRelief     = 20 -- from smoking joint
MFS.AlchoholRelief  = 20 -- from drinking alchohol beverage
MFS.DrinkingRelief  = 10 -- from drinking non-alchoholic beverage

MFS.StaticRelief    = 0.1 -- % stress relieved over time from events like swimming, riding bikes, etc.
MFS.StaticAdder     = 1.0 -- % stress gained over time from things like driving too fast.
MFS.CombatAdder     = 1.0 -- % stress gained while in combat
MFS.ShootingAdder   = 1.0 -- % stress gained while shooting
MFS.StressAtSpeed   = 150 -- kph
MFS.RelaxAtSpeed    = 20  -- kph

-- Stress Zones [Zonas de descanso]
MFS.Zones = {
	Badulaque = {
		Pos = {x = -705.7, y = -911.33, z = 19.22},
		Coords = vector3(-705.7,-911.33, 19.22),
		Dist = 50.0, -- Rango de la zona,
		Stress = 30000, -- Total de estrés a quitar cada x tiempo
		Whait = 60000 -- Tiempo de espera entre descanso y descanso [60 segundos - 60000]
	},
	Vanilla = {
		Pos = {x = 115.8, y = -1292.39, z = 28.26},
		Coords = vector3(115.8, -1292.39, 28.26),
		Dist = 25.0, -- Rango de la zona,
		Stress = 30000, -- Total de estrés a quitar cada x tiempo
		Whait = 60000 -- Tiempo de espera entre descanso y descanso [60 segundos - 60000]
	}
}
