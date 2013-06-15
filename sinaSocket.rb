require 'sinatra'
require 'haml'
require 'sinatra-websocket'
require 'pusher'
require 'json'

set :server, 'thin'
set :sockets, []

$users = []

get '/login' do
  "<p>What your name? </p>"+"<form action='/hello' method='POST'><input type='text' name='name'><input type='submit' value='send'></form>"
end

post '/hello' do
  warn( params )
  $users.push( params['name'] )
  warn( $users )
#  data = JSON.parse request.body.read
#  warn( "params" + params )
#  warn( "body" + data )
end

get '/pusher' do
  Pusher['test_channel'].trigger('my_event', {:id => 1234, :message => 'hello world'})
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

