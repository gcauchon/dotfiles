// configuration
slate.configAll({
    nudgePercentOf: "screenSize",
    resizePercentOf: "screenSize"
});

// hide every windows
slate.bind("h:cmd", slate.operation("hide", {app: "all"}));

// move
var moveWindow = function (width, height) {
    return {
        x: "(screenSizeX-" + width + ")/2",
        y: "(screenSizeY-" + height + ")/2",
        "width":    width,
        "height":   height
    };
};

slate.bindAll({
    "1:cmd,alt": slate.operation("move", moveWindow(1024, 768)),
    "2:cmd,alt": slate.operation("move", moveWindow(1280, 800)),
    "3:cmd,alt": slate.operation("move", moveWindow(1440, 1080)),
    "4:cmd,alt": slate.operation("move", moveWindow(1920, 1200))
});

// resize
slate.bindAll({
    "h:ctrl,alt": slate.operation("resize", {width: "-50", height: "+0"}),
    "j:ctrl,alt": slate.operation("resize", {width: "+0", height: "+50"}),
    "k:ctrl,alt": slate.operation("resize", {width: "+0", height: "-50"}),
    "l:ctrl,alt": slate.operation("resize", {width: "+50", height: "+0"})
});

// nudge
slate.bindAll({
    "h:cmd,alt": slate.operation("nudge", {x: "-5%", y: "+0"}),
    "j:cmd,alt": slate.operation("nudge", {x: "+0", y: "+5%"}),
    "k:cmd,alt": slate.operation("nudge", {x: "+0", y: "-5%"}),
    "l:cmd,alt": slate.operation("nudge", {x: "+5%", y: "+0"})
});

// push
slate.bindAll({
    "h:shift,ctrl,alt": slate.operation("push", {direction: "left", style: "bar-resize:screenSizeX/2"}),
    "l:shift,ctrl,alt": slate.operation("push", {direction: "right", style: "bar-resize:screenSizeX/2"})
})
