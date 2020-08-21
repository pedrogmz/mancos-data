-- 		 LosOceanic_TA =  Traffic / Pedestrian / Parked Cars Adjuster		--
--		Every 5 Minutes, count player total and update the calculation		--
--			By DK - 2019			...	Dont forget your Bananas!			--
------------------------------------------------------------------------------

Config = {}					-- My Ideal Max Numbers
Config.TrafficX 			= 3	-- 100			-- Do not let the over all calculation 
Config.PedestrianX 			= 35	-- 205			-- make this 0 or below, or else you 
Config.ParkedX 				= 24	-- 200			-- will suffer a fate far worse 
Config.Divider 				= 50	-- 			-- than having no bananas... RIP
Config.iPlayers				= 0	-- 			-- See Client.Lua for the Calculation.
Config.Static				= 1.05	-- 			-- I believe 2.25 will be ideal for 128 slots. (-288)
Config.Dispatch 			= false -- 			-- Or True???
Config.Switch 				= true	-- Magic		-- Real magic
------------------------------------------------------------------------------