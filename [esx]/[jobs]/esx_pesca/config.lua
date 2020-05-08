Config = {}
	---------------------------------------------------------------
	--=====How long should it take for player to catch a fish=======--
	---------------------------------------------------------------
	--Time in miliseconds
	Config.FishTime = {a = 120000, b = 194000}
	
	--------------------------------------------------------
	--=====Prices of the items players can sell==========--
	--------------------------------------------------------
	--First amount minimum price second maximum amount (the amount player will get is random between those two numbers)
	Config.FishPrice = {a =  15, b = 15} --Will get clean money THIS PRICE IS FOR EVERY 5 FISH ITEMS (5 kg)
	Config.TurtlePrice = {a = 4, b = 4} --Will get dirty money
	Config.SharkPrice = {a = 4000, b = 6000} --Will get dirty money

	--------------------------------------------------------
	--=====Locations where players can sell stuff========--
	--------------------------------------------------------

	Config.SellFish = {x = -3251.2, y = 991.5, z = 11.49} --Place where players can sell their fish
	Config.SellTurtle = {x = 3804.0, y = 4443.3, z = 3.13} --Place where players can sell their turtles 
	Config.SellShark = {x = -2175.36 , y = 4294.82, z = 48.07} --Place where players can sell their sharks

	--------------------------------------------------------
	--=====Locations where players can rent boats========--
	--------------------------------------------------------
Config.MarkerZones = { 
	
    {x = -3426.7   ,y = 955.66 ,z = 8.35, xs = -3426.2  , ys = 942.4, zs = 1.1 },
	{x = -732.9     ,y = -1309.7 ,z = 5.0, xs = -725.7    , ys = -1351.5, zs = 0.5 },  
	{x = -1607.6      ,y =  5252.8 ,z = 4.0, xs = -1590.2      , ys = 5278.8, zs = 1.0 },
	{x = 3855.0        ,y =  4463.7 ,z = 2.6, xs = 3885.2       , ys =  4507.2, zs = 1.0 },
	{x = -281.47        ,y =  6625.63 ,z = 7.28, xs = -341.1       , ys =  6643.72, zs = 1.0 },
	{x = -96.25        ,y =  -2767.9 ,z = 6.08, xs = -138.36       , ys =  -2805.21, zs = 1.0 },
	{x = 1330.8        ,y =  4226.6 ,z = 33.9, xs = 1334.2         , ys =  4192.4, zs = 30.0 },
	

}