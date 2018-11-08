--Skrypt ma za zadanie sterować ogrzewaniem poprzez Domoticza gdzie mamy wirtualny switch "Tryb pracy" z wyborem OFF ON Auto,
--który w zależności od wyboru uruchamia wirtulany przełącznik załczający przekaźnik odpowiedzialny za ogrzewanie. 
--ON OFF nie będę opisywał wiadomo co robi. Tryb Auto ma za zadanie sprawdzać jaka jest aktulanie temperatura w wyznaczonym pomieszczeniu 
--w stosunku do temperatury zadanej w formie wirulentnego termostatu" który będzie ustawiany jako Temperatura zadana".
--W skrypcie mamy kolejny wirtulany termostat który odpowiada za histerezę ogrzewania i również będzie ustawiany. 
--W moim przypadku jest 0.5 Stopnia. Czyli jeżeli temperatura spadnie w pomieszczeniu wyznaczonym do pilnowania na 20.5 lub niżej 
--to włączy ogrzewanie a jak będzie 21.5 lub wyższa  to wyłączy ogrzewanie.

local zadana = 'Temperatura zadana'  --Temperatura zadana termostat.
local histereza = 'Histereza ogrzewania' --histeraza załączenia/wyłączenia .
local temp_Wiki = 'Pokój Wiki' --Pokój do pilnowania temperatury.
local trybpracy = 'Ogrzewanie tryb pracy' --Wirtualny przełącznik określający tryb pracy ogrzewania.
local ogrzewanie = 'Ogrzewanie' --Wirtulany przełącznik załczający przekaźnik odpowiedzialny za ogrzewanie.
local temp_aktualna = tonumber(otherdevices[temp_Wiki]) --zmiana na kiczbe
local temp_zadana = tonumber(otherdevices[zadana]) --zmiana na kiczbe
local temp_histereza = tonumber(otherdevices[histereza]) --zmiana na kiczbe
    
commandArray = {}

if (devicechanged [trybpracy]=='On') then
    print('Tryb pracy ogrzewanie ON.')
    commandArray [ogrzewanie]='On'
        
elseif (devicechanged [trybpracy]=='Off') then
    print('Tryb pracy ogrzewanie Off.')
    commandArray [ogrzewanie]='Off'

elseif (devicechanged [trybpracy]=='Auto') then
    print('Tryb pracy ogrzewanie Auto.')
    commandArray [ogrzewanie]='Off'
end

if (devicechanged [temp_Wiki]) then
	if (otherdevices[trybpracy]=='Auto') and (temp_aktualna <= (temp_zadana - temp_histereza)) and (otherdevices[ogrzewanie]=='Off') then
        print('Ogrzewanie ON.')
        commandArray[ogrzewanie]='On'
    elseif (otherdevices [trybpracy]=='Auto') and (temp_aktualna >= (temp_zadana + temp_histereza))  and (otherdevices[ogrzewanie]=='On') then
        print('Ogrzewanie OFF.')
        commandArray[ogrzewanie]='Off'
    end
end
 
return commandArray
