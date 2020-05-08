MF_PacificStandard = {}
local MFP = MF_PacificStandard
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

MFP.CooldownTimer = 30
MFP.BankLocation = vector3(246.78,218.70,106.30)
MFP.LoadDist = 50.0
MFP.InteractDist = 2.0
MFP.AudioBankName = "MF_Pacific"
MFP.InteractTimer = 10 -- seconds
MFP.MinPoliceCount = 0
MFP.PoliceLabel = "Police"

MFP.Actions = {
  ["LockpickA"]  = vector3(256.79,220.01,106.50),
  ["Hack"]       = vector3(261.97,223.16,106.50),
  ["Identify"]   = vector3(253.21,228.43,101.80),
  ["LockpickB"]  = vector3(252.47,221.02,101.80),
  ["LockpickC"]  = vector3(261.12,215.22,101.80),
  ["Safe"]       = vector3(263.84,207.93,110.29),

  ["LootA"]      = vector3(259.63,218.06,102.10),
  ["LootB"]      = vector3(258.32,214.19,102.10),

  ["LootC"]      = vector3(262.32,212.65,102.10),
  ["LootD"]      = vector3(264.17,211.98,102.10),

  ["LootE"]      = vector3(265.75,212.79,102.10),
  ["LootF"]      = vector3(266.36,214.27,102.10),

  ["LootG"]      = vector3(265.77,215.83,102.10),
  ["LootH"]      = vector3(263.92,216.48,102.10),

  ["LootCash"]   = vector3(264.24,213.72,102.50),

}

MFP.ActionText = {
  ["LockpickA"] = "[ ~r~E~s~ ] para forzar la puerta.",
  ["LockpickB"] = "[ ~r~E~s~ ] para forzar la puerta.",
  ["LockpickC"] = "[ ~r~E~s~ ] para forzar la puerta.",
  ["Hack"] = "[ ~r~E~s~ ] para hackear el panel de seguridad",
  ["Identify"] = "[ ~r~E~s~ ] para intentar acceder.",
  ["Safe"] = "[ ~r~E~s~ ] para intentar romper la caja fuerte.",
  ["LootA"] = "[ ~r~E~s~ ] para abrir la cerradura.",
  ["LootB"] = "[ ~r~E~s~ ] para abrir la cerradura.",
  ["LootC"] = "[ ~r~E~s~ ] para abrir la cerradura.",
  ["LootD"] = "[ ~r~E~s~ ] para abrir la cerradura.",
  ["LootE"] = "[ ~r~E~s~ ] para abrir la cerradura.",
  ["LootF"] = "[ ~r~E~s~ ] para abrir la cerradura.",
  ["LootG"] = "[ ~r~E~s~ ] para abrir la cerradura.",
  ["LootH"] = "[ ~r~E~s~ ] para abrir la cerradura.",
  ["LootCash"] = "[ ~r~E~s~ ] para llevarte el efectivo.",
}

MFP.SafeRewards = { 
  CashAmount    = math.random(500,1000),
  ItemsAmount   = 0, -- math.random(0,itemsamount) = reward
  Items = { 'pacificidcard' }, -- ^ for all
}

MFP.LootTable = {
  ["LootA"] = {
    ["rolex"] = 3,
    ["gold"] = 3,
    ["diamond"] = 3,
    ["money"] = 5000,
  },

  ["LootB"] = {
    ["rolex"] = 3,
    ["gold"] = 3,
    ["diamond"] = 3,
    ["money"] = 5000,
  },

  ["LootC"] = {
    ["rolex"] = 3,
    ["gold"] = 3,
    ["diamond"] = 3,
    ["money"] = 5000,
  },

  ["LootD"] = {
    ["rolex"] = 3,
    ["gold"] = 3,
    ["diamond"] = 3,
    ["money"] = 5000,
  },

  ["LootE"] = {
    ["rolex"] = 3,
    ["gold"] = 3,
    ["diamond"] = 3,
    ["money"] = 5000,
  },

  ["LootF"] = {
    ["rolex"] = 3,
    ["gold"] = 3,
    ["diamond"] = 3,
    ["money"] = 5000,
  },
  
  ["LootG"] = {
    ["rolex"] = 3,
    ["gold"] = 3,
    ["diamond"] = 3,
    ["money"] = 5000,
  },

  ["LootH"] = {
    ["rolex"] = 3,
    ["gold"] = 3,
    ["diamond"] = 3,
    ["money"] = 5000,
  },

  ["LootCash"] = {
    ["money"] = 100000,
  }
}