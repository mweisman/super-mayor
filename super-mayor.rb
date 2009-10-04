require 'rubygems'
require 'sinatra'
require 'sinatra_activerecord'
require 'oauth'
require 'json'
require 'models/user'
require 'models/magic'
require 'models/district'

configure  do
  ActiveRecord::Base.configurations = database_configuration
  ActiveRecord::Base.establish_connection(APP_ENV)
  ActiveRecord::Base.logger = Logger.new("activerecord.log") # Somehow you need logging right?
end

# Production Keys
OAUTH_KEY = '563c0300213b2a25ccf63c6f46c1c9eb04ac814b4'
OAUTH_SECRET = 'f7098abcbca7886c9c1cc0c7ded773ca'

# Dev Keys
OAUTH_KEY = 'c6d03fd67301b83af88edb168da4f71004ac8302f'
OAUTH_SECRET = '86f582af859b1ccbf1457ffc9329833d'

use Rack::Session::Pool

get '/' do 
  @records = nil
  erb :index
end

get '/login' do
  @consumer=OAuth::Consumer.new( OAUTH_KEY, OAUTH_SECRET, {
      :site   => "http://foursquare.com",
      :scheme => 'header'
  })

  @request_token=@consumer.get_request_token
  session[:request_token] = @request_token
  redirect @request_token.authorize_url
end

get '/oauth' do
  return "You don't have a session. You are an abject failure." + session.inspect unless session[:request_token]
  
  @access_token = session[:request_token].get_access_token
  
  response = @access_token.get 'http://api.foursquare.com/v1/user.json'
  return "There was an error. You aren't a very good person." unless response.code == "200"

  user_data = JSON.parse(response.body)['user']

  @user = User.find_or_create_by_userid(user_data['id'])
  @user.userid      = user_data['id']
  @user.token       = @access_token.token
  @user.secret      = @access_token.secret
  @user.firstname   = user_data['firstname']
  @user.lastname    = user_data['lastname']
  @user.currentcity = user_data['city']['id']
  @user.photourl    = user_data['photo']
  @user.save

  "Welcome to SuperMayor, #{@user.firstname} #{@user.lastname}! This is the first step towards your personal betterment."
end