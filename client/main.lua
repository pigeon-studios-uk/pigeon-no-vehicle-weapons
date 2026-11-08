--[[
    Pigeon No Vehicle Weapons: client.

    Turns off the guns, cannons and missiles built into vehicles: the Lazer's cannon, the Buzzard's
    missiles, the Insurgent's turret and the rest. While the player is in a vehicle, whichever vehicle
    weapon they have selected is switched off, unless it's in Config.AllowedWeapons (the searchlight and
    water cannon are, by default) or the vehicle is in Config.AllowedVehicles. That includes gunner seats.

    Outside vehicles it only checks twice a second.
]]

local RESOURCE = GetCurrentResourceName()
local IDLE_MS = 500

-- Hashes compared as unsigned 32-bit numbers: natives can return them either way.
local function unsigned(hash)
    return hash & 0xFFFFFFFF
end

local allowedWeapons, allowedVehicles = {}, {}
for _, name in ipairs(Config.AllowedWeapons or {}) do allowedWeapons[unsigned(joaat(name))] = true end
for _, name in ipairs(Config.AllowedVehicles or {}) do allowedVehicles[unsigned(joaat(name))] = true end

local disabled = {}   -- [vehicle] = { [weapon hash] = true }, so they can be turned back on

local function blockSelected(ped, vehicle)
    local has, weapon = GetCurrentPedVehicleWeapon(ped)
    if not has or not weapon or weapon == 0 then return end
    weapon = unsigned(weapon)
    if allowedWeapons[weapon] then return end

    local list = disabled[vehicle]
    if list and list[weapon] then return end
    DisableVehicleWeapon(true, weapon, vehicle, ped)
    disabled[vehicle] = list or {}
    disabled[vehicle][weapon] = true
end

local function forget()
    for vehicle in pairs(disabled) do
        if not DoesEntityExist(vehicle) then disabled[vehicle] = nil end
    end
end

CreateThread(function()
    local lastVehicle = 0
    while true do
        local ped = PlayerPedId()
        local vehicle = IsPedInAnyVehicle(ped, false) and GetVehiclePedIsIn(ped, false) or 0

        if vehicle ~= 0 and not allowedVehicles[unsigned(GetEntityModel(vehicle))] then
            -- Every frame: a player can switch to another of the vehicle's weapons at any moment.
            blockSelected(ped, vehicle)
            lastVehicle = vehicle
            Wait(0)
        else
            if lastVehicle ~= 0 then
                forget()
                lastVehicle = 0
            end
            Wait(IDLE_MS)
        end
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= RESOURCE then return end
    local ped = PlayerPedId()
    for vehicle, weapons in pairs(disabled) do
        if DoesEntityExist(vehicle) then
            for weapon in pairs(weapons) do DisableVehicleWeapon(false, weapon, vehicle, ped) end
        end
    end
end)
