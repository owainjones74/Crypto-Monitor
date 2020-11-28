local httpr = require("coro-http")

_G.httpR = {}

function httpR.Get(url)
	local res, body = httpr.request("GET", url)
	
	return body
end