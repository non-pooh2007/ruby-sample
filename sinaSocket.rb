require 'sinatra'
require 'haml'
require 'sinatra-websocket'
require 'pusher'
require 'json'

set :server, 'thin'
set :sockets, []

$users = []

get '/login' do
  "<p>What your name? </p>"+"<form action='/login' method='POST'><input type='text' name='name'><input type='submit' value='login'></form>"
end

post '/login' do
  warn( params )
  $users.push( params['name'] )
  warn( $users )
  js_file = open( "public/index2.html", "rb" )
  text_data = js_file.read
  js_file.close
  text_data.sub!(/my_event/, params['name'] )

  [ 200, { 'Content-Type' => 'text/html' }, text_data ]

#  data = JSON.parse request.body.read
#  warn( "params" + params )
#  warn( "body" + data )
end

get '/pusher' do
  # Pusher['test_channel'].trigger('my_event', {:x => 1234, :y => 000 })
  warn( $users )
  $users.each  do |user|
    Pusher['test_channel'].trigger( user, {:user => user, :x => 1234, :y => 5678 })
  end
end

post '/post_pos' do
  warn( params )
  Pusher['test_channel'].trigger( 'tom', {:x => params['x'] , :y => params['y']} )
end

get '/google_post_pos' do
  haml :google_post_pos
end

get '/google' do
  haml :google
end

get '/google_frame' do
  haml :google_frame
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

