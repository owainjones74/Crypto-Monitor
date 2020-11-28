local json = require("json")
local COINBASE = {}
-- Internal
COINBASE.name = "coinbase" -- This needs to be unique enough not to fuck mess the global table
COINBASE.cache = {} -- A cache of settings to claim every process ms we can.

--[[
Name: COINBASE.GetBuy
Def: Get the current buy value of the selected crypto
Args:
	crypto: string, The crypto to get the buy amount for
]]--
function COINBASE.GetBuy(crypto, currency)
	local data = httpR.Get("https://api.coinbase.com/v2/prices/"..crypto.."-"..currency.."/buy")
	data = json.decode(data)
	data = data['data']

	return data.amount
end

--[[
Name: COINBASE.GetSell
Def: Get the current sell value of the selected crypto
Args:
	crypto: string, The crypto to get the sell amount for
]]--
function COINBASE.GetSell(crypto, currency)
	local data = httpR.Get("https://api.coinbase.com/v2/prices/"..crypto.."-"..currency.."/sell")
	data = json.decode(data)
	data = data['data']

	return data.amount
end

return COINBASE