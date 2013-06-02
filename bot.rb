require 'omegle'
require 'rainbow'
require 'cleverbot-api'


def botOutput(msg)
	puts "cleverbot: ".color(:red) + msg
	`say -v 'Kathy' "#{msg}"`
end

def userOutput(msg)
	puts "omegle user: ".color(:green) + msg	
	`say -v 'Fred' "#{msg}"`
end

while 1
	bot = CleverBot.new
	o = Omegle.new()
	o.start

	`say "Starting new session"`
	o.listen{
		|e|
		if e[0] == "connected"
			puts "connected"
			`say "connected"`
			botOutput("Heeeeey :D")
			o.send "Heeeeey :D"
		end

		if e[0] == "disconnected"
			puts "disconnected"
		end

		if e[0] == "gotMessage"
			userOutput(e[1]);
			response = bot.think e[1]
			botOutput(response)
			o.send response
		end
	}

	puts "user disconnected"
	`say "User disconnected"`
end