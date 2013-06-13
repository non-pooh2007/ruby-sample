require 'sinatra'
require 'haml'
require 'sinatra/websocketio'

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
