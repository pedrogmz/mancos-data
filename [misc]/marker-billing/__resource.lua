resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "html/index.html"

files {
    'html/index.html',
    'html/js/index.js',
    'html/css/index.css',
    'html/css/reset.css'
}

client_script {
    '@es_extended/locale.lua',
    "locales/es.lua",
    'config.lua',
    "client.lua"
}

server_script {
    '@es_extended/locale.lua',
    "locales/es.lua",
    'config.lua',
    "server.lua",
    "@mysql-async/lib/MySQL.lua"
}

