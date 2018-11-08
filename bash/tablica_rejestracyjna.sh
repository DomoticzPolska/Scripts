#!/bin/bash

# skrypt rozpoznaje tablicę rejestracyjną ze zdjęcia i zamienia jej numer na tekst.
# jako parametr trzeba podać ścieżkę do zdjęcia.
#
# do poprawnego działania należy zainstalować programy:
# 1. alpr (sudo apt install OpenALPR)
# 2. jq (sudo apt install jq)


plik_graficzny=$1

rejestracja=$(alpr -c eu -n 1 -j $plik_graficzny | jq -r '.results[0].plate')

echo $plik_graficzny
