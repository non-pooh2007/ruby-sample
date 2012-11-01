require 'sinatra'

get '/' do
  "<p>what your name </p>"
  +"Hello world"
  +"<form action='/hello' method='POST'>"
  +"<input type='text' name='name'>
  +"<input type='submit' value='send'>
  +"</form>"
end
