local json = require("json")

CLIENT:on("heartbeat", function()
	local buyAmountCache, sellAmountCache = {}, {}
	-- Build all the channels to dump to
	for k, v in pairs(CLIENT.guilds) do
		local channels = settings.Get(v.id, "monitor", false)
		local channelsObj = {}
		-- If there is a valid channel
		if channels then
			channels = json.decode(channels)

			for n, m in pairs(channels) do
				print(n, m)
				table.insert(channelsObj, CLIENT:getChannel(m))
			end

			local currency = settings.Get(v.id, "currency", "USD")
	
			if not buyAmountCache[currency] then
				buyAmountCache[currency], sellAmountCache[currency] = coinbase.GetBuy("XRP", currency), coinbase.GetSell("XRP", currency)
			end
	
			local buyAmount, sellAmount = buyAmountCache[currency], sellAmountCache[currency]
	
			-- Dump to all them channels
			for k, v in pairs(channelsObj) do
				local embed = {}
				-- Base information
				embed.title = "**Current XRP Value**"
				embed.timestamp = os.date("!%Y-%m-%dT%TZ")
				embed.footer = {
					icon_url = CLIENT.user:getAvatarURL(),
					text = CLIENT.user.name 
				}
			
				-- Stats
				embed.fields = {
					{
						name = "Currency",
						value = currency,
						inline = true
					},
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
			
				v:send({embed = embed})
			end
		end
	end
end)