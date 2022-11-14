local dbReady = false
local supportedVersion = 5.12
local cachedBans = {} -- DO NOT TOUCH THIS EVER DONT EDIT THIS

AddEventHandler('onMySQLReady', function ()
	Wait(200)

	TriggerEvent("EasyAdmin:GetVersion", function(version)
		if tonumber(version) >= supportedVersion then
			dbReady = true
		else
			print("EasyAdmin-MySQL: Update EasyAdmin, it's outdated and incompatible.")
		end
	end)

end)


AddEventHandler('ea_data:retrieveBanlist', function(callback)
	local callback = callback
	while not dbReady do
		Wait(1000)
	end
	MySQL.Async.fetchAll('SELECT * FROM ea_bans', {}, function(bans)
		for i, ban in ipairs(bans) do
			ban.identifiers = json.decode(ban.identifiers)
		end
		callback(bans)
		cachedBans = bans
		print("retrieved banlist")
	end)
end)

AddEventHandler('ea_data:addBan', function(data)
	while not dbReady do
		Wait(1000)
	end
	MySQL.Async.execute("INSERT INTO ea_bans (`banid`, `expire`, `identifiers`, `reason`, `banner`) VALUES (NULL, @expire, @identifiers, @reason, @banner);", {banid = data.banid, expire = data.expire, identifiers = json.encode(data.identifiers), reason = data.reason, banner = data.banner or "Console" }, function() end)
	print("added new ban")
end)

AddEventHandler('ea_data:updateBan', function(data)
	while not dbReady do
		Wait(1000)
	end
	MySQL.Async.execute("UPDATE `ea_bans` SET `expire`=@expire, `identifiers`=@identifiers, `reason`=@reason, banner=@banner WHERE banid=@banid;", {banid = data.banid, expire = data.expire, identifiers = json.encode(data.identifiers), reason = data.reason, banner = data.banner or "Console" }, function() end)
	print("added new ban")
end)

AddEventHandler('ea_data:removeBan', function(data)
	while not dbReady do
		Wait(1000)
	end
	print(data.banid)
	for i,theBan in ipairs(cachedBans) do
		if data.banid == theBan.banid then
			MySQL.Async.execute("DELETE FROM ea_bans WHERE banid = @banid;", {banid = theBan.banid }, function() end)
			print("deleted ban")
			break
		end
	end
end)
