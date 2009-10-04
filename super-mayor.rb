require 'rubygems'
require 'sinatra'
require 'open-uri'
require 'oauth'
require 'activerecord'

OAUTH_KEY = '563c0300213b2a25ccf63c6f46c1c9eb04ac814b4'
OAUTH_SECRET = 'f7098abcbca7886c9c1cc0c7ded773ca'

enable :sessions

@consumer=OAuth::Consumer.new( OAUTH_KEY, OAUTH_SECRET, {
    :site   => "http://foursquare.com",
    :scheme => 'header'
})

get '/' do 
  
end

get '/login' do
  @request_token=@consumer.get_request_token
  session[:request_token] = @request_token
  redirect @request_token.authorize_url
end

get '/oauth' do
  return "You don't have a session. You are an abject failure." unless session[:request_token]
  
  @access_token = session[:request_token].get_access_token
  
  # save @access_token.token and @access_token.secret to the user object
end