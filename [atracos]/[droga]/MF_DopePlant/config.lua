MF_DopePlant = {}
local MFD = MF_DopePlant
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

MFD.FoodDrainSpeed      = 0.0020  -- resta comida (tiempo) -- 0.0200
MFD.WaterDrainSpeed     = 0.0020  -- resta bebida (tiempo) -- 0.0200
MFD.QualityDrainSpeed   = 0.0000  -- resta calidad (cantidad) -- 0.0050

MFD.GrowthGainSpeed     = 0.014  -- velocidad crecimiento por tiempo -- 1.0000 
MFD.QualityGainSpeed    = 0.010  -- cantidad por tiempo (cantidad) -- 0.0100

MFD.SyncDist = 50.0
MFD.InteractDist = 2.5
MFD.PoliceJobLabel = "police"
MFD.WeedPerBag = 20
MFD.JointsPerBag = 10  -- no implementado ??
MFD.BagsPerPapers = 1  -- no implementado ??

MFD.PlantTemplate = {
   ["Gender"] = "Hembra",
  ["Quality"] = 0.0,
   ["Growth"] = 0.0,
    ["Water"] = 20.0,
     ["Food"] = 20.0,
    ["Stage"] = 1,
}

MFD.ItemTemplate = {
     ["Type"] = "Water",
  ["Quality"] = 0.0,
}

MFD.Objects = {
  [1] = "bkr_prop_weed_01_small_01c",
  [2] = "bkr_prop_weed_01_small_01b",
  [3] = "bkr_prop_weed_01_small_01a",
  [4] = "bkr_prop_weed_med_01a",
  [5] = "bkr_prop_weed_med_01b",
  [6] = "bkr_prop_weed_lrg_01a",
  [7] = "bkr_prop_weed_lrg_01b",
}