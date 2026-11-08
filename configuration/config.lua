Config = {}

-- Vehicle "weapons" that stay on. GTA counts some things that aren't guns as vehicle weapons, and
-- police and fire players need them:
--   VEHICLE_WEAPON_SEARCHLIGHT    the police helicopter's searchlight
--   VEHICLE_WEAPON_WATER_CANNON   the fire truck's water cannon
--   VEHICLE_WEAPON_RADAR          the radar some aircraft have
--   VEHICLE_WEAPON_ROTORS         helicopter rotor damage
-- Add any gun you want to keep, such as 'VEHICLE_WEAPON_TURRET_INSURGENT'.
Config.AllowedWeapons = {
    'VEHICLE_WEAPON_SEARCHLIGHT',
    'VEHICLE_WEAPON_WATER_CANNON',
    'VEHICLE_WEAPON_RADAR',
    'VEHICLE_WEAPON_ROTORS',
}

-- Vehicles that keep every one of their weapons, by spawn name (the name you'd use to spawn it). Add-on
-- vehicles work the same way. Use {} for none.
Config.AllowedVehicles = {
    -- 'rhino',
}

-- Update checks are controlled in server.cfg for every Pigeon Studios resource at once:
--     set pigeon_update_check "on"      (default)  |  "quiet"  |  "off"
