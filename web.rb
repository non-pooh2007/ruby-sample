require 'sinatra'
require 'haml'
require 'sinatra/websocketio'

io = Sinatra:WebSocketIO

io.on :connect do |session|
  puts "new client <#{session}>"
  push :chat, {:name => "system", :message => "new client <#{session}> / #{io.sessions.size} clients connecting"}
  push :chat, {:name => "system", :message => "welcome <#{session}>"}, {:to => session}
end

io.on :disconnect do |session|
  puts "disconnect client <#{session}>"
  push :chat, {:name => "system", :message => "bye <#{session}>"}
end

get '/' do
  "<p>What your name? </p>"+"<form action='/hello' method='POST'><input type='text' name='name'><input type='submit' value='send'></form>"
end

get '/haml' do
  haml :sample
end

get '/google' do
  haml :google
end

get '/gg' do
  haml :gg
end

get '/chat' do
end
