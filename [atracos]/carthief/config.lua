-------------------------------------
------- Created by T1GER#9080 -------
------- Cracked by R32#2445 ---------
------------------------------------- 

Config 						= {}
Config.Locale 				= 'es'

-- Police Settings:
Config.PoliceJobName 		= "police"		-- set the exact name for police job from jobs table in DB
Config.PoliceAlerts 		= true			
Config.PoliceBlipShow 		= true			-- enable or disable blip on map on police notify
Config.PoliceBlipTime 		= 30			-- miliseconds that blip is active on map (this value is multiplied with 4 in the script)
Config.PoliceBlipRadius 	= 50.0			-- set radius of the police notify blip
Config.PoliceBlipAlpha 		= 250			-- set alpha of the blip
Config.PoliceBlipColor 		= 5				-- set blip color

-- Job NPC (Mission Provider):
Config.JobNPC = {{
-- PED:
	Ped = 's_m_y_dealer_01',				-- set NPC model-name here
	Pos = {-218.51,-1368.69,30.31},			-- set NPC coords here
	Heading = 31.43,						-- set NPC heading
-- BLIP:
	EnableBlip = false,						-- Enable blip on the map for the NPC?
	blipName = "Car Thief",					-- set name of the blip
	blipSprite = 280,						-- set blip sprite
	blipColor = 5,							-- set blip color
	blipScale = 0.7,						-- set blip scale
}}

Config.CooldownTime 		= 30				-- set cooldown after starting a job in minutes
Config.CarThiefNPCName 		= "5M.WTF"   	-- set name for NPC (the name that pops on on your phone example)
Config.KeyToTalk 			= 38			-- set button/key to press to talk to NPC
Config.KeyToLockpick 		= 47			-- set button/key to press to lockpick vehicle
Config.KeyToDeliver 		= 38			-- set button/key to press to deliver vehicle
Config.UsePhoneMSG 			= true 			-- Enable to receive job msg through phone, disable to use ESX.ShowNotification or anything else you'd like.

-- Job Settings:
Config.PlayerCooldown 		= true			-- Enable/Disable cooldown for player upon starting a job
Config.DirtyCashForJob 		= true			-- Enable/Disable whether to use dirty cash / normal cash to pay for job fees
Config.EnableHeadshotKills 	= false 		-- Enable/Disable whether a player can headshot kill an NPC in one shot.
Config.ReceiveDirtyCash 	= true			-- Enable/Disable whether to receive dirty cash / normal cash upon finishing a job successfully 
Config.EnableThiefAlarm		= true			-- Enable/Disable car clarm upon lockpicking 
Config.CarAlarmTime			= 25			-- Set duration of car alarm upon lockpicking, in seconds.
Config.LockpickTime			= 7.5			-- Set duration of lockpiking, in seconds.

-- Risk Grades:
Config.RiskGrades = {
	[1] = { -- Risk Grade 1 --
		Grade = 1, Label = 'Bajo', Enabled = true, BuyPrice = 500, MinCops = 0, 
		Cars = {
			[1] = { Name = "Prairie", Hash = -1450650718, Reward = 2350 },
			[2] = { Name = "Ingot", Hash = -1289722222, Reward = 1950 },
			[3] = { Name = "Stratum", Hash = 1723137093, Reward = 1700 },
			-- add more cars here
		}, 
	},
	[2] = { -- Risk Grade 2 --
		Grade = 2, Label = 'Medio', Enabled = true, BuyPrice = 2000, MinCops = 1, 
		Cars = {
			[1] = { Name = "Tailgater", Hash = -1008861746, Reward = 4350 },
			[2] = { Name = "Exemplar", Hash = -5153954, Reward = 2950 },
			[3] = { Name = "F620", Hash = -591610296, Reward = 2350 },
			-- add more cars here
		}, 	
	},
	[3] = { -- Risk Grade 3 --
		Grade = 3, Label = 'Alto', Enabled = true, BuyPrice = 5000, MinCops = 1, 
		Cars = {
			[1] = { Name = "Jester", Hash = -1297672541, Reward = 8350 },
			[2] = { Name = "Carbonizzare", Hash = 2072687711, Reward = 7950 },
			[3] = { Name = "Massacro", Hash = -142942670, Reward = 7350 },
			-- add more cars here
		}, 
	},
}

