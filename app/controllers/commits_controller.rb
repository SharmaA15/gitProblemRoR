require 'httparty' #simplifies making HTTP requests.
require 'json' #built-in Ruby module that provides methods for parsing JSON (JavaScript Object Notation) data and converting Ruby objects into JSON format.
class CommitsController < ApplicationController

  BASE_URL = 'https://api.github.com'.freeze

  def show
    owner = params[:owner]
    repository = params[:repository]
    oid = params[:oid]
    url = "#{BASE_URL}/repos/#{owner}/#{repository}/commits/#{oid}"
    response = HTTParty.get(url)
    render json: response.body, status: response.code
  end
  
  def diff
    owner = params[:owner]
    repository = params[:repository]
    oid = params[:oid]
    url = "#{BASE_URL}/repos/#{owner}/#{repository}/commits/#{oid}"
    headers = {
      "Authorization" => "Bearer #{params[:token]}",
      "Accept" => "application/vnd.github.v3.diff"
    }
    response = HTTParty.get(url, headers: headers)

    if response.success?
      render json: response.body, status: response.code
    else
      render json: { error: "Error fetching commit diff: #{response.message}" }, status: response.code
    end
  end

end
