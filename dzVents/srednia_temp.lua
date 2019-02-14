-- Oplicza średnią temperaturę z czujników zdefinowanych w obiekcie data.temps
-- i wyświetla ją w urządzeniu 'Temperatura Średnia'

return {
	on = {timer = {'every minute'}},
	data = {
        	temps = {
			'Pokój Szymka',
			'Pokój Marysi',
			'Gabinet',
			'Sypialnia'
		}
  },
	execute = function(domoticz, device)
    local sum = 0
	  local count = 0
      for i, temp in pairs(domoticz.data.temps) do
          sum = sum + domoticz.devices(temp).temperature
          count = count + 1
      end
      domoticz.devices('Temperatura Średnia').updateTemperature(domoticz.round(sum / count, 1))
	end
}
