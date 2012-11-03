require 'sinatra'
reuuire 'haml'

get '/' do
  haml :sample
  "<p>what your name! </p>"
  #  "<form action='/hello' method='POST'><input type='text' name='name'><input type='submit' value='send'></form>"
end
