fx_version 'cerulean'
game 'gta5'

author 'phiomet'
description 'Blutspende-Skript'
version '1.0.0'

shared_scripts {
    'config.lua',
}

server_scripts {
    'server/main.lua',
}

client_scripts {
    'client/main.lua',
}

dependencies {
    'qb-core',
    'qb-inventory'
}
