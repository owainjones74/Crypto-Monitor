local json = require("json")

CLIENT:on("ready", function()
	-- Create the table for settings
	if not sql.TableExists("settings") then
		print("Table 'settings' didn't exist, I have now made it.")
		sql.Query("CREATE TABLE settings (guild TEXT NOT NULL, setting TEXT NOT NULL, value TEXT, UNIQUE(guild, setting))")
	end

	-- Load all the valid currencies
	CLIENT._ValidCurrencies = {}

	local currenices = httpR.Get("https://api.coinbase.com/v2/currencies")
	currenices = json.decode(currenices)
	currenices = currenices['data']

	for k, v in pairs(currenices) do
		CLIENT._ValidCurrencies[v.id] = v.name
	end
end)