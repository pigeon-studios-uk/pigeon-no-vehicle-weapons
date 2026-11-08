fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'pigeon-no-vehicle-weapons'
author 'Pigeon Studios'
description 'Turns off the guns, cannons and missiles built into vehicles, while keeping searchlights and water cannons.'
version '0.1.0'
repository 'https://github.com/pigeon-studios-uk/pigeon-no-vehicle-weapons'

-- Pigeon Studios version registry entry, read by server/version_check.lua.
pigeon_slug 'pigeon-no-vehicle-weapons'

client_scripts {
    'configuration/config.lua',
    'client/main.lua',
}

server_scripts {
    'server/version_check.lua',
}
