  fGetLocation = 0;
  prevLat = 0; prevLng = 0;
  // $("map").style.width = document.width + "px";
  // $("map").style.height = document.height + "px";
  $("map").style.width = screen.width + "px";
  $("map").style.height = screen.height + "px";
  navigator.geolocation.getCurrentPosition( notifyPos );
  var watchOption = { enableHighAccuracy:false, timeout:60000, maximumAge:10000 };
  navigator.geolocation.watchPosition( notifyPos, notifyErrPos, watchOption );
  function notifyErrPos(pos){
  }
  function notifyPos(pos){ 
    var lat = pos.coords.latitude;
    var lng = pos.coords.longitude;
    var mypos = new google.maps.LatLng(lat, lng);
    var option = { zoom:16, center:mypos,
    mapTypeId:google.maps.MapTypeId.ROADMAP };
    if ( fGetLocation == 0 ) {
      gmap = new google.maps.Map($("map"), option);
      gmarker = new google.maps.Marker({ position:mypos, map:gmap });
      fGetLocation = 1;
    } else {
      var frm = $('post_pos_form');
      frm.x.value = lat;
      frm.y.value = lng;
      var result = frm.submit();
      gmap.panTo( mypos );
      gmarker.setPosition( mypos );
      return false;
    } // fGetLocation = 1
  }
  function $(id){ return document.getElementById(id); }

