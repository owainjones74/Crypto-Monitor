local SETTINGS = {}
-- Internal
SETTINGS.name = "settings" -- This needs to be unique enough not to fuck mess the global table
SETTINGS.cache = {} -- A cache of settings to claim every process ms we can.

--[[
Name: SETTINGS.Set
Def: Set a setting
Args:
	guild: string, The guild ID
	setting: String, The setting to set
	value: string, What that value should be 
]]--
function SETTINGS.Set(guild, setting, value)
	if not SETTINGS.cache[guild] then
		settings.cache[guild] = {}
	end

	settings.cache[guild][setting] = value

	sql.Query(string.format("INSERT OR REPLACE INTO settings(guild, setting, value) VALUES('%s', '%s', '%s');", sql.Escape(guild), sql.Escape(setting), sql.Escape(value)))
end

--[[
Name: SETTINGS.Get
Def: Get a setting
Args:
	guild: String, The guild ID
	setting: String, The setting to get
	default: String, If no setting is set, it will return this
Returns:
	String, Either the setting requested or the default given.
]]--
function SETTINGS.Get(guild, setting, default)
	if not SETTINGS.cache[guild] then
		settings.cache[guild] = {}
	end

	if not settings.cache[guild][setting] then
		local data = sql.Query(string.format("SELECT value FROM settings WHERE guild='%s' AND setting='%s' LIMIT 1", guild, setting))
		if not data then return default end

		local value = data[1][1]
	
		if value then
			settings.cache[guild][setting] = value
		end
	end

	return settings.cache[guild][setting] or default or false
end

return SETTINGS