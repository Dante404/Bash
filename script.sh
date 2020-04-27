#! /bin/sh

var1=HTTP
echo podaj nazwe testowanego protokolu:
read protokol

echo Podaj adres IP celu:
read IP
echo ile razy wykonac test?
read END
START=1
service tor start

if [ "${protokol,,}" = "${var1,,}" ]; 
then
echo Podaj adres uri formularza logowania:
read URI
echo Podaj nazwe parametru "login":
read LOGIN
echo Podaj nazwe parametru "haslo":
read PASS
echo Podaj komunikat nieudanego logowania:
read KOMUNIKAT
for i in $(eval echo "{$START..$END}")
do
proxychains hydra -l test -p test -vV -F $IP http-post-form "$URI:$LOGIN=^USER^&$PASS=^PASS^:F=$KOMUNIKAT"
service tor reload
done
else
for i in $(eval echo "{$START..$END}")
do
proxychains hydra -l test -p test -vV -F $IP $protokol
service tor reload
done
fi
