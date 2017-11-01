require "facebook/messenger"
include Facebook::Messenger
Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
# message.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
# message.sender      # => { 'id' => '1008372609250235' }
# message.sent_at     # => 2016-04-22 21:30:36 +0200
# message.text        # => 'Hello, bot!'




Bot.on :message do |message|
  command = message.text.downcase.split(" ")

  #TOTAL --------------------
  if command.include? 'total'

      Bot.deliver({
        recipient: message.sender,
        message: {
          text: "The total value of your portfolio is #{CoinbaseController.new.total_value.to_i}$, a gain of #{CoinbaseController.new.total_gain.to_i}%"
        }
      }, access_token: ENV["ACCESS_TOKEN"])

  #LTC -----------------------
  elsif command.include? 'ltc'

    #PRICE
    Bot.deliver({
      recipient: message.sender,
      message: {
        text: "The price is #{CoinbaseController.new.ltc_price}$"
      }
    }, access_token: ENV["ACCESS_TOKEN"])

    #PORTFOLIO
    Bot.deliver({
      recipient: message.sender,
      message: {
        text: "You own #{CoinbaseController.new.ltc_portfolio} Coin"
      }
    }, access_token: ENV["ACCESS_TOKEN"])

    #VALUE
    Bot.deliver({
      recipient: message.sender,
      message: {
        text: "For a total of #{CoinbaseController.new.ltc_value.to_i}$"
      }
    }, access_token: ENV["ACCESS_TOKEN"])

    #GAIN
    Bot.deliver({
      recipient: message.sender,
      message: {
        text: "And a gain of #{CoinbaseController.new.ltc_gain.to_i}%"
      }
    }, access_token: ENV["ACCESS_TOKEN"])

  #BTC -----------------------
  elsif command.include? 'btc'

    #PRICE
    Bot.deliver({
      recipient: message.sender,
      message: {
        text: "The price is #{CoinbaseController.new.btc_price}$"
      }
    }, access_token: ENV["ACCESS_TOKEN"])

    #PORTFOLIO
    Bot.deliver({
      recipient: message.sender,
      message: {
        text: "You own #{CoinbaseController.new.btc_portfolio} Coin"
      }
    }, access_token: ENV["ACCESS_TOKEN"])

    #VALUE
    Bot.deliver({
      recipient: message.sender,
      message: {
        text: "For a total of #{CoinbaseController.new.btc_value.to_i}$"
      }
    }, access_token: ENV["ACCESS_TOKEN"])

    #GAIN
    Bot.deliver({
      recipient: message.sender,
      message: {
        text: "And a gain of #{CoinbaseController.new.btc_gain.to_i}%"
      }
    }, access_token: ENV["ACCESS_TOKEN"])

  #BTC -----------------------
  elsif command.include? 'eth'

    #PRICE
    Bot.deliver({
      recipient: message.sender,
      message: {
        text: "The price is #{CoinbaseController.new.eth_price}$"
      }
    }, access_token: ENV["ACCESS_TOKEN"])

    #PORTFOLIO
    Bot.deliver({
      recipient: message.sender,
      message: {
        text: "You own #{CoinbaseController.new.eth_portfolio} Coin"
      }
    }, access_token: ENV["ACCESS_TOKEN"])

    #VALUE
    Bot.deliver({
      recipient: message.sender,
      message: {
        text: "For a total of #{CoinbaseController.new.eth_value.to_i}$"
      }
    }, access_token: ENV["ACCESS_TOKEN"])

    #GAIN
    Bot.deliver({
      recipient: message.sender,
      message: {
        text: "And a gain of #{CoinbaseController.new.eth_gain.to_i}%"
      }
    }, access_token: ENV["ACCESS_TOKEN"])


  #ERREUR ---------------------
  else
    Bot.deliver({
      recipient: message.sender,
      message: {
        text: "Sorry, I'm not program to do this"
      }
    }, access_token: ENV["ACCESS_TOKEN"])



  end

end
