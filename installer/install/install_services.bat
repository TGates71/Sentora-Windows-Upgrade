@echo off
rem %1 = install dir
rem %2 = temp dir
echo install dir %1
echo temp dir %2
echo your_full_name %3
echo your_email %4
echo your_fqdn %5
echo password_for_zadmin %6
rem disable Windows Firewall
C:\windows\System32\netsh.exe Advfirewall set allprofiles state off
rem code test for backup and update all database
IF EXIST "C:\zpanel\panel\cnf\db.php" (
 rem test uninstall old zpanel
 C:\Windows\System32\net.exe stop apache
 C:\Windows\System32\sc.exe delete apache
 C:\Windows\System32\net.exe stop named
 C:\Windows\System32\sc.exe delete named
 C:\Windows\System32\net.exe stop cron
 C:\Windows\System32\sc.exe delete cron
 C:\Windows\System32\net.exe stop "Filezilla Server"
 C:\Windows\System32\sc.exe delete "Filezilla Server"
 C:\Windows\System32\net.exe stop hmailserver
 C:\Windows\System32\sc.exe delete hmailserver
C:\Windows\System32\reg.exe query HKEY_LOCAL_MACHINE\SOFTWARE\hMailServer
   if %ERRORLEVEL% EQU 0 (
C:\Windows\System32\reg.exe delete HKEY_LOCAL_MACHINE\SOFTWARE\hMailServer /f
   )
C:\Windows\System32\reg.exe query HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\hMailServer
   if %ERRORLEVEL% EQU 0 (
C:\Windows\System32\reg.exe delete HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\hMailServer /f
   )
   
C:\Windows\System32\reg.exe query HKEY_CURRENT_USER\Software\hMailServer
   if %ERRORLEVEL% EQU 0 (
C:\Windows\System32\reg.exe delete HKEY_CURRENT_USER\Software\hMailServer /f
   )
C:\Windows\System32\reg.exe query HKEY_CURRENT_USER\SOFTWARE\WOW6432Node\hMailServer
   if %ERRORLEVEL% EQU 0 (
C:\Windows\System32\reg.exe delete HKEY_CURRENT_USER\SOFTWARE\WOW6432Node\hMailServer /f
   )

C:\Windows\System32\reg.exe query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\hMailServer_is1
   if %ERRORLEVEL% EQU 0 (
C:\Windows\System32\reg.exe delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\hMailServer_is1 /f
   )

C:\Windows\System32\reg.exe query HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\hMailServer_is1
   if %ERRORLEVEL% EQU 0 (
C:\Windows\System32\reg.exe delete HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\hMailServer_is1 /f
   )

 C:\Windows\System32\net.exe stop mysql
 C:\Windows\System32\sc.exe delete mysql
C:\zpanel\bin\mysql\bin\mysqld.exe --install
 C:\Windows\System32\net.exe start mysql
 C:\zpanel\bin\php\php.exe %2\db.php %1 %2
 C:\Windows\System32\net.exe stop mysql
 C:\Windows\System32\sc.exe delete mysql
 del C:\Windows\zppy.bat
 del C:\Windows\setso.bat
 del C:\Windows\zppy.bat
 del C:\Windows\System32\crontab.txt
 rem remove old path varaible environement
C:\Windows\System32\reg.exe delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path /f
C:\Windows\System32\reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /f /v Path /t REG_SZ /d  C:\Windows;C:\Windows\System32;%1\bin\apache\bin;%1\bin\mysql\bin;%1\bin\php;%1\bin\cygtools\bin;%1\bin\bind\bin
rem remove old and updated folder
rem pause
goto dbupdate
)
IF EXIST "C:\sentora\panel\cnf\db.php" (
 rem test uninstall old zpanel
 C:\Windows\System32\net.exe stop apache
 C:\Windows\System32\sc.exe delete apache
 C:\Windows\System32\net.exe stop named
 C:\Windows\System32\sc.exe delete named
 C:\Windows\System32\net.exe stop cron
 C:\Windows\System32\sc.exe delete cron
 C:\Windows\System32\net.exe stop "Filezilla Server"
 C:\Windows\System32\sc.exe delete "Filezilla Server"
 C:\Windows\System32\net.exe stop hmailserver
 C:\Windows\System32\sc.exe delete hmailserver
C:\Windows\System32\reg.exe query HKEY_LOCAL_MACHINE\SOFTWARE\hMailServer
C:\Windows\System32\reg.exe query HKEY_LOCAL_MACHINE\SOFTWARE\hMailServer
   if %ERRORLEVEL% EQU 0 (
C:\Windows\System32\reg.exe delete HKEY_LOCAL_MACHINE\SOFTWARE\hMailServer /f
   )
C:\Windows\System32\reg.exe query HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\hMailServer
   if %ERRORLEVEL% EQU 0 (
C:\Windows\System32\reg.exe delete HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\hMailServer /f
   )
   
C:\Windows\System32\reg.exe query HKEY_CURRENT_USER\Software\hMailServer
   if %ERRORLEVEL% EQU 0 (
C:\Windows\System32\reg.exe delete HKEY_CURRENT_USER\Software\hMailServer /f
   )
C:\Windows\System32\reg.exe query HKEY_CURRENT_USER\SOFTWARE\WOW6432Node\hMailServer
   if %ERRORLEVEL% EQU 0 (
C:\Windows\System32\reg.exe delete HKEY_CURRENT_USER\SOFTWARE\WOW6432Node\hMailServer /f
   )

C:\Windows\System32\reg.exe query HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\hMailServer_is1
   if %ERRORLEVEL% EQU 0 (
C:\Windows\System32\reg.exe delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\hMailServer_is1 /f
   )

C:\Windows\System32\reg.exe query HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\hMailServer_is1
   if %ERRORLEVEL% EQU 0 (
C:\Windows\System32\reg.exe delete HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\hMailServer_is1 /f
   )
 C:\Windows\System32\net.exe stop mysql
 C:\Windows\System32\sc.exe delete mysql
C:\zpanel\bin\mysql\bin\mysqld.exe --install
 C:\Windows\System32\net.exe start mysql
C:\Windows\System32\taskkill.exe /f /im apachemonitor.exe
C:\Windows\System32\taskkill.exe /f /im "filezilla server interface.exe"
 C:\zpanel\bin\php\php.exe %2\db.php %1 %2
 C:\Windows\System32\net.exe stop mysql
 C:\Windows\System32\sc.exe delete mysql
 rem remove old path varaible environement
C:\Windows\System32\reg.exe delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path /f
C:\Windows\System32\reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /f /v Path /t REG_SZ /d  C:\Windows;C:\Windows\System32;%1\bin\apache\bin;%1\bin\mysql\bin;%1\bin\php;%1\bin\cygtools\bin;%1\bin\bind\bin
rem remove old and updated folder
rem pause
goto dbupdate
)
:dbupdate
rem update.bat %1 %2
cd %2
rmdir /S /Q Apache24
IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)
:64BIT
rem install Visual C++ redistributable 2005 2008 2011 2013 require for apache php and mysql
%2\vcredist5_x64.exe /q
%2\vcredist8_x64.exe /q /norestart
%2\vcredist11_x64.exe /q /norestart
%2\vcredist13_x64.exe /q /norestart
rem install microsoft net framework 3.5 and 4.5 require for hmailserver
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "10.0" goto W10
if "%version%" == "6.3" goto W8
if "%version%" == "6.2" goto W8
if "%version%" == "6.1" goto W7
if "%version%" == "6.0" goto W7
if "%version%" == "5.9" goto W7
if "%version%" == "5.8" goto W7
if "%version%" == "5.7" goto W7
if "%version%" == "5.6" goto W7
if "%version%" == "5.5" goto W7
if "%version%" == "5.4" goto W7
if "%version%" == "5.3" goto W7
if "%version%" == "5.2" goto W7
if "%version%" == "5.0" goto W7
if "%version%" == "5.0" goto W7
rem etc etc
endlocal
:W7
%2\dotnetfx35.exe /q /norestart
%2\NDP452-KB2901907-x86-x64-AllOS-ENU.exe /q /norestart
goto ENDNET
:W8
rem for windows 8 and 10 net framework 3.5 install online using dism
C:\Windows\System32\dism.exe /Online /Enable-Feature /FeatureName:NetFx3 /All
rem msu dependencie for windows 8 and windows server 2012
rem read https://github.com/Dravion/hmailserver/releases
mkdir %2\updates
rename %2\Windows8.1-KB2919442-x64.msu %2\updates\Windows8.1-KB2919442-x64.msu
rename %2\Windows8.1-KB2919355-x64.msu %2\updates\Windows8.1-KB2919355-x64.msu
C:\Windows\System32\dism.exe /online /add-package /packagepath:%2\updates
:W10
rem for windows 8 and 10 net framework 3.5 install online using dism
C:\Windows\System32\dism.exe /Online /Enable-Feature /FeatureName:NetFx3 /All
:ENDNET
%1\bin\7zip\7z.exe x httpd-2.4.38-win64-VC11.zip
cd %1\bin\php
%1\bin\7zip\7z.exe x %2\php-5.6.40-Win32-VC11-x64.zip
cd %2
rmdir /S /Q mysql-5.7.29-winx64
%1\bin\7zip\7z.exe x %2\mysql-5.7.29-winx64.zip
C:\Windows\System32\xcopy.exe /s /e /h %2\mysql-5.7.29-winx64 %1\bin\mysql
cd %1\bin\bind\bin\
%1\bin\7zip\7z.exe x %2\BIND9.14.8.x64.zip
cd %1\bin\cygtools
%1\bin\7zip\7z.exe x %2\cygtools-64bit.zip
GOTO END
:32BIT
%2\vcredist5_x86.exe /q
%2\vcredist8_x86.exe /q /norestart
%2\vcredist11_x86.exe /q /norestart
%2\vcredist13_x86.exe /q /norestart
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "10.0" goto W10
if "%version%" == "6.3" goto W8
if "%version%" == "6.2" goto W8
if "%version%" == "6.1" goto W7
if "%version%" == "6.0" goto W7
if "%version%" == "5.9" goto W7
if "%version%" == "5.8" goto W7
if "%version%" == "5.7" goto W7
if "%version%" == "5.6" goto W7
if "%version%" == "5.5" goto W7
if "%version%" == "5.4" goto W7
if "%version%" == "5.3" goto W7
if "%version%" == "5.2" goto W7
if "%version%" == "5.0" goto W7
if "%version%" == "5.0" goto W7
rem etc etc
endlocal
:W7
%2\dotnetfx35.exe /q /norestart
%2\NDP452-KB2901907-x86-x64-AllOS-ENU.exe /q /norestart
goto ENDNET
:W8
rem for windows 8 and 10 net framework 3.5 install online using dism
C:\Windows\System32\dism.exe /Online /Enable-Feature /FeatureName:NetFx3 /All
rem msu dependencie for windows 8 and windows server 2012
rem read https://github.com/Dravion/hmailserver/releases
rem not require en 32 bit version
rem dism /online /add-package /packagepath:%2\updates
:W10
rem for windows 8 and 10 net framework 3.5 install online using dism
C:\Windows\System32\dism.exe /Online /Enable-Feature /FeatureName:NetFx3 /All
:ENDNET
%1\bin\7zip\7z.exe x httpd-2.4.38-win32-VC11.zip
cd %1\bin\php
%1\bin\7zip\7z.exe x %2\php-5.6.40-Win32-VC11-x86.zip
cd %2
rmdir /S /Q mysql-5.7.29-win32
%1\bin\7zip\7z.exe x %2\mysql-5.7.29-win32.zip
C:\Windows\System32\xcopy.exe /s /e /h %2\mysql-5.7.29-win32 %1\bin\mysql
cd %1\bin\bind\bin\
%1\bin\7zip\7z.exe x %2\BIND9.14.8.x86.zip
cd %1\bin\cygtools
%1\bin\7zip\7z.exe x %2\cygtools-32bit.zip
GOTO END
:END
cd %2

