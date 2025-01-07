# ui-marker: Interest point Indicator

This script serves as an optimized replacement for the traditional 3D marker. It dynamically follows the screen edges, positioning itself at the nearest edge to guide the player toward the waypoint. The design ensures players always know where to go without the clutter of 3D markers. 

# Example use
```
 exports["ui-marker"]:ShowMarker(source, "home") - to Show specific marker
 exports["ui-marker"]:HideMarker(source, "home") - to Hide specific marker
 exports["ui-marker"]:ShowMarkers() - to Show all marker
 exports["ui-marker"]:HideMarkers() - to Hide all marker
```

# Config
```
add waypoints here and use with the exports above
Config.targetCoords = {
    ["home"] = {
        coords = vector3(2829.993896, 1474.732544, 24.555395),
        label = "Home",
        distance = 10.0,
        show = false
    },
    ["carrierdoor"] = {
        coords = vector3(598.093079, -3416.244873, 6.077423),
        label = "Carrier door",
        distance = 5.0,
        show = false
    },
    ["test2"] = {
        coords = vector3(2123.456789, 1789.012345, 32.345678),
        label = "test2",
        distance = 10.0,
        show = false
    },
    ["test3"] = {
        coords = vector3(2901.234567, 1345.678901, 26.789012),
        label = "test3",
        distance = 10.0,
        show = false
    },
}
```


**Created by**: Sharon and Burgil

# Preview

https://github.com/user-attachments/assets/b3840513-6149-4550-b8b8-aa8675fb13f8


