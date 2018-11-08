-- w przypadku jak IP kamera się zawiesi i nie odpowiada na PING (Ping Checker) widoczne na switchu
-- 'kamera status', to wyłączamy na 3 sekundy jej zasilanie. Czyli robimy na 
-- 3 sekundy Off dla gniazdka serowanego z Domoticza (w tym przypadku o nazwie 'Kontakt Kamera')
-- kamera uruchamia się ponownie i działa. Można to zrobić dla innych urządzeń, którym pomaga restart.

return {
	on = {
		devices = {
			'kamera status'
		}
	},
	execute = function(domoticz, device)
        if device.state == 'Off' then
            domoticz.devices('Kontakt Kamera').switchOff().forSec(3)
        end
	end
}
