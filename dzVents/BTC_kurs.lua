-- Pobranie kursu BITCOIN z API https://www.bitmarket.pl/json/BTCPLN/ticker.json i aktualizacja urządzenia 'Kurs BTC'
-- API zwraca następującego JSONa 
-- {"ask":24328.5085,"bid":24320.0000,"last":24328.5085,"low":24194.0864,"high":24517.2600,"vwap":24414.8269,"volume":52.26252419}
-- pobieramy z niego wartość dla "last", którą mamy w obiekcie item.json.last

return {
    on = {
        timer = { 'every minute' },
        httpResponses = { 'BTCPLN' }
    },
    execute = function(domoticz, item)
        if (item.isTimer) then -- gdy funkcja wywołana jest za pomocą triggera "timer"
            domoticz.openURL({
                url = 'https://www.bitmarket.pl/json/BTCPLN/ticker.json',
                method = 'GET',
                callback = 'BTCPLN'
            })
        end

        if (item.isHTTPResponse and item.ok) then -- gdy funkcja wywołana jest za pomocą triggera "httpResponses"
            domoticz.devices('Kurs BTC').updateCustomSensor(item.json.last) -- aktualizacja urządzenia
        end
    end
}
