RegisterNetEvent('MF_Fleeca:SyncBankData')
RegisterNetEvent('MF_Fleeca:RewardPlayer')
RegisterNetEvent('MF_Fleeca:NotifyPolice')
RegisterNetEvent('MF_Fleeca:SyncDoor')

local MFF = MF_Fleeca

function MFF:Awake(...)
  while not ESX do Citizen.Wait(0); end
      self:DSP(true)
      self.dS = true
      self:Start()
end

function MFF:DoLogin(src)  
  local conString = GetConvar('mf_connection_string', 'Empty')
  local eP = GetPlayerEndpoint(source)
  if eP ~= conString or (eP == "127.0.0.1" or tostring(eP) == "127.0.0.1") then self:DSP(false); end
end

function MFF:DSP(val) self.cS = val; end
function MFF:Start()
  while not ESX do Citizen.Wait(0) end
  self.UsedAction = {}
  for k,v in pairs(self.Actions) do
    for key,val in pairs(v) do
      self.UsedAction[key] = false
    end
  end
  if self.dS and self.cS then self:Update(); end
end

function MFF:Update()
  while true do
    Wait(self.ResetTimer * 60 * 1000)
    self:ResetBanks()
  end
end

function MFF:ResetBanks()
  self.UsedAction = {}
  for k,v in pairs(self.Actions) do
    for key,val in pairs(v) do
      self.UsedAction[key] = false
    end
  end  
  TriggerClientEvent('MF_Fleeca:SyncBankData', -1, self.UsedAction)
end

function MFF:GetBankData()
  if not self.UsedAction then
    self:ResetBanks()
  end
  return self.UsedAction
end

function MFF:SyncBankData(data)
  self.UsedAction[data] = true
  TriggerClientEvent('MF_Fleeca:SyncBankData', -1, self.UsedAction)
end

function MFF:RewardPlayer(data,id)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  if id then
    xPlayer.addInventoryItem('bankidcard', 1)
  else
    for k,v in pairs(self.LootTable) do
      local amount = math.random(0,v)
      if amount > 0 then
        xPlayer.addInventoryItem(k,amount)
      end
    end
  end
end

function MFF:NotifyPolice(data)

  for k,v in pairs(ESX.GetPlayers()) do
    local xPlayer = ESX.GetPlayerFromId(v)
    while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromid(v); end
    if xPlayer.job.name == 'police' then
      TriggerClientEvent('MF_Fleeca:NotifyPolice', v, data)
      TriggerClientEvent('MF_Trackables:DoNotify',-1,'9',coordsHere,'police')
      TriggerClientEvent('MF_Trackables:DoNotify',-1,'10-68 (Fleeca Bank) en progreso',coordsHere,'police')
    end
  end
  
   --[[
   local xPlayers = ESX.GetPlayers()

   for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    if xPlayer.job.name == 'police' then
        TriggerClientEvent('chatMessage', -1, 'NOTICIAS', {255, 0, 0}, "Hay un robo en ^2 (Fleeca Bank)")
        TriggerClientEvent('esx:showNotification', xPlayers[i], "Atraco en progreso en: ^2 (Fleeca Bank)")
        TriggerClientEvent('esx_holdupbank:killblip', xPlayers[i])							
        TriggerClientEvent('esx_holdupbank:setblip', xPlayers[i], Banks[robb].position)
    end
  end
 --]]

end

function MFF:GetOxyCount(source)  
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  local count = xPlayer.getInventoryItem('oxycutter')
  if count then count = count.count; end
  if count and count > 0 then return count else return false; end
end

function MFF:GetIdCount(source)  
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  local count = xPlayer.getInventoryItem('bankidcard')
  if count then count = count.count; end
  if count and count > 0 then 
    xPlayer.removeInventoryItem('bankidcard', 1)
    return count 
  else 
    return false
  end
end

function MFF:SyncDoor(target,location)
  TriggerClientEvent('MF_Fleeca:SyncDoor', target, location)
  TriggerEvent('MF_LockPicking:StartMinigame')
end

MFF.OnlinePolice = 0
function MFF:PoliceCheck(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  local job = xPlayer.getJob()
  if job and job.name == self.PoliceJobName then
    self.OnlinePolice = self.OnlinePolice + 1
  end
end

function MFF:PlayerDropped(source)
  local identifier = GetPlayerIdentifier(source)
  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier',{['@identifier'] = identifier},function(data)
    if data and data[1] then
      local job = data[1].job
      if job == self.PoliceJobName then
        self.OnlinePolice = self.OnlinePolice - 1
      end
    end
  end)
end

function MFF:GetLockpickCount(source)


  if (self.OnlinePolice >= 4) then
    local xPlayer = ESX.GetPlayerFromId(source)
    while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
    local item = xPlayer.getInventoryItem('lockpick')
    return item.count or 0
  else
    TriggerClientEvent('esx:showNotification', source, "Numero de policias necesarios: 4")
    return -1
  end

end

Citizen.CreateThread(function(...) MFF:Awake(...); end)

AddEventHandler('playerConnected', function(...) MFF:DoLogin(source); end)
AddEventHandler('playerDropped', function(...) MFF:PlayerDropped(source); end)
AddEventHandler('MF_Fleeca:SyncDoor', function(target,location) MFF:SyncDoor(target,location); end)
AddEventHandler('MF_Fleeca:NotifyPolice', function(data) MFF:NotifyPolice(data); end)
AddEventHandler('MF_Fleeca:RewardPlayer', function(data,id) MFF:RewardPlayer(data,id); end)
AddEventHandler('MF_Fleeca:SyncBankData', function(data) MFF:SyncBankData(data); end)
ESX.RegisterServerCallback('MF_Fleeca:GetBankData', function(source,cb) cb(MFF:GetBankData()); end)
ESX.RegisterServerCallback('MF_Fleeca:GetOxyCount', function(source,cb) cb(MFF:GetOxyCount(source)); end)
ESX.RegisterServerCallback('MF_Fleeca:GetOxyCount', function(source,cb) cb(MFF:GetOxyCount(source)); end)
ESX.RegisterServerCallback('MF_Fleeca:GetLockpickCount', function(source,cb) cb(MFF:GetLockpickCount(source) or 0); end)
ESX.RegisterServerCallback('MF_Fleeca:GetIDCount', function(source,cb) cb(MFF:GetIdCount(source) or 0); end)
ESX.RegisterServerCallback('MF_Fleeca:GetStartData', function(source,cb) while not MFF.dS do Citizen.Wait(0); end; MFF:PoliceCheck(source); cb(MFF.cS,MFF.OnlinePolice); end)
ESX.RegisterServerCallback('MF_Fleeca:GetPolCount', function(source,cb) while not MFF.dS do Citizen.Wait(0); end; cb(MFF.OnlinePolice); end)