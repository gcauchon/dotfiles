// configuration
slate.configAll({
    defaultToCurrentScreen: true,
    nudgePercentOf: "screenSize",
    resizePercentOf: "screenSize"
});

slate.bind("h:cmd", slate.operation("hide", {app: "all"}));

// move
var move = slate.operation("move", {
    x: "(screenSizeX-1024)/2",
    y: "(screenSizeY-768)/2",
    width:  1024,
    height: 768
});

slate.bindAll({
    "1:ctrl;alt": move
})

// resize
slate.bindAll({
    "right:ctrl;alt":   slate.operation("resize", {width: "+50", height: "+0"}),
    "left:ctrl;alt":    slate.operation("resize", {width: "-50", height: "+0"}),
    "up:ctrl;alt":      slate.operation("resize", {width: "+0", height: "-50"}),
    "down:ctrl;alt":    slate.operation("resize", {width: "+0", height: "+50"})
});

// nudge
slate.bindAll({
    "right:cmd;alt":    slate.operation("nudge", {x: "+50", y: "+0"}),
    "left:cmd;alt":     slate.operation("nudge", {x: "-50", y: "+0"}),
    "up:cmd;alt":       slate.operation("nudge", {x: "+0", y: "-50"}),
    "down:cmd;alt":     slate.operation("nudge", {x: "+0", y: "+50"})
});

// throw
slate.bindAll({
    "1:cmd;alt": slate.operation("throw", {
        screen: 0
    }),
    "2:cmd;alt": slate.operation("throw", {
        screen: 1
    })
});
