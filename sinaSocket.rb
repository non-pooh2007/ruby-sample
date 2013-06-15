require 'sinatra'
require 'haml'
require 'sinatra-websocket'

set :server, 'thin'
set :sockets, []

get '/' do
    warn( env['HTTP_CONNECTION'] )
    warn( env['HTTP_UPGRADE'] )
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

