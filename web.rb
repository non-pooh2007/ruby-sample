require 'sinatra'
require 'haml'

get '/' do
  "<p>what your name!? </p>"+"<form action='/hello' method='POST'><input type='text' name='name'><input type='submit' value='send'></form>"
end

get '/haml' do
  haml :sample
end