C:\Windows\System32\xcopy.exe /s /e /h %2\Apache24 %1\bin\apache
%1\bin\php\php.exe %2\install.php %1 %2 %3 %4 %5 %6
echo finish configure
rem pause
%1\bin\mysql\bin\mysqld.exe --defaults-file="%1\bin\mysql\my.ini" --console --initialize-insecure=on --lower-case-table-names=1
echo finish init mysql
rem pause
echo Installing MySQL Service..
%1\bin\mysql\bin\mysqld.exe --install
echo Starting MySQL Service..
C:\Windows\System32\net.exe start MySQL

echo Installing Apache HTTPd Service..
%1\bin\apache\bin\httpd.exe -k install -n Apache
echo Starting Apache HTTPd service..
C:\Windows\System32\net.exe start Apache

echo Installing Filezilla service..
"%1\bin\filezilla\Filezilla server.exe" /install auto
echo Starting Filezilla service..
C:\Windows\System32\net.exe start "FileZilla Server"

echo install crond
"%1\bin\crond\cron.exe" -q -install
echo Starting Cron Service
C:\Windows\System32\net.exe start cron

echo Installing hMailServer...
IF EXIST "%PROGRAMFILES(X86)%" (
%2\hMailServer-5.7.0-B2519-x64.exe /DIR="%1\bin\hmailserver" /VERYSILENT
) ELSE (
%2\hMailServer-5.6.7-B2425.exe /DIR="%1\bin\hmailserver" /VERYSILENT
)

