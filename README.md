# gitProblemRoR

In config/routes.rb 

Rails.application.routes.draw do
  get '/repositories/:owner/:repository/commits/:oid', to: 'commits#show'
  get '/repositories/:owner/:repository/commits/:oid/diff', to: 'commits#diff'
end


And in controller we need to write the actions for these two routes 
so in app/controllers/commits_controller.rb

  require 'httparty' #simplifies making HTTP requests.
  require 'json' #built-in Ruby module that provides methods for parsing JSON (JavaScript Object Notation) data and converting Ruby objects into JSON format.
  
  BASE_URL = ' https://teamfleetstudio.github.io'.freeze

  def show
    owner = params[:owner]
    repository = params[:repository]
    oid = params[:oid]
    url = "#{BASE_URL}/repositories/#{owner}/#{repository}/commits/#{oid}"
    response = HTTParty.get(url)
    render json: response.body, status: response.code
  end
  
  def diff
    owner = params[:owner]
    repository = params[:repository]
    oid = params[:oid]
    url = "#{BASE_URL}/repositories/#{owner}/#{repository}/commits/#{oid}/diff"
    response = HTTParty.get(url)
    render json: response.body, status: response.code
  end

rails s
