require 'coinbase/wallet'
require 'json'
require 'open-uri'
require 'uri'

class CoinbaseController < ApplicationController

  @@client = Coinbase::Wallet::Client.new(api_key: 'HX1AZ5b61nTj5bzg',
                                           api_secret: '0acgSsP9cAqhCKgYqF8kKNr1VgSHlciT',
                                           CB_VERSION: '2017-06-16')

  def transaction
    transactions = []
    @@client.accounts.each do |account|
      transactions << account.transactions
    end

    return transactions
  end

  #Crypto Prices -----------------------------------------------

  def eth_price
    url_eth = "https://api.quadrigacx.com/v2/ticker?book=eth_cad"
    response = open(url_eth).read
    return JSON.parse(response)["last"].to_i
  end

  def ltc_price
    url_ltc = "https://api.quadrigacx.com/v2/ticker?book=ltc_cad"
    response = open(url_ltc).read
    return JSON.parse(response)["last"].to_i
  end

  def btc_price
    url_btc = "https://api.quadrigacx.com/v2/ticker?book=btc_cad"
    response = open(url_btc).read
    return JSON.parse(response)["last"].to_i
  end

  #Initial investment price ------------------------------------------------------------

  def eth_initial
    initial_eth = 0
    transaction[1].each { |trans| initial_eth += trans['native_amount']['amount'].to_f }
    return initial_eth
  end

  def ltc_initial
    initial_ltc = 0
    transaction[0].each { |trans| initial_ltc += trans['native_amount']['amount'].to_f }
    return initial_ltc
  end

  def btc_initial
    initial_btc = 0
    transaction[2].each { |trans| initial_btc += trans['native_amount']['amount'].to_f }
    return initial_btc
  end

  def total_initial
    return ltc_initial + eth_initial + btc_initial
  end

  #Number of coin owned per currency ------------------------------

  def eth_portfolio
    return @@client.accounts[1].balance.amount.to_f
  end

  def ltc_portfolio
    return @@client.accounts[0].balance.amount.to_f
  end

  def btc_portfolio
    return @@client.accounts[2].balance.amount.to_f
  end

  #Value in dollar of each currency -

  def eth_value
    return eth_portfolio * eth_price
  end

  def ltc_value
    return ltc_portfolio * ltc_price
  end

  def btc_value
    return btc_portfolio * btc_price
  end

  def total_value
    return ltc_value + eth_value + btc_value
  end

  # Gain in pourcentage of each currency owned --------

  def eth_gain
    return ((eth_value - eth_initial) / eth_value) * 100
  end

  def ltc_gain
    return ((ltc_value - ltc_initial) / ltc_value) * 100
  end

  def btc_gain
    return ((btc_value - btc_initial) / btc_value) * 100
  end

  def total_gain
    return ((total_value - total_initial) / total_value) * 100
  end




end
