require 'open-uri'
require 'json'
require 'httparty'
require 'csv'

class QuestradeController < ApplicationController

  #Recover the last token -----
  questrade = Questrade.find(1)
  refresh_token = questrade.token

  #Create variables from API response --------------------------------------------------------------------------
  login_url = "https://login.questrade.com/oauth2/token?grant_type=refresh_token&refresh_token=#{refresh_token}"

  response = open(login_url).read

  access_token = JSON.parse(response)["access_token"]
  refresh_token = JSON.parse(response)["refresh_token"]
  token_type = JSON.parse(response)["token_type"]
  api_server = JSON.parse(response)["api_server"]
  account_number = ENV["ACCOUNT_NUMBER"]

  #Save new refresh_token ------------------------
  questrade.update_attribute :token, refresh_token
  questrade.save

  #Create the request to questrade --------------------------
  url = "#{api_server}v1/accounts/#{account_number}/balances"
  url2 = "#{api_server}v1/accounts/#{account_number}/positions"

  headers = {
    Authorization: "#{token_type} #{access_token}"
  }

  @@response = HTTParty.get(url, headers: headers)
  @@response2 = HTTParty.get(url2, headers: headers)

  # Methods to get the data -------------------------------
  def combined_balance
    return @@response["combinedBalances"][0]["totalEquity"]
  end

  def positions
    return response2
  end


end
