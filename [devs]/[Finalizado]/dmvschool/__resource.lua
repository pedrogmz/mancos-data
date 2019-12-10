resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'html/ui.html'

description 'Permiso de circulación'

files {
	'html/ui.html',
	'html/logo.png',
	'html/dmv.png',
	'html/cursor.png',
	'html/logotipo.png',
	'html/styles.css',
	'html/questions.js',
	'html/scripts.js',
	'html/debounce.min.js'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua',
}

client_script {
	'client.lua',
	'GUI.lua'
}