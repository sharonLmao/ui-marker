const moveGPS = document.getElementById("moveGPS");
const gpsIcon = document.getElementById("gpsIcon");
let isVisible = false;
let onScreen = false;
let rotate = '';

addEventListener("message", function (event) {
    if (event.data.toggle == true) {
        const distance = parseFloat(event.data.distance);
        const scaleFactor = 0.17 + (300 - distance) / 300;
        const iconWidth = Math.max(scaleFactor, 0.6);
        console.log(event.data.onScreen);
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
            moveGPS.style.transform = `translate3d(calc(${event.data.xxx}vw - ${iconWidth}px), ${event.data.yyy}vh, 0)` + rotate;
        } else if (onScreen == '3') {
            moveGPS.style.transform = `translate3d(${event.data.xxx}vw, calc(${event.data.yyy}vh - ${iconWidth}px), 0)` + rotate;
        } else {
            moveGPS.style.transform = `translate3d(${event.data.xxx}vw, ${event.data.yyy}vh, 0)` + rotate;
        }
        gpsIcon.style.width = `${iconWidth}px`;
        if (!isVisible) {
            $("#moveGPS").show();
            isVisible = true;
        }
    } else if (isVisible) {
        isVisible = false;
        $("#moveGPS").hide();
    }
});