echo Starting hMailServer
C:\Windows\System32\net.exe stop hMailServer
C:\Windows\System32\net.exe start hMailServer

echo Installing BIND9.9...


C:\Windows\System32\net.exe start | C:\Windows\System32\find.exe "named"
if ERRORLEVEL 1 sc create named binpath= %1\bin\bind\bin\named.exe DisplayName= "named" start= auto
C:\Windows\System32\net.exe start | C:\Windows\System32\find.exe "named"
if ERRORLEVEL 1 %DIR%\bind\bin\sc.exe create named binpath= %1\bin\bind\bin\named.exe DisplayName= "named" start= auto
echo Starting BIND
C:\Windows\System32\net.exe stop named
C:\Windows\System32\net.exe start named
rem pause
echo Done installing Services!
echo All done!
rem pack install finish
rem continue panel install
cd %2\
%1\bin\7zip\7z.exe x %2\master.zip
rmdir /S /Q %2\Sentora-Windows-Upgrade-master\1.0.3\panel\upgrade
mkdir %1\panel
C:\Windows\System32\xcopy.exe %2\Sentora-Windows-Upgrade-master\1.0.3\panel %1\panel /s /e /h
rem pause
IF EXIST "%1\all_databases.sql" (
echo Restorinng Sentora database..
%1\bin\mysql\bin\mysql.exe -uroot < %2\Sentora-Windows-Upgrade-master\installer\{app}\bin\zpss\MySQL_User_Cleanup.sql
IF EXIST "%PROGRAMFILES(X86)%" (
%1\bin\php\php.exe %2\update.php %1 %2 %3 %4 %5 %6 32
) ELSE (
%1\bin\php\php.exe %2\update.php %1 %2 %3 %4 %5 %6 64
)
del %1\all_databases.sql
goto endconfigure
)
echo not update test
rem pause
echo Importing Sentora database..
%1\bin\mysql\bin\mysql.exe -uroot < %2\Sentora-Windows-Upgrade-master\installer\{app}\bin\zpss\sentora_core.sql
echo Importing hmailserver database..
IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BITHMAILDB) ELSE (GOTO 32BITHMAILDB)
:64BITHMAILDB
%1\bin\mysql\bin\mysql.exe -uroot < %2\Sentora-Windows-Upgrade-master\installer\{app}\bin\zpss\sentora_hmail64.sql
goto ENDHMAILDB
:32BITHMAILDB
%1\bin\mysql\bin\mysql.exe -uroot < %2\Sentora-Windows-Upgrade-master\installer\{app}\bin\zpss\sentora_hmail.sql
:ENDHMAILDB
echo Cleaning up MySQL users (securing MySQL server)..
%1\bin\mysql\bin\mysql.exe -uroot < %2\Sentora-Windows-Upgrade-master\installer\{app}\bin\zpss\MySQL_User_Cleanup.sql
%1\bin\php\php.exe %2\enviroment_configure.php %1 %2 %3 %4 %5 %6
echo end configure
:endconfigure
rem pause
echo The installer will now finalise the install...
echo Restarting services..
echo Stopping Apache
C:\Windows\System32\net.exe stop Apache 
echo Starting Apache
C:\Windows\System32\net.exe start Apache
echo Stopping hMailServer
C:\Windows\System32\net.exe stop hMailServer
echo Starting hMailServer
C:\Windows\System32\net.exe start hMailServer
echo Stopping BIND
C:\Windows\System32\net.exe stop named
echo Starting BIND
C:\Windows\System32\net.exe start named

