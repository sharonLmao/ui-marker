const moveGPS = document.getElementById("moveGPS");
const gpsIcon = document.getElementById("gpsIcon");
const distanceLeft = document.getElementById("distanceLeft");
let isVisible = false;
let onScreen = false;
let rotate = '';

addEventListener("message", function (event) {
    if (event.data.toggle == true) {
        const distance = parseFloat(event.data.distance);
        const scaleFactor = 0.17 + (300 - distance) / 300;
        const iconWidth = Math.max(scaleFactor, 0.6);
        if (onScreen !== event.data.onScreen) {
            if (event.data.onScreen == '1') rotate = ' rotate(180deg)';
            if (event.data.onScreen == '2') rotate = ' rotate(270deg)';
            if (event.data.onScreen == '3') rotate = ' rotate(0deg)';
            if (event.data.onScreen == '4') rotate = ' rotate(90deg)';
        }
        if (event.data.onScreen) {
            onScreen = event.data.onScreen;
        } else {
            rotate = 'rotate(0deg)';
            onScreen = false;
        }
        if (onScreen) {
            if (moveGPS.style.transition == '') moveGPS.style.transition = 'transform .16s linear';
        } else {
            if (moveGPS.style.transition != '') moveGPS.style.transition = '';
        }
        if (onScreen == '2') {
            moveGPS.style.transform = `translate3d(calc(${event.data.xxx}vw - ${30}px), ${event.data.yyy}vh, 0)` + rotate;
        } else if (onScreen == '3') {
            moveGPS.style.transform = `translate3d(${event.data.xxx}vw, calc(${event.data.yyy}vh - ${30}px), 0)` + rotate;
        } else {
            moveGPS.style.transform = `translate3d(${event.data.xxx}vw, ${event.data.yyy}vh, 0)` + rotate;
        }
        if (event.data.left) {
            distanceLeft.textContent = event.data.left;
        } else {
            distanceLeft.textContent = '';
        }
        // gpsIcon.style.width = `${iconWidth}px`;
        console.log("Icon Width:", `${iconWidth}px`)
        if (!isVisible) {
            $("#moveGPS").show();
            isVisible = true;
        }
    } else if (isVisible) {
        isVisible = false;
        $("#moveGPS").hide();
    }
});