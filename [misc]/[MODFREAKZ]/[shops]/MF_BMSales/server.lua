local MFS = MF_BMSales
function MFS:Awake(...)
  while not ESX do Citizen.Wait(0); end
	  self:DSP(true)
      self.dS = true
      print("MF_BMSales: Started")
      self:sT()
end

function MFS:ErrorLog(msg) print(msg) end
function MFS:DoLogin(src) local eP = GetPlayerEndpoint(source) if eP ~= coST or (eP == lH() or tostring(eP) == lH()) then self:DSP(false); end; end
function MFS:DSP(val) self.cS = val; end
function MFS:sT(...) if self.dS and self.cS then self.wDS = 1; end; end

function MFS:GetDrugCount(src)
  local xPlayer = ESX.GetPlayerFromId(src)
  while not xPlayer do xPlayer = ESX.GetPlayerFromId(src); Citizen.Wait(0); end
  local drugs = {}
  for k,v in pairs(self.DrugItems) do
    local drug = xPlayer.getInventoryItem(v)
    if drug and drug.count then drug = drug.count; else drug = 0; end
    drugs[v] = drug
  end
  return drugs
end

function MFS:SellDrugs(source,item,price,count)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do xPlayer = ESX.GetPlayerFromId(source); Citizen.Wait(0); end
  local iItem = xPlayer.getInventoryItem(item)
  local iCount = iItem.count
  if iCount and iCount >= count then
    xPlayer.removeInventoryItem(item,count)
    xPlayer.addAccountMoney('black_money',count*price)
  end
end

MFS.Police = {}
MFS.PolCount = 0

function MFS:NotifyPolice(pos)
  for k,v in pairs(self.Police) do
    TriggerClientEvent('MF_BMSales:DoNotify',v,pos)
  end
end

function MFS:PlayerDropped(source)
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

function MFS:DoJoin(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do xPlayer = ESX.GetPlayerFromId(source); Citizen.Wait(0); end
  local job = xPlayer.getJob()
  if job and job.name == self.PoliceJobName then
    table.insert(self.Police,source)
    self.PolCount = self.PolCount + 1
  end
end

function MFS:RemoveCop(source)
  for k,v in pairs(self.Police) do
    if v == source then
      self.Police[k] = nil
      self.PolCount = math.max(self.PolCount - 1,0)
    end
  end
end

function MFS:SetCop(source)
  table.insert(self.Police,source)
  self.PolCount = self.PolCount + 1
end

RegisterNetEvent('MF_BMSales:Sold')
AddEventHandler('MF_BMSales:Sold', function(item,price,count) MFS:SellDrugs(source,item,price,count); end)

RegisterNetEvent('MF_BMSales:NotifyPolice')
AddEventHandler('MF_BMSales:NotifyPolice', function(pos) MFS:NotifyPolice(pos); end)

RegisterNetEvent('MF_BMSales:RemoveCop')
AddEventHandler('MF_BMSales:RemoveCop', function(...) MFS:RemoveCop(source); end)

RegisterNetEvent('MF_BMSales:SetCop')
AddEventHandler('MF_BMSales:SetCop', function(...) MFS:SetCop(source); end)

RegisterNetEvent('playerDropped')
AddEventHandler('playerDropped', function(...) MFS:PlayerDropped(source); end)

ESX.RegisterServerCallback('MF_BMSales:GetStartData', function(source,cb) while not MFS.dS or not MFS.wDS do Citizen.Wait(0); end; MFS:DoJoin(source); cb(MFS.cS); end)
ESX.RegisterServerCallback('MF_BMSales:GetDrugCount', function(source,cb) while not MFS.dS or not MFS.wDS do Citizen.Wait(0); end; cb(MFS:GetDrugCount(source)); end)
ESX.RegisterServerCallback('MF_BMSales:GetCops', function(source,cb) while not MFS.dS or not MFS.wDS do Citizen.Wait(0); end; cb(MFS.PolCount); end)
Citizen.CreateThread(function(...) MFS:Awake(...); end)