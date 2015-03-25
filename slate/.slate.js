// configuration
slate.configAll({
    defaultToCurrentScreen: true,
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
    "1:ctrl,alt": slate.operation("move", moveWindow(1024, 700)),
    "2:ctrl,alt": slate.operation("move", moveWindow(1024, 768)),
    "3:ctrl,alt": slate.operation("move", moveWindow(1280, 800)),
    "4:ctrl,alt": slate.operation("move", moveWindow(1280, 900))
});

// resize
slate.bindAll({
    "right:ctrl,alt":   slate.operation("resize", {width: "+50", height: "+0"}),
    "left:ctrl,alt":    slate.operation("resize", {width: "-50", height: "+0"}),
    "up:ctrl,alt":      slate.operation("resize", {width: "+0", height: "-50"}),
    "down:ctrl,alt":    slate.operation("resize", {width: "+0", height: "+50"})
});

// nudge
slate.bindAll({
    "right:cmd,alt":    slate.operation("nudge", {x: "+50", y: "+0"}),
    "left:cmd,alt":     slate.operation("nudge", {x: "-50", y: "+0"}),
    "up:cmd,alt":       slate.operation("nudge", {x: "+0", y: "-50"}),
    "down:cmd,alt":     slate.operation("nudge", {x: "+0", y: "+50"})
});

// push
slate.bindAll({
    "l:cmd,alt":  slate.operation("push", {direction: "right", style: "bar-resize:screenSizeX/2"}),
    "j:cmd,alt":  slate.operation("push", {direction: "top", style: "bar-resize:screenSizeY/2"}),
    "k:cmd,alt":  slate.operation("push", {direction: "bottom", style: "bar-resize:screenSizeY/2"}),    
    "h:cmd,alt":  slate.operation("push", {direction: "left", style: "bar-resize:screenSizeX/2"})    
})