-- Job Delivery Location:
Config.DeliverySpot = {
	[1] = {
		Pos = {-189.68,-1357.59,31.26},
		DrawDist = 35.0,
		MarkerType = 27,
		MarkerScale = {x = 5.0, y = 5.0, z = 1.0},
		MarkerColor = {r = 240, g = 52, b = 52, a = 100},
		BlipSprite = 1, BlipColor = 5, BlipName = "Deliver Car", BlipScale = 0.9, EnableBlipRoute = true,
	},
	[2] = {
		Pos = {-217.89,-1356.58,31.26},
		DrawDist = 35.0,
		MarkerType = 27,
		MarkerScale = {x = 5.0, y = 5.0, z = 1.0},
		MarkerColor = {r = 240, g = 52, b = 52, a = 100},
		BlipSprite = 1, BlipColor = 5, BlipName = "Deliver Car", BlipScale = 0.9, EnableBlipRoute = true,
	},
}

Config.CarJobs = {
	[1] = { 
		Spot = {331.94,-1241.59,30.59},										-- Set Vehicle Spawn Pos
		Heading = 184.36,													-- Set Vehicle Heading 
		InProgress = false,													-- Set to false
		CarSpawned = false,													-- Set to false
		GoonsSpawned = false,												-- Set to false
		JobPlayer = false,													-- Set to false
		Goons = {
			NPC1 = {
				Pos = {335.86,-1245.18,30.59}, h = 159.67,					-- NPC Spawn Pos and h is heading
				ped = 's_m_y_dealer_01',									-- NPC model name
				animDict = 'amb@world_human_cop_idles@female@base',			-- NPC Animation
				animLib = 'base',											-- NPC Animation						
				weapon2 = 'WEAPON_BAT',										-- NPC Weapon when choosing risk grade 2 job
				weapon3 = 'WEAPON_PISTOL',									-- NPC Weapon when choosing risk grade 3 job
				armour = 100,												-- NPC Body Armour value
				accuracy = 60,												-- NPC Hitting/Shooting accuracy
			},	
			NPC2 = {
				Pos = {327.07,-1244.57,30.57}, h = 244.12,
				ped = 's_m_y_dealer_01',
				animDict = 'rcmme_amanda1',
				animLib = 'stand_loop_cop',
				weapon2 = 'WEAPON_KNIFE',
				weapon3 = 'WEAPON_PISTOL',
				armour = 75,
				accuracy = 80,
			},	
		},
		BlipSprite = 1, BlipColor = 5, BlipName = "Car Theft Job", BlipScale = 0.9, EnableBlipRoute = true,
		-- blip settings for the job pos
	},
	[2] = { 
		Spot = {492.77,-524.46,24.75},
		Heading = 170.15,
		InProgress = false,
		CarSpawned = false,
		GoonsSpawned = false,
		JobPlayer = false,
		Goons = {
			NPC1 = {
				Pos = {487.49,-529.21,24.75}, h = 219.07,
				ped = 's_m_y_dealer_01',
				animDict = 'amb@world_human_cop_idles@female@base',
				animLib = 'base',						
				weapon2 = 'WEAPON_BAT',
				weapon3 = 'WEAPON_PISTOL',
				armour = 50,
				accuracy = 95,
			},	
			NPC2 = {
				Pos = {496.24,-528.87,24.75}, h = 145.44,
				ped = 's_m_y_dealer_01',
				animDict = 'rcmme_amanda1',
				animLib = 'stand_loop_cop',
				weapon2 = 'WEAPON_KNIFE',
				weapon3 = 'WEAPON_PISTOL',
				armour = 70,
				accuracy = 75,
			},	
		},
		BlipSprite = 1, BlipColor = 5, BlipName = "Car Theft Job", BlipScale = 0.9, EnableBlipRoute = true,
	},
	-- Add more locations/jobs here
}