echo Running the daemon for the first time..
%1\bin\php\php.exe %1\panel\bin\daemon.php
echo Done!
rem pause
%1\bin\php\php.exe %1/panel/bin/setzadmin --set %6
echo Password successfully set!
echo %6 >>c:\zpanel\login_details.txt

rem pause

echo Cleaning up..
DEL %1\bin\zpss\*.bat /Q
DEL %1\bin\zpss\*.php /Q
DEL %1\configs\bind\zones\*.* /Q
echo install finish
C:\Windows\System32\net.exe start apache
rem pause
exit

rem remove old and updated folder
rem pause
goto dbupdate
)
:dbupdate
rem update.bat %1 %2
cd %2
rmdir /S /Q Apache24
IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BIT) ELSE (GOTO 32BIT)
:64BIT
rem install Visual C++ redistributable 2005 2008 2011 2013 require for apache php and mysql
%2\vcredist5_x64.exe /q
%2\vcredist8_x64.exe /q /norestart
%2\vcredist11_x64.exe /q /norestart
%2\vcredist13_x64.exe /q /norestart
rem install microsoft net framework 3.5 and 4.5 require for hmailserver
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "10.0" goto W10
if "%version%" == "6.3" goto W8
if "%version%" == "6.2" goto W8
if "%version%" == "6.1" goto W7
if "%version%" == "6.0" goto W7
if "%version%" == "5.9" goto W7
if "%version%" == "5.8" goto W7
if "%version%" == "5.7" goto W7
if "%version%" == "5.6" goto W7
if "%version%" == "5.5" goto W7
if "%version%" == "5.4" goto W7
if "%version%" == "5.3" goto W7
if "%version%" == "5.2" goto W7
if "%version%" == "5.0" goto W7
if "%version%" == "5.0" goto W7
rem etc etc
endlocal
:W7
%2\dotnetfx35.exe /q /norestart
%2\NDP452-KB2901907-x86-x64-AllOS-ENU.exe /q /norestart
goto ENDNET
:W8
rem for windows 8 and 10 net framework 3.5 install online using dism
C:\Windows\System32\dism.exe /Online /Enable-Feature /FeatureName:NetFx3 /All
rem msu dependencie for windows 8 and windows server 2012
rem read https://github.com/Dravion/hmailserver/releases
mkdir %2\updates
rename %2\Windows8.1-KB2919442-x64.msu %2\updates\Windows8.1-KB2919442-x64.msu
rename %2\Windows8.1-KB2919355-x64.msu %2\updates\Windows8.1-KB2919355-x64.msu
C:\Windows\System32\dism.exe /online /add-package /packagepath:%2\updates
:W10
rem for windows 8 and 10 net framework 3.5 install online using dism
C:\Windows\System32\dism.exe /Online /Enable-Feature /FeatureName:NetFx3 /All
:ENDNET
%1\bin\7zip\7z.exe x httpd-2.4.38-win64-VC11.zip
cd %1\bin\php
%1\bin\7zip\7z.exe x %2\php-5.6.40-Win32-VC11-x64.zip
cd %2
rmdir /S /Q mysql-5.7.29-winx64
%1\bin\7zip\7z.exe x %2\mysql-5.7.29-winx64.zip
C:\Windows\System32\xcopy.exe /s /e /h %2\mysql-5.7.29-winx64 %1\bin\mysql
cd %1\bin\bind\bin\
%1\bin\7zip\7z.exe x %2\BIND9.14.8.x64.zip
cd %1\bin\cygtools
%1\bin\7zip\7z.exe x %2\cygtools-64bit.zip
GOTO END
:32BIT
%2\vcredist5_x86.exe /q
%2\vcredist8_x86.exe /q /norestart
%2\vcredist11_x86.exe /q /norestart
%2\vcredist13_x86.exe /q /norestart
setlocal
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "10.0" goto W10
if "%version%" == "6.3" goto W8
if "%version%" == "6.2" goto W8
if "%version%" == "6.1" goto W7
if "%version%" == "6.0" goto W7
if "%version%" == "5.9" goto W7
if "%version%" == "5.8" goto W7
if "%version%" == "5.7" goto W7
if "%version%" == "5.6" goto W7
if "%version%" == "5.5" goto W7
if "%version%" == "5.4" goto W7
if "%version%" == "5.3" goto W7
if "%version%" == "5.2" goto W7
if "%version%" == "5.0" goto W7
if "%version%" == "5.0" goto W7
rem etc etc
endlocal
:W7
%2\dotnetfx35.exe /q /norestart
%2\NDP452-KB2901907-x86-x64-AllOS-ENU.exe /q /norestart
goto ENDNET
:W8
rem for windows 8 and 10 net framework 3.5 install online using dism
C:\Windows\System32\dism.exe /Online /Enable-Feature /FeatureName:NetFx3 /All
rem msu dependencie for windows 8 and windows server 2012
rem read https://github.com/Dravion/hmailserver/releases
rem not require en 32 bit version
rem dism /online /add-package /packagepath:%2\updates
:W10
rem for windows 8 and 10 net framework 3.5 install online using dism
C:\Windows\System32\dism.exe /Online /Enable-Feature /FeatureName:NetFx3 /All
:ENDNET
%1\bin\7zip\7z.exe x httpd-2.4.38-win32-VC11.zip
cd %1\bin\php
%1\bin\7zip\7z.exe x %2\php-5.6.40-Win32-VC11-x86.zip
cd %2
rmdir /S /Q mysql-5.7.29-win32
%1\bin\7zip\7z.exe x %2\mysql-5.7.29-win32.zip
C:\Windows\System32\xcopy.exe /s /e /h %2\mysql-5.7.29-win32 %1\bin\mysql
cd %1\bin\bind\bin\
%1\bin\7zip\7z.exe x %2\BIND9.14.8.x86.zip
cd %1\bin\cygtools
%1\bin\7zip\7z.exe x %2\cygtools-32bit.zip
GOTO END
:END
cd %2

