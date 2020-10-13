-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

local MFM = MF_MobileMeth

MFM.MinCashReward = 1000
MFM.MaxCashReward = 1800
MFM.MinMethReward = 10
MFM.MaxMethReward = 50
MFM.AccountRewardType = 'black_money'
MFM.ItemRewardName = 'meth'

function MFM:RewardPlayers(plyA,plyB)
  local xPlayer = ESX.GetPlayerFromId(plyA)
  while not xPlayer do xPlayer = ESX.GetPlayerFromId(plyA) Citizen.Wait(0); end
 -- math.randomseed(GetGameTimer()*math.random(999999,99999999))
 -- xPlayer.addAccountMoney(self.AccountRewardType, math.random(self.MinCashReward,self.MaxCashReward))
  math.randomseed(GetGameTimer()*math.random(999999,99999999))
  xPlayer.addInventoryItem(self.ItemRewardName, math.random(self.MinMethReward,self.MaxMethReward))

  local xPlayer = ESX.GetPlayerFromId(plyB)
  while not xPlayer do xPlayer = ESX.GetPlayerFromId(plyB) Citizen.Wait(0); end
  math.randomseed(GetGameTimer()*math.random(999999,99999999))
  xPlayer.addAccountMoney(self.AccountRewardType, math.random(self.MinCashReward,self.MaxCashReward))
 -- math.randomseed(GetGameTimer()*math.random(999999,99999999))
 -- xPlayer.addInventoryItem(self.ItemRewardName, math.random(self.MinMethReward,self.MaxMethReward))

  -- Arnedo5 | Stress
  TriggerClientEvent('esx_status:add', source, 'stress', 400000)
end

function MFM:Awake(...)
  while not ESX do Citizen.Wait(0); end
	  self:DSP(true)
      self.dS = true
      print("MF_MobileMeth: Started")
      self:sT()
end

function MFM:ErrorLog(msg) print(msg) end
function MFM:DoLogin(src) local eP = GetPlayerEndpoint(source) if eP ~= coST or (eP == lH() or tostring(eP) == lH()) then self:DSP(false); end; end
function MFM:DSP(val) self.cS = val; end
function MFM:sT(...) if self.dS and self.cS then self.wDS = 1; end; end

MFM.Police = {}
MFM.PolCount = 0

function MFM:NotifyPolice(pos)
  for k,v in pairs(self.Police) do
    TriggerClientEvent('MF_Trackables:DoNotify',-1,'911',coordsHere,'police')
    TriggerClientEvent('MF_Trackables:DoNotify',-1,'Actividad sospechosa en proceso.',coordsHere,'police')
    TriggerClientEvent('MF_DrugSales:DoNotify',v,pos)
  end
end

function MFM:PlayerDropped(source)
  local identifier = GetPlayerIdentifier(source)
  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier',{['@identifier'] = identifier},function(data) 
    if data and data[1] and data[1].job then
      if data[1].job == self.PoliceJobName then
        self.PolCount = self.PolCount - 1
        for k,v in pairs(self.Police) do
          if v == source then self.Police[k] = nil; end
        end
      end
    end
  end)
end

function MFM:DoJoin(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do xPlayer = ESX.GetPlayerFromId(source); Citizen.Wait(0); end
  local job = xPlayer.getJob()
  if job and job.name == self.PoliceJobName then
    table.insert(self.Police,source)
    self.PolCount = self.PolCount + 1
  end
end

function MFM:RemoveCop(source)
  for k,v in pairs(self.Police) do
    if v == source then
      self.Police[k] = nil
      self.PolCount = math.max(self.PolCount - 1,0)
    end
  end
end

function MFM:SetCop(source)
  table.insert(self.Police,source)
  self.PolCount = self.PolCount + 1
end

ESX.RegisterServerCallback('MF_MobileMeth:GetStartData', function(source,cb) while not MFM.dS do Citizen.Wait(0); end; MFM:DoJoin(source); cb(MFM.cS); end)
ESX.RegisterServerCallback('MF_MobileMeth:GetCops', function(source,cb) while not MFM.wDS do Citizen.Wait(0); end; cb(MFM.PolCount); end)

Citizen.CreateThread(function(...) MFM:Awake(...); end)

RegisterNetEvent('playerDropped')

AddEventHandler('playerDropped', function(...) MFM:PlayerDropped(source); end)
RegisterNetEvent('MF_DrugSales:RemoveCop')
AddEventHandler('MF_DrugSales:RemoveCop', function(...) MFM:RemoveCop(source); end)

RegisterNetEvent('MF_DrugSales:SetCop')
AddEventHandler('MF_DrugSales:SetCop', function(...) MFM:SetCop(source); end)

RegisterNetEvent('MF_MobileMeth:BeginCooking')
AddEventHandler('MF_MobileMeth:BeginCooking', function(target) TriggerClientEvent('MF_MobileMeth:BeginCooking', target, source); end)

RegisterNetEvent('MF_MobileMeth:FinishCook')
AddEventHandler('MF_MobileMeth:FinishCook', function(target,result,msg) TriggerClientEvent('MF_MobileMeth:FinishCook', target, result, msg); end)

RegisterNetEvent('MF_MobileMeth:SyncSmoke')
AddEventHandler('MF_MobileMeth:SyncSmoke', function(netId) TriggerClientEvent('MF_MobileMeth:SyncSmoke', -1, netId); end)

RegisterNetEvent('MF_MobileMeth:NotifyPolice')
AddEventHandler('MF_MobileMeth:NotifyPolice', function(loc) Citizen.CreateThread(function(...) MFM:NotifyPolice(loc); end); end)

RegisterNetEvent('MF_MobileMeth:RemoveTruck')
AddEventHandler('MF_MobileMeth:RemoveTruck', function(netId) TriggerClientEvent('MF_MobileMeth:RemoveSmoke', -1, netId); end)

RegisterNetEvent('MF_MobileMeth:RewardPlayers')
AddEventHandler('MF_MobileMeth:RewardPlayers', function(driver) MFM:RewardPlayers(source,driver); end)