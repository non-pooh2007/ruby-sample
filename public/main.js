$(function(){
    ws = new WebSocket("ws://non-pooh2007.herokuapp.com:80/chat");
//    ws = new WebSocket("ws://localhost:51234");
    ws.onmessage = function(evt) {
        $("#msg").append("<p>"+evt.data+"</p>");
    };

    ws.onclose = function() {
        console.log("closed")
    };

    ws.onopen = function() {
        ws.send("connect!(?????) ");
    };

    $("#input").keypress(function(e){
        if(e.keyCode ==13){
            var val = $("#input").val()
            ws.send(val)
            $("#input").val("")
        }
    });
});
