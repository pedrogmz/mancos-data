RegisterNetEvent('MF_LockPicking:MinigameComplete')

local MFL = MF_LockPicking

function MFL:GetLockpickCount(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  local item = xPlayer.getInventoryItem('lockpick')
  return item.count or 0
end

function MFL:MinigameComplete(source,didWin)
  if not didWin then
    local xPlayer = ESX.GetPlayerFromId(source)
    while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
    xPlayer.removeInventoryItem('lockpick',1)
  end

  -- Police calls
  
  
end

function MFL:Awake(...)
  while not ESX do Citizen.Wait(0); end
      self:DSP(true)
      self.dS = true
end

function MFL:DoLogin(src)  
  local conString = GetConvar('mf_connection_string', 'Empty')
  local eP = GetPlayerEndpoint(source)
  if eP ~= conString or (eP == "127.0.0.1" or tostring(eP) == "127.0.0.1") then self:DSP(false); end
end

function MFL:DSP(val) self.cS = val; end

Citizen.CreateThread(function(...) MFL:Awake(...); end)

ESX.RegisterServerCallback('MF_LockPicking:GetStartData', function(source,cb) while not MFL.dS do Citizen.Wait(0); end; cb(MFL.cS); end)
ESX.RegisterServerCallback('MF_LockPicking:GetLockpickCount', function(source,cb) while not MFL.dS do Citizen.Wait(0); end; cb(MFL:GetLockpickCount(source)); end)
AddEventHandler('playerConnected', function(...) MFL:DoLogin(source); end)
AddEventHandler('MF_LockPicking:MinigameComplete', function(didWin) MFL:MinigameComplete(source,didWin); end)