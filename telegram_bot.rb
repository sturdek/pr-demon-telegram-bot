require 'telegram/bot'

module TelegramBot
  def initialize_telegram_bot
    @token = ENV['TELEGRAM_TOKEN']
    @recipients = ENV['RECIPIENTS'].split('|')
  end

  def send_msg(message, recipient)
    Telegram::Bot::Client.run(@token) do |bot|
      bot.api.send_message(chat_id: recipient, text: message)
      break
    end
  end
end
