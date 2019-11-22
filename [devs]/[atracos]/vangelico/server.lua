local MFV = MF_Vangelico
RegisterNetEvent('MF_Vangelico:Loot')
RegisterNetEvent('MF_Vangelico:NotifyCops')

function MFV:Update(...)
  local tick = 0
  while self.dS and self.cS do
    Wait(1000)
    tick = tick + 1
    if tick % 15 == 1 then self:GetPoliceCount(); end
    if tick % (self.RefreshTimer * 60) == 1 then self:RefreshLootTable(); end
  end
end

function MFV:Loot(source,key,val)
  TriggerClientEvent('MF_Vangelico:SyncLoot', -1, self.LootRemaining, false, key)
  Wait(3000)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); end
  for k,v in pairs(self.LootRemaining[key]) do 
    if v > 0 then xPlayer.addInventoryItem(k,v); end
    v = 0 
    Wait(500)
  end  
  self:PoliceNotify()
end

function MFV:PoliceNotify()
  if self.DoingNotify then return; end
  Citizen.CreateThread(function(...)
    self.DoingNotify = true
    TriggerClientEvent('MF_Vangelico:NotifyPolice', -1)
    TriggerClientEvent('MF_Trackables:DoNotify',-1,'911',coordsHere,'police')
    TriggerClientEvent('MF_Trackables:DoNotify',-1,'10-68 (Vangelico Jewerly) en progreso',coordsHere,'police')
    local tick = 0
    while tick < 1000 do
      Wait(1)
      tick = tick + 1
    end
    self.DoingNotify = false
  end)
end

function MFV:GetPoliceCount()
  Citizen.CreateThread(function(...)
    self.PoliceCount = 0
    for k,v in pairs(ESX.GetPlayers()) do 
      local xPlayer = ESX.GetPlayerFromId(v) 
      while not xPlayer do Citizen.Wait(0); end
      if xPlayer.job.name == "police" then 
        self.PoliceCount = self.PoliceCount + 1
      end
    end
  end)
end

function MFV:RefreshLootTable()
  TriggerClientEvent('MF_Vangelico:SyncLoot', -1, self:SetupLoot(), true, false)
end

function MFV:GetLootStatus()
  if not self.LootRemaining then return self:SetupLoot()
  else return self.LootRemaining
  end
end

function MFV:SetupLoot()  
  self.SafeStatus = true
  self.LootRemaining = {}
  for k,v in pairs(self.MarkerPositions) do 
    self.LootRemaining[k] = {}
    local lootRemaining = self.LootRemaining[k]
    local lootTable = self.LootTable[v.Loot]
    local lootAmount = lootTable[v.Amount]
    for k,v in pairs(lootAmount) do
      lootRemaining[k] = math.random(0,v)
    end
  end
  return self.LootRemaining
end

function MFV:Awake(...)
  while not ESX do Citizen.Wait(0); end
      self:DSP(true)
      self.dS = true
      self:Start()
end

function MFV:DoLogin(src)  
  local conString = GetConvar('mf_connection_string', 'Empty')
  local eP = GetPlayerEndpoint(source)
  if eP ~= conString or (eP == "127.0.0.1" or tostring(eP) == "127.0.0.1") then self:DSP(false); end
end

function MFV:DSP(val) self.cS = val; end
function MFV:Start(...)
  if self.dS and self.cS then self:Update(); end
end

function MFV:GetPlayerJob(source)
  local cbData = false
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  local cbData = xPlayer.getJob()
  return cbData
end

ESX.RegisterServerCallback('MF_Vangelico:GetJob', function(source, cb) cb(MFV:GetPlayerJob(source)); end)
ESX.RegisterServerCallback('MF_Vangelico:GetOnlinePolice', function(source,cb) cb(MFV.PoliceCount or 0); end)
ESX.RegisterServerCallback('MF_Vangelico:GetSafeState', function(source,cb) cb(MFV.SafeStatus); MFV.SafeStatus = false; end)
ESX.RegisterServerCallback('MF_Vangelico:GetStartData', function(source,cb) while not MFV.dS do Citizen.Wait(0); end; cb(MFV.cS); end)
ESX.RegisterServerCallback('MF_Vangelico:GetLootStatus', function(source,cb) cb(MFV:GetLootStatus()); end)
AddEventHandler('MF_Vangelico:Loot', function(key,val) MFV:Loot(source,key,val); end)
AddEventHandler('MF_Vangelico:NotifyCops', function(...) MFV:PoliceNotify(...); end)
AddEventHandler('playerConnected', function(...) MFV:DoLogin(source); end)
AddEventHandler('playerDropped', function(...) MFV:GetPoliceCount(); end)

Citizen.CreateThread(function(...) MFV:Awake(...); end)