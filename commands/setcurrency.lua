local json = require("json")

command.Register("set-currency", "Set the channel that will be used to monitor real time values. (Use get-currencies for a list of valid currencies)", function(msg, args)
	if not msg.guild then return end

	local currencyID = string.upper(args[1])
	local currencyName = CLIENT._ValidCurrencies[currencyID]

	if not currencyName then
		msg:reply("This is not a valid currency. You can find valid currenices with the command `get-currencies`!")
		msg:addReaction("👎")
		return
	end

	settings.Set(msg.guild.id, "currency", currencyID)

	msg:reply(string.format("You have successfully updated the currency to be %s (%s)!", currencyName, currencyID))
	msg:addReaction("👍")
end)