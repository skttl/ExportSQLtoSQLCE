@echo off
set /p servername="Server: "
set /p dbname="Database: "
set /p username="Brugernavn: "
set /p password="Adgangskode: "

cls
echo ***
echo Sletter evt. eksisterende databaser og sqlce scripts
echo ***
del %dbname%.sdf
del %dbname%*.sqlce

cls
echo ***
echo Eksporterer %dbname% fra %servername% til sqlce scripts
echo ***
exportsqlce40 "server=%servername%;database=%dbname%;user id=%username%;password=%password%" %dbname%.sqlce

cls
echo ***
echo Importerer sqlce scripts til %dbname%.sdf
echo ***
sqlcecmd40 -d "Data Source=%dbname%.sdf" -e create

for %%f in (%dbname%*.sqlce) do (

	echo Importerer %%f
	c:\sqlce\sqlcecmd40 -d "Data Source=%dbname%.sdf" -i %%f > log.txt
)


cls
echo ***
echo Slut!
echo ***
