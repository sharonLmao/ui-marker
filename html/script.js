let gpsLocations = {};

addEventListener("message", function (event) {
    if (event.data.action == 'moveMarkers') {
        const distance = parseFloat(event.data.distance);
        const scaleFactor = 0.17 + (300 - distance) / 300;
        const iconWidth = Math.max(scaleFactor, 0.6);
        if (!gpsLocations[event.data.id]) {
            const moveGPS = document.createElement("div");
            moveGPS.style.display = '';
            moveGPS.style.transform = 'translate3d(0vw, 0vh, 0)';
            moveGPS.classList.add("moveGPS");
            const gpsIcon = document.createElement("img");
            gpsIcon.style.width = '30px';
            gpsIcon.style.display = 'block';
            gpsIcon.src = 'location.svg';
            gpsIcon.classList.add("gpsIcon");
            moveGPS.appendChild(gpsIcon);
            const distanceLeft = document.createElement("div");
            distanceLeft.style.right = '-35px';
            distanceLeft.style.top = 'calc(100% + 5px)';
            distanceLeft.classList.add("distanceLeft");
            /*
            This ^ is the same as this:
            <div style="display: none; transform: translate3d(0vw, 0vh, 0);" id="moveGPS">
                <img style="width: 30px; display: block;" id="gpsIcon" src="location.svg" />
                <div id="distanceLeft" style="right: -35px; top: calc(100% + 5px);"></div>
            </div>
            */
            moveGPS.appendChild(distanceLeft);
            document.body.append(moveGPS);
            gpsLocations[event.data.id] = {
                moveGPS: moveGPS,
                gpsIcon: gpsIcon,
                distanceLeft: distanceLeft,
                rotate: '',
                onScreen: false,
            }
        }
        if (gpsLocations[event.data.id].onScreen !== event.data.onScreen) {
            if (event.data.onScreen == '1') { // top
                gpsLocations[event.data.id].rotate = ' rotate(180deg)';
                gpsLocations[event.data.id].distanceLeft.style.top = 'calc(-100%)'
                gpsLocations[event.data.id].distanceLeft.style.bottom = 'unset'
                gpsLocations[event.data.id].distanceLeft.style.left = '-35px'
                gpsLocations[event.data.id].distanceLeft.style.right = 'unset'
                gpsLocations[event.data.id].distanceLeft.style.transform = 'rotate(180deg)'
            }
            if (event.data.onScreen == '2') { // right
                gpsLocations[event.data.id].rotate = ' rotate(270deg)';
                gpsLocations[event.data.id].distanceLeft.style.top = 'unset'
                gpsLocations[event.data.id].distanceLeft.style.bottom = 'calc(100% + 25px)'
                gpsLocations[event.data.id].distanceLeft.style.left = '-35px'
                gpsLocations[event.data.id].distanceLeft.style.right = 'unset'
                gpsLocations[event.data.id].distanceLeft.style.transform = 'rotate(90deg)'
            }
            if (event.data.onScreen == '3') { // bottom
                gpsLocations[event.data.id].rotate = ' rotate(0deg)';
                gpsLocations[event.data.id].distanceLeft.style.top = 'calc(-100%)'
                gpsLocations[event.data.id].distanceLeft.style.bottom = 'unset'
                gpsLocations[event.data.id].distanceLeft.style.left = '-35px'
                gpsLocations[event.data.id].distanceLeft.style.right = 'unset'
                gpsLocations[event.data.id].distanceLeft.style.transform = 'rotate(0deg)'
            }
            if (event.data.onScreen == '4') { // left
                gpsLocations[event.data.id].rotate = 'rotate(90deg)';
                gpsLocations[event.data.id].distanceLeft.style.top = 'unset'
                gpsLocations[event.data.id].distanceLeft.style.bottom = 'calc(100% + 25px)'
                gpsLocations[event.data.id].distanceLeft.style.left = 'unset'
                gpsLocations[event.data.id].distanceLeft.style.right = '-35px'
                gpsLocations[event.data.id].distanceLeft.style.transform = 'rotate(270deg)'
            }
        }
        if (event.data.onScreen) {
            gpsLocations[event.data.id].onScreen = event.data.onScreen;
        } else {
            gpsLocations[event.data.id].rotate = 'rotate(0deg)';
            gpsLocations[event.data.id].distanceLeft.style.top = 'calc(100% + 5px)'
            gpsLocations[event.data.id].distanceLeft.style.bottom = 'unset'
            gpsLocations[event.data.id].distanceLeft.style.left = 'unset'
            gpsLocations[event.data.id].distanceLeft.style.right = '-35px'
            gpsLocations[event.data.id].distanceLeft.style.transform = 'rotate(0deg)'
            gpsLocations[event.data.id].onScreen = false;
        }
        if (gpsLocations[event.data.id].onScreen) {
            if (gpsLocations[event.data.id].moveGPS.style.transition == '') gpsLocations[event.data.id].moveGPS.style.transition = 'transform .16s linear';
        } else {
            if (gpsLocations[event.data.id].moveGPS.style.transition != '') gpsLocations[event.data.id].moveGPS.style.transition = '';
        }
        if (gpsLocations[event.data.id].onScreen == '2') {
            gpsLocations[event.data.id].moveGPS.style.transform = `translate3d(calc(${event.data.xxx}vw - ${30}px), ${event.data.yyy}vh, 0)` + gpsLocations[event.data.id].rotate;
        } else if (gpsLocations[event.data.id].onScreen == '3') {
            gpsLocations[event.data.id].moveGPS.style.transform = `translate3d(${event.data.xxx}vw, calc(${event.data.yyy}vh - ${30}px), 0)` + gpsLocations[event.data.id].rotate;
        } else {
            gpsLocations[event.data.id].moveGPS.style.transform = `translate3d(${event.data.xxx}vw, ${event.data.yyy}vh, 0)` + gpsLocations[event.data.id].rotate;
        }
        if (event.data.left) {
            gpsLocations[event.data.id].distanceLeft.textContent = event.data.left;
        } else {
            gpsLocations[event.data.id].distanceLeft.textContent = '';
        }
        // gpsLocations[event.data.id].gpsIcon.style.width = `${iconWidth}px`;
        // console.log("Icon Width:", `${iconWidth}px`)
    } else if (event.data.action == 'showAllMarkers') {
        for (const location in gpsLocations) {
            if (location) {
                gpsLocations[location].moveGPS.style.display = '';
            }
        }
    } else if (event.data.action == 'hideAllMarkers') {
        for (const location in gpsLocations) {
            if (location) {
                gpsLocations[location].moveGPS.style.display = 'none';
            }
        }
    } else if (event.data.action == 'cleanAllMarkers') {
        for (const location in gpsLocations) {
            if (location) {
                gpsLocations[location].moveGPS.remove();
            }
        }
        gpsLocations = {};
    } else if (event.data.action == 'removeSpecificMarker') {
        gpsLocations[event.data.id].moveGPS.remove();
        gpsLocations[event.data.id] = undefined;
    } else if (event.data.action == 'showSpecificMarker') {
        gpsLocations[event.data.id].moveGPS.style.display = '';
    } else if (event.data.action == 'hideSpecificMarker') {
        gpsLocations[event.data.id].moveGPS.style.display = 'none';
    }
});