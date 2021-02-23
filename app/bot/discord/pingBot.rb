require 'discordrb'

class DiscordPingBot
    def run
        bot = Discordrb::Bot.new token: ENV['DISCORD_BOT_TOKEN'], client_id: ENV['DISCORD_CLIENT_ID']
        bot.message(with_text: 'Ping!') do |event|
            event.respond 'Pong!'
        end
        bot.run
    end
end
