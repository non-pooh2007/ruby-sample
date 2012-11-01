require 'sinatra'

get '/' do
  puts "<p>what your name! </p>"
  puts "<form action='/hello' method='POST'><input type='text' name='name'><input type='submit' value='send'></form>"
end