C:\Windows\System32\xcopy.exe /s /e /h %2\Apache24 %1\bin\apache
%1\bin\php\php.exe %2\install.php %1 %2 %3 %4 %5 %6
echo finish configure
rem pause
%1\bin\mysql\bin\mysqld.exe --defaults-file="%1\bin\mysql\my.ini" --console --initialize-insecure=on --lower-case-table-names=1
echo finish init mysql
rem pause
echo Installing MySQL Service..
%1\bin\mysql\bin\mysqld.exe --install
echo Starting MySQL Service..
C:\Windows\System32\net.exe start MySQL

echo Installing Apache HTTPd Service..
%1\bin\apache\bin\httpd.exe -k install -n Apache
echo Starting Apache HTTPd service..
C:\Windows\System32\net.exe start Apache

echo Installing Filezilla service..
"%1\bin\filezilla\Filezilla server.exe" /install auto
echo Starting Filezilla service..
C:\Windows\System32\net.exe start "FileZilla Server"

echo install crond
"%1\bin\crond\cron.exe" -q -install
echo Starting Cron Service
C:\Windows\System32\net.exe start cron

echo Installing hMailServer...
IF EXIST "%PROGRAMFILES(X86)%" (
%2\hMailServer-5.7.0-B2519-x64.exe /DIR="%1\bin\hmailserver" /VERYSILENT
) ELSE (
%2\hMailServer-5.6.7-B2425.exe /DIR="%1\bin\hmailserver" /VERYSILENT
)

