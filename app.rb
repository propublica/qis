require 'rubygems'
require 'bundler/setup'
require 'yaml'
Bundler.require :default

CREDENTIALS = File.open('./keys.yml') { |y| YAML::load(y) }

require './goog_geocoder'


CLIENT_ID     = CREDENTIALS['instagram_client_id']
CLIENT_SECRET = CREDENTIALS['instagram_secret']
REQUEST_URI   = CREDENTIALS['root_uri']

class QIS < Sinatra::Base
  enable :sessions
  set :raise_errors, Proc.new { false }
  set :show_exceptions, false
  
  get '/' do
    if !params["code"] && !session[:access_token]
      redirect "https://api.instagram.com/oauth/authorize/?client_id=#{CLIENT_ID}&redirect_uri=#{REQUEST_URI}&response_type=code"
    end
    if params["code"]
      auth_obj = JSON.parse(RestClient.post("https://api.instagram.com/oauth/access_token", {
        :client_id => CLIENT_ID,
        :client_secret => CLIENT_SECRET,
        :grant_type => "authorization_code",
        :redirect_uri => REQUEST_URI,
        :code => params["code"]
      }))
      session[:access_token] = auth_obj["access_token"]
    end

    erb :index
  end

  post '/result' do
    @search_params = {}

    if params["place"]
      goog = GoogGeocoder.new(params["place"])
      if !goog.resp["results"].empty?
        geometry = goog.resp["results"].first["geometry"]["location"]
        @search_params[:lng] = geometry["lng"]
        @search_params[:lat] = geometry["lat"]
      end
    end
    @search_params[:text]          = params["text"] if params["text"]
    @search_params[:min_timestamp] = Time.parse("#{params["start_date"]} #{params["start_time"]}").to_i if params["start_date"] && params["start_time"]
    @search_params[:max_timestamp] = Time.parse("#{params["end_date"]} #{params["end_time"]}").to_i if params["end_date"] && params["end_time"]
    @search_params[:distance]      = params["distance"] if params["distance"]
    @search_params[:user]          = params["user"].gsub(/@/,"") if params["user"] && params["user"].length > 0
    @search_params[:tag]           = params["tag"].gsub(/#/,"")  if params["tag"]  && params["tag"].length > 0

    if @search_params[:user]
      users = JSON.parse(RestClient.get("https://api.instagram.com/v1/users/search", {:params => {:q => @search_params[:user], :count => 1, :access_token => session[:access_token]}}))
      if users['data'].length > 0
        user_id = users['data'][0]['id']
        results = RestClient.get("https://api.instagram.com/v1/users/#{user_id}/media/recent", :params => {
          :access_token  => session[:access_token],
          :min_timestamp => @search_params[:min_timestamp],
          :max_timestamp => @search_params[:max_timestamp],
          :count => 1000
        })
      end
    elsif @search_params[:tag]
      results = RestClient.get("https://api.instagram.com/v1/tags/search", {:params => {:q => @search_params[:tag], :access_token => session[:access_token]}})
    else
      results = RestClient.get("https://api.instagram.com/v1/media/search", {:params => @search_params.merge!({:access_token => session[:access_token]})})
    end


    @results = JSON.parse(results)

    erb :result
  end

  error do
    err = request.env['sinatra.error']
    if err.class == RestClient::BadRequest
      @error = JSON.parse(err.response)
    end

    erb :err
  end

  run! if app_file == $0  
end
