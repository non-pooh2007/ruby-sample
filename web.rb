require 'sinatra'
require 'haml'

get '/' do
  "<p>What your name? </p>"+"<form action='/hello' method='POST'><input type='text' name='name'><input type='submit' value='send'></form>"
end

get '/haml' do
  haml :sample
end

get '/google' do
  haml :google
end
