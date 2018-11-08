-- Pobranie kursu BITCOIN z API https://www.bitmarket.pl/json/BTCPLN/ticker.json i aktualizacja urządzenia 'Kurs BTC'

return {
    on = {
        timer = { 'every minute' },
        httpResponses = { 'BTCPLN' }
    },
    execute = function(domoticz, item)
        if (item.isTimer) then
            domoticz.openURL({
                url = 'https://www.bitmarket.pl/json/BTCPLN/ticker.json',
                method = 'GET',
                callback = 'BTCPLN'
            })
        end

        if (item.isHTTPResponse and item.ok) then
            domoticz.devices('Kurs BTC').updateCustomSensor(item.json.last)
        end
    end
}
