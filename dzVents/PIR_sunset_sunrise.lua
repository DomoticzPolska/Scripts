-- skrypt uruchamiający światło po wykryciu ruchu na PIR, uwzględniając czas 
-- między: od 60 minut przed zachodem słońca do 60 minut po wschodzie słońca
-- autor: Gabriel Zima, gabriel.zima@gmail

return {
	on = {
		devices = {
			'PIR korytarz'
		}
	},
	execute = function(domoticz, device)
	    if (domoticz.time.matchesRule('between 60 minutes before sunset and 60 minutes after sunrise')) then
            domoticz.devices('Światłó korytarz').switchOn().checkFirst()
        end
	end
}
