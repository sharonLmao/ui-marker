Config = {}

Config.debug = false

Config.UPDATE_SPEED = 0.6
Config.DELAY_SPEED = 1500
Config.GLOW_DISTANCE = 500.0

Config.targetCoords = {
    ["home"] = {
        coords = vector3(2829.993896, 1474.732544, 24.555395),
        label = "Home",
        distance = 10.0,
        show = false,
        glow_obj = nil
    },
    ["carrierdoor"] = {
        coords = vector3(598.093079, -3416.244873, 6.077423),
        label = "Carrier door",
        distance = 5.0,
        show = false,
        glow_obj = `lr_prop_supermod_door_01`
    },
    ["carrierbridge"] = {
        coords = vector3(485.687592, -3391.977051, 6.620294),
        label = "Carrier bridge",
        distance = 5.0,
        show = false,
        glow_obj = `po1_03_ramp_011`
    },
    ["test2"] = {
        coords = vector3(2123.456789, 1789.012345, 32.345678),
        label = "test2",
        distance = 10.0,
        show = false,
        glow_obj = nil
    },
}