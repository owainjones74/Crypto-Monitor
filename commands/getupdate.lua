local json = require("json")

command.Register("get-update", "Dumps the current monitor.", function(msg, args)
	local buyAmount, sellAmount = coinbase.GetBuy("XRP", settings.Get(msg.guild.id, "currency", "USD")), coinbase.GetSell("XRP", settings.Get(msg.guild.id, "currency", "USD"))

	print("buy", buyAmount, "sell", sellAmount)


	local embed = {}
	-- Base information
	embed.title = "**Current XRP Value**"
	embed.timestamp = os.date("!%Y-%m-%dT%TZ")
	embed.footer = {
		icon_url = msg.author:getAvatarURL(),
		text = msg.author.name 
	}

	-- Stats
	embed.fields = {
		{
			name = "Buy",
			value = buyAmount,
			inline = true
		},
		{
			name = "Sell",
			value = sellAmount,
			inline = true
		}
	}

	msg:reply({embed = embed})
	msg:addReaction("👍")
end)