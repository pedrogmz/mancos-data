-- Written by @vjuton#2137 --
-- Set ped to user script --

-- Version: 1.0.2

-- Requirements:

-- Mythic_Notify
-- https://github.com/mythicrp/mythic_notify

--[[

PEDS

s_m_y_cop_01
s_m_y_swat_01
a_m_y_musclbeac_01
s_m_m_movspace_01
s_m_m_movalien_01

--]]


RegisterNetEvent('cop')
AddEventHandler('cop', function()
local ped = 's_m_y_cop_01'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)

RegisterNetEvent('alien')
AddEventHandler('alien', function()
local ped = 's_m_m_movalien_01'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)

RegisterNetEvent('space')
AddEventHandler('space', function()
local ped = 's_m_m_movspace_01'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)

RegisterNetEvent('muscle')
AddEventHandler('muscle', function()
local ped = 'a_m_y_musclbeac_01'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)

RegisterNetEvent('fat')
AddEventHandler('fat', function()
local ped = 'a_m_m_afriamer_01'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)

RegisterNetEvent('swat')
AddEventHandler('swat', function()
local ped = 's_m_y_swat_01'
local hash = GetHashKey(ped)
	RequestModel(hash)
	while not HasModelLoaded(hash)
			do RequestModel(hash)
				Citizen.Wait(0)
			end	
			SetPlayerModel(PlayerId(), hash)
		end)

TriggerEvent('chat:addSuggestion', '/setped', 'Set ped to guy', {
    { name="id", help="Id of the player" },
    { name="Model", help="Peds: fat, cop, swat, muscle, alien, space" }
})

