require 'faye/websocket'
require 'eventmachine'
require 'lru_redux'
require_relative 'telegram_bot'

include TelegramBot

initialize_telegram_bot
cache = LruRedux::Cache.new(ENV['LRU_COUNT'].to_i)

EM.run {
  ws = Faye::WebSocket::Client.new('ws://prdemon_pr_demon_1:7999')

  ws.on :message do |event|
    @data = JSON.parse(event.data)
    payload = @data['payload']
    build = payload['build']
    pr = payload['pr']
    if (!build.nil? && build['state'] == 'Finished')
      id = pr['id']
      if (cache[id] != build['status'])
        build_id = build['build_id']
        branch = build['branch_name']
        url = build['web_url']
        name = pr['author']['name']
        if (build['status'] == 'Failure')
          msg = "\xF0\x9F\x94\xA5[#{build_id}] build #{branch} failed!\xF0\x9F\x94\xA5 \n#{url} \nCulprits: #{name}"
          puts msg
        elsif (build['status'] == 'Success')
          msg = "\xF0\x9F\x8D\x80[#{build_id}] build #{branch} passed!\xF0\x9F\x8D\x80 \nAuthors: #{name}"
        end
        @recipients.each do |r|
          send_msg(msg,r)
        end
        cache[id] = build['status']
      end
    end
  end
}