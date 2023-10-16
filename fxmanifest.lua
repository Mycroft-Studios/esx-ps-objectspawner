fx_version 'cerulean'
game 'gta5'

author 'Project Sloth team'
description 'Object Spawner'
version '0.0.1'

lua54 'yes'

shared_script "@es_extended/imports.lua"

client_scripts { "client/*.lua" }
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    "server/*.lua",
}

ui_page "html/index.html"

files({
	"html/*",
})