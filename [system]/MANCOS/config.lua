Config = {}

----------------------------------------------------
-------- Intervalles en secondes -------------------
----------------------------------------------------

-- Temps d'attente Antispam / Waiting time for antispam
Config.AntiSpamTimer = 2

-- Vérification et attribution d'une place libre / Verification and allocation of a free place
Config.TimerCheckPlaces = 3

-- Mise à jour du message (emojis) et accès à la place libérée pour l'heureux élu / Update of the message (emojis) and access to the free place for the lucky one
Config.TimerRefreshClient = 3

-- Mise à jour du nombre de points / Number of points updating
Config.TimerUpdatePoints = 6

----------------------------------------------------
------------ Nombres de points ---------------------
----------------------------------------------------

-- Nombre de points gagnés pour ceux qui attendent / Number of points earned for those who are waiting
Config.AddPoints = 1

-- Nombre de points perdus pour ceux qui sont entrés dans le serveur / Number of points lost for those who entered the server
Config.RemovePoints = 1

-- Nombre de points gagnés pour ceux qui ont 3 emojis identiques (loterie) / Number of points earned for those who have 3 identical emojis (lottery)
Config.LoterieBonusPoints = 25

-- Accès prioritaires / Priority access
Config.Points = {
--staff
	-- {'steam:11000010555edd1', 1000}, --pedro
	-- {'steam:1100001098568fe', 1000}, --sergio
	-- {'steam:1100001003f07e3', 1000}, --raspu
	-- {'steam:11000010780ae68', 1000}, --pacucho
	-- {'steam:11000013cd4d084', 1000}, --conexion
	-- {'steam:11000010f6672cb', 1000}, --elektrica
	-- {'steam:110000108344fed', 1000}, --rio
	--policia
	-- {'steam:1100001026f2bd6', 500}, --Jack Daniels
	-- {'steam:110000115c84fa4', 500}, --NotAl3x
	-- {'steam:110000134a36c25', 500}, --Quimllonun_TeMisilo
	-- {'steam:1100001036ce405', 500}, --Flisin
	-- {'steam:110000132235d97', 500}, --docaoneer
	--ems
	-- {'steam:1100001040dcfab', 500}, --Davidoff
	-- {'steam:11000013be17870', 500}, --bonsii
}

----------------------------------------------------
------------- Textes des messages ------------------
----------------------------------------------------

-- Si steam n'est pas détecté / If steam is not detected
Config.NoSteam = "No se detecto Steam. Por favor reinicia Steam y FiveM y pruébalo nuevamente."
-- Config.NoSteam = "Steam was not detected. Please (re)launch Steam and FiveM, and try again."

-- Message d'attente / Waiting text
Config.EnRoute = "Estas de camino. Has llegado a tu destino"
-- Config.EnRoute = "You are on the road. You have already traveled"

-- "points" traduits en langage RP / "points" for RP purpose
Config.PointsRP = "kilometros"
-- Config.PointsRP = "kilometers"

-- Position dans la file / position in the queue
Config.Position = "Estas en cola "
-- Config.Position = "You are in position "

-- Texte avant les emojis / Text before emojis
Config.EmojiMsg = "Si los emoticos se paran, reinicia el cliente : "
-- Config.EmojiMsg = "If the emojis are frozen, restart your client: "

-- Quand le type gagne à la loterie / When the player win the lottery
Config.EmojiBoost = "!!! Youpi, " .. Config.LoterieBonusPoints .. " " .. Config.PointsRP .. " gané !!!"
-- Config.EmojiBoost = "!!! Yippee, " .. Config.LoterieBonusPoints .. " " .. Config.PointsRP .. " won !!!"

-- Anti-spam message / anti-spam text
Config.PleaseWait_1 = "Espera por favor "
Config.PleaseWait_2 = " Segundos. La conexión comenzará automaticamente !"
-- Config.PleaseWait_1 = "Please wait "
-- Config.PleaseWait_2 = " seconds. The connection will start automatically!"

-- Me devrait jamais s'afficher / Should never be displayed
Config.Accident = "Oups, has sufrido un accidente... Si vuelve a ocurrir contacte con el soporte :)"
-- Config.Accident = "Oops, you just had an accident ... If it happens again, you can inform the support :)"

-- En cas de points négatifs / In case of negative points
Config.Error = " ERROR : Reinicia el sistema y contacté con soporte "
-- Config.Error = " ERROR : RESTART THE QUEUE SYSTEM AND CONTACT THE SUPPORT "


Config.EmojiList = {
	'🐌', 
	'🐍',
	'🐎', 
	'🐑', 
	'🐒',
	'🐘', 
	'🐙', 
	'🐛',
	'🐜',
	'🐝',
	'🐞',
	'🐟',
	'🐠',
	'🐡',
	'🐢',
	'🐤',
	'🐦',
	'🐧',
	'🐩',
	'🐫',
	'🐬',
	'🐲',
	'🐳',
	'🐴',
	'🐅',
	'🐈',
	'🐉',
	'🐋',
	'🐀',
	'🐇',
	'🐏',
	'🐐',
	'🐓',
	'🐕',
	'🐖',
	'🐪',
	'🐆',
	'🐄',
	'🐃',
	'🐂',
	'🐁',
	'🔥'
}
