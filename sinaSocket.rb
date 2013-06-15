require 'sinatra'
require 'haml'
require 'sinatra-websocket'
require 'pusher'
require 'json'

set :server, 'thin'
set :sockets, []

$users = []

get '/login' do
  "<p>What your name? </p>"+"<form action='/login' method='POST'><input type='text' name='name'><input type='submit' value='send'></form>"
end

post '/login' do
  warn( params )
  $users.push( params['name'] )
  warn( $users )

  pre_header = <<"Pre Head end"
  <!DOCTYPE html>
  <head>
    <title>Pusher Test</title>
    <script src="http://js.pusher.com/2.0/pusher.min.js" type="text/javascript"></script>
    <script type="text/javascript">
Pre Head end

  foot_header = <<"Foot Head end"
  </script>
    <script src="/embed.js" type="text/javascript">
    </script>
  </head> <body>
Foot Head end

  [ 200, { 'Content-Type' => 'text/html' },
  [ pre_header + "bind_event =\'" + params['name'] + "\';" + foot_header + "</body></html>"] ]

#  data = JSON.parse request.body.read
#  warn( "params" + params )
#  warn( "body" + data )
end

get '/pusher' do
  # Pusher['test_channel'].trigger('my_event', {:id => 1234, :message => 'hello world'})
  warn( $users )
  Pusher['test_channel'].trigger( $users, {:id => 1234, :message => 'hello world'})
  # Pusher['test_channel'].trigger( 'tom', {:id => 1234, :message => 'hello world'})
end

get '/' do
    # warn( "CON:" + env['HTTP_CONNECTION'] )
    # warn( "UP:" + env['HTTP_UPGRADE'] )
    warn( env )
    request.websocket do |ws|
      ws.onopen do
        ws.send("Hello World!")
	settings.sockets << ws
      end
      ws.onmessage do |msg|
        EM.next_tick {settings.sockets.each{|s| s.send(msg) } }
      end
      ws.onclose do
        warn("websocket closed")
	settings.sockets.delete(ws)
      end
    end
end

