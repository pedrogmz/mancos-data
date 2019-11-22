Locales = {}

function _(str, ...) -- Translate string

	if Locales[Config.Locale] ~= nil then

		if Locales[Config.Locale][str] ~= nil then
			return string.format(Locales[Config.Locale][str], ...)
		else
			return 'Traducción [' .. Config.Locale .. '][' .. str .. '] no existe'
		end

	else
		return 'Locale [' .. Config.Locale .. '] no existe'
	end

end

function _U(str, ...) -- Translate string first char uppercase
	return tostring(_(str, ...):gsub("^%l", string.upper))
end
