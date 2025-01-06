Sure! Here's a revised version of your description for a GitHub README:

---

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
    ["home"] = vector3(2829.993896, 1474.732544, 24.555395),
    ["test1"] = vector3(2567.234375, 1234.567890, 28.123456),
    ["test2"] = vector3(2123.456789, 1789.012345, 32.345678),
    ["test3"] = vector3(2901.234567, 1345.678901, 26.789012)
}
```


**Created by**: Sharon and Burgil

[Preview]([https://streamable.com/6jl81z](https://streamable.com/l5xbok))
https://github.com/user-attachments/assets/9324b2e1-b7ee-4520-8880-670d8a2c82dc

