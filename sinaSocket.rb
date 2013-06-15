require 'sinatra'
require 'haml'
require 'sinatra-websocket'
require 'pusher'

set :server, 'thin'
set :sockets, []

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

