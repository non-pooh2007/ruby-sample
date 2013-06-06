$(function(){
    ws = new WebSocket("ws://non-pooh2007.herokuapp.com:51234");
//    ws = new WebSocket("ws://localhost:51234");
    ws.onmessage = function(evt) {
        $("#msg").append("<p>"+evt.data+"</p>");
    };

    ws.onclose = function() {
        console.log("������")
    };

    ws.onopen = function() {
        ws.send("�q��������I(?????) ");
    };

    $("#input").keypress(function(e){
        if(e.keyCode ==13){
            var val = $("#input").val()
            ws.send(val)
            $("#input").val("")
        }
    });
});
