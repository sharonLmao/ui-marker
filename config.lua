Config = {}

Config.debug = false

Config.UPDATE_SPEED = 4.8
Config.DELAY_SPEED = 1500
-- labelDistance must be greater than autoCompleteOnArrival to prevent a bug where the waypoint disappear before the label is shown
Config.targetCoords = {
    ["home"] = {
        coords = vector3(2829.993896, 1474.732544, 24.555395), -- waypoint coords
        label = "Home", -- label text
        labelDistance = 10.0, -- label distance
        autoCompleteOnArrival = 5.0, -- auto remove waypoint on arrival, false to disable, distance in meters
        glowDistance = 70.0,
        show = false, -- show on load
        glow_obj = nil -- object to glow
    },
    ["carrierdoor"] = {
        coords = vector3(598.093079, -3416.244873, 6.077423),
        label = "Carrier door",
        labelDistance = 7.0,
        autoCompleteOnArrival = 1.0, -- auto remove waypoint on arrival, false to disable, distance in meters
        glowDistance = 70.0,
        show = false,
        glow_obj = `lr_prop_supermod_door_01`
    },
    ["carrierbridge"] = {
        coords = vector3(486.060, -3392.492, 7.5),
        label = "Carrier bridge",
        labelDistance = 30.0,
        autoCompleteOnArrival = 8.0, -- auto remove waypoint on arrival, false to disable, distance in meters
        glowDistance = 70.0,
        show = false,
        glow_obj = `po1_03_ramp011`
    },
    ["test2"] = {
        coords = vector3(2123.456789, 1789.012345, 32.345678),
        label = "test2",
        labelDistance = 10.0,
        autoCompleteOnArrival = 5.0, -- auto remove waypoint on arrival, false to disable, distance in meters
        glowDistance = 70.0,
        show = false,
        glow_obj = nil
    },
}