echo Starting hMailServer
C:\Windows\System32\net.exe stop hMailServer
C:\Windows\System32\net.exe start hMailServer

echo Installing BIND9.9...


C:\Windows\System32\net.exe start | C:\Windows\System32\find.exe "named"
if ERRORLEVEL 1 sc create named binpath= %1\bin\bind\bin\named.exe DisplayName= "named" start= auto
C:\Windows\System32\net.exe start | C:\Windows\System32\find.exe "named"
if ERRORLEVEL 1 %DIR%\bind\bin\sc.exe create named binpath= %1\bin\bind\bin\named.exe DisplayName= "named" start= auto
echo Starting BIND
C:\Windows\System32\net.exe stop named
C:\Windows\System32\net.exe start named
rem pause
echo Done installing Services!
echo All done!
rem pack install finish
rem continue panel install
cd %2\
%1\bin\7zip\7z.exe x %2\master.zip
rmdir /S /Q %2\Sentora-Windows-Upgrade-master\1.0.3\panel\upgrade
mkdir %1\panel
C:\Windows\System32\xcopy.exe %2\Sentora-Windows-Upgrade-master\1.0.3\panel %1\panel /s /e /h
rem pause
IF EXIST "%1\all_databases.sql" (
echo Restorinng Sentora database..
%1\bin\mysql\bin\mysql.exe -uroot < %2\Sentora-Windows-Upgrade-master\installer\{app}\bin\zpss\MySQL_User_Cleanup.sql
IF EXIST "%PROGRAMFILES(X86)%" (
%1\bin\php\php.exe %2\update.php %1 %2 %3 %4 %5 %6 32
) ELSE (
%1\bin\php\php.exe %2\update.php %1 %2 %3 %4 %5 %6 64
)
del %1\all_databases.sql
goto endconfigure
)
echo not update test
rem pause
echo Importing Sentora database..
%1\bin\mysql\bin\mysql.exe -uroot < %2\Sentora-Windows-Upgrade-master\installer\{app}\bin\zpss\sentora_core.sql
echo Importing hmailserver database..
IF EXIST "%PROGRAMFILES(X86)%" (GOTO 64BITHMAILDB) ELSE (GOTO 32BITHMAILDB)
:64BITHMAILDB
%1\bin\mysql\bin\mysql.exe -uroot < %2\Sentora-Windows-Upgrade-master\installer\{app}\bin\zpss\sentora_hmail64.sql
goto ENDHMAILDB
:32BITHMAILDB
%1\bin\mysql\bin\mysql.exe -uroot < %2\Sentora-Windows-Upgrade-master\installer\{app}\bin\zpss\sentora_hmail.sql
:ENDHMAILDB
echo Cleaning up MySQL users (securing MySQL server)..
%1\bin\mysql\bin\mysql.exe -uroot < %2\Sentora-Windows-Upgrade-master\installer\{app}\bin\zpss\MySQL_User_Cleanup.sql
%1\bin\php\php.exe %2\enviroment_configure.php %1 %2 %3 %4 %5 %6
echo end configure
:endconfigure
rem pause
echo The installer will now finalise the install...
echo Restarting services..
echo Stopping Apache
C:\Windows\System32\net.exe stop Apache 
echo Starting Apache
C:\Windows\System32\net.exe start Apache
echo Stopping hMailServer
C:\Windows\System32\net.exe stop hMailServer
echo Starting hMailServer
C:\Windows\System32\net.exe start hMailServer
echo Stopping BIND
C:\Windows\System32\net.exe stop named
echo Starting BIND
C:\Windows\System32\net.exe start named

echo Running the daemon for the first time..
%1\bin\php\php.exe %1\panel\bin\daemon.php
echo Done!
rem pause
%1\bin\php\php.exe %1/panel/bin/setzadmin --set %6
echo Password successfully set!
echo %6 >>c:\zpanel\login_details.txt

rem pause

echo Cleaning up..
DEL %1\bin\zpss\*.bat /Q
DEL %1\bin\zpss\*.php /Q
DEL %1\configs\bind\zones\*.* /Q
echo install finish
C:\Windows\System32\net.exe start apache
rem pause
exit
