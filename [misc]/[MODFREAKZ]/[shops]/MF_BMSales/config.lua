MF_BMSales = {}
local MFS = MF_BMSales

MFS.Version = '1.0.11'

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

-- For the door.
MFS.ShowBlip = false
MFS.DrawTextDist = 10.0
MFS.NotificationTime = 5.0

MFS.PoliceNotifyCountdown = 0.5 -- minutes from reaching dealer until police are notified.
MFS.NotifyPoliceTimer = 10
MFS.PoliceJobName = "police"
MFS.MinPoliceOnline = 0

-- The door.
MFS.HintLocation      =   vector4(167.8,-2221.99,7.24,359.23)
MFS.SalesLocations    =   {
  [1] = vector4(167.8,-2221.99,7.24,359.23),
  [2] = vector4(-88.32,6358.17,31.58,222.9),
  [3] = vector4(1980.61,3047.74,47.22,164.51),
  [4] = vector4(445.99,-1232.65,29.93,279.24),
  [5] = vector4(-960.8,-1101.38,2.15,40.03),
  [6] = vector4(901.34,-1922.37,30.64,105.03),
  [7] = vector4(-1461.76,-177.43,48.82,30.43),
  [8] = vector4(1196.74,-3253.36,7.1,88.73),
}

MFS.TargetAverageSpeed = 60.0

MFS.DealerPed = 'a_m_y_business_01'

MFS.DrugItems = {
  ['Gold'] = 'gold',
  ['Rolex'] = 'rolex',
  ['Diamond'] = 'diamond',  
}

MFS.DrugPrices = {
  ['gold'] = 1000,
  ['rolex'] = 900,
  ['diamond'] = 1600,
}

MFS.MaxPriceVariance = 10.0 --%