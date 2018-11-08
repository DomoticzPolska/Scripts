#!/bin/bash

# Skrypt ma za zadanie wysłać kopie danych domoticza na serwer ftp.
# Aby wysłąć kopie danych na serwer ftp należy w Domoticzu włączyć w ustawieniach Automatyczna kopia zapasowa i na serwerze ftp  musi być utworzony katalog domoticzbackups
# Kopia danych w Domoticzu tworzy się o 00:00 każdego dania więc i my tą kopie musimy wysyłąć na serwer ftp każdego dnia.
# Zrobimy to za pomocą wpisu w crontabie za pomoca polecenia sudo crontab -e 
# Dodając wpis 15 00 * * * /home/pi/domoticzbackup.sh >/dev/null 2>&1 gdzie 15 00 * * * to godzina 00:15 i wychodzimy zapisijąć ctr x. 

SERVER="adres serwera FTP"
USERNAME="nazwa użytkownika FTP"
PASSWORD="hasło"

data=`/bin/date +%d`
data2=`/bin/date +%Y-%m-%d`

echo "Tworzę archiwum gz"
gzip -c /home/pi/domoticz/backups/daily/backup-day-$data-Domoticz.db > /home/pi/domoticz/backups/daily/backup-day-$data2.gz
rm /home/pi/domoticz/backups/daily/backup-day-$data-Domoticz.db

echo "Wysyłam kopię pliku backup-day-$data2.gz na serwer ftp://$SERVER"
curl -s --disable-epsv -v -T"/home/pi/domoticz/backups/daily/backup-day-$data2.gz" -u"$USERNAME:$PASSWORD" "ftp://$SERVER/domoticzbackups/"
rm /home/pi/domoticz/backups/daily/backup-day-$data2.gz
