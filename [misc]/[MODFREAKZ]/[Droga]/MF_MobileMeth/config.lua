-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

MF_MobileMeth = {}
local MFM = MF_MobileMeth
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

MFM.Version = '1.0.11'

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

-- For the door.
MFM.ShowBlip = false

-- Police count and name
MFM.PoliceJobName = "police"
MFM.MinPolCount   = 0

-- Minutes.
MFM.CookTimerA = 1.00 -- prepare ingredients
MFM.CookTimerB = 2.00 -- cook meth
MFM.CookTimerC = 1.30 -- cool meth
MFM.CookTimerD = 1.30 -- package meth

-- The door.
MFM.HintLocation      =   vector4(1001.98,-3194.87,-38.99, 18.88)

-- Possible spawns.
MFM.TruckLocations    =   {
  [1] = vector4(1060.25,-2409.26,29.96,82.70),
  [2] = vector4(-1102.33,-2039.85,13.29,309.93),
  [3] = vector4(123.30,-2580.88,6.0,177.79),
  [4] = vector4(-22.11,-1677.2,28.97,122.73),
  [5] = vector4(-331.19,-1350.4,30.82,179.81),
}

-- Possible dropoffs.
MFM.DropoffLocations  =   {
  [1] = vector3(1372.69,3617.62,34.89),
  [2] = vector3(2343.59,2612.63,46.66),
  [3] = vector3(-1889.90,2045.38,140.87),
  [4] = vector3(440.29,3548.93,32.74),
  [5] = vector3(1726.58,3712.23,33.76),
  [6] = vector4(-30.69,-1230.86,28.84,173.96),
}

-- Models.
MFM.TruckModels = {
  [1] = 'journey',
 -- [2] = 'camper',

}

-- Draw text at this distance.
MFM.DrawTextDist          =   5.0

-- How long the note hangs around for (when knocking on door).
MFM.NotificationTime      =   10

-- How long police have to track a notification (seconds).
MFM.TrackableNotifyTimer  =   15

-- Spawn truck at x meters.
MFM.TruckSpawnDist        =   50.0

-- Veh speed (KPH I think?).
MFM.MinSpeedForCook       =   25.0

-- Vehicle can stop for x amount of seconds before police get notified.
MFM.MaxVehicleStopTime    =   4
