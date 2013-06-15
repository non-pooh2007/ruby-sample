    // Enable pusher logging - don't include this in production
    Pusher.log = function(message) {
      if (window.console && window.console.log) window.console.log(message);
    };

    var pusher = new Pusher('92577fdc22964f716bc6');
    var channel = pusher.subscribe('test_channel');
    channel.bind(bind_event, function(data) {
      alert(data.id + data.message);
    });

