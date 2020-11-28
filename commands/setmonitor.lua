local json = require("json")

command.Register("set-monitor", "Set the channel that will be used to monitor real time values.", function(msg, args)
	if not msg.guild then return end

	local channels = msg.mentionedChannels

	if #channels == 0 then
		msg:reply("Please provide a text channel you wish for me to post monitor updates in!")
		msg:addReaction("👎")
		return
	end

	local channelsFormatted = {}

	for k, v in pairs(channels) do
		if not (v.type == 0) then
			msg:reply("I can only post my monitor updates to text channels...")
			msg:addReaction("👎")
			return
		end

		table.insert(channelsFormatted, v.id)
	end

	channelsFormatted = json.encode(channelsFormatted)

	settings.Set(msg.guild.id, "monitor", channelsFormatted)

	msg:reply("You have successfully updated the monitor channels!")
	msg:addReaction("👍")
end)