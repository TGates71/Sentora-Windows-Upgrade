Inno Setup installer and updatter Development version

Please do not use on a production server

to compile this installer you would need to

Download the installer folder of this git

Install Inno Setup

https://jrsoftware.org/isdl.php#stable

Actual Version 6.0.5

https://jrsoftware.org/download.php/is.exe

Install Inno Download Plugin

Actual Version 1.5.1

BitBucket

https://bitbucket.org/mitrich_k/inno-download-plugin/downloads/idpsetup-1.5.1.exe

Google Drive

https://drive.google.com/open?id=0Bzw1xBVt0mokWHlicktGUVNXeTA

once this install open the file installer\install_script.iss in Inno Setup and click compile

if you have the error

Line 1:
[ISPP] File not found: 'installer\{tmp}\install_script.iss'.

you will need to indicate the full path to this file

Example

C:\Users\yourusers\Downloads\Sentora-Windows-Upgrade\installer\{tmp}\install_script.iss

although the real code is in this file installer\{tmp}\install_script.iss

it is very important to maintain this include

because it allows to recover the source file when which and unpack with innounp

example

innounp -x -m Sentora-1_0_3.exe

if your computer and in 32 bits which rather rare nowadays

you will have to modify in the file installer\{tmp}\install_script.iss

the path to the Program Files

example

C:\Program Files instead of C:\Program Files (x86)

this installation is intended to be compatible on all standard version of windows from windows vista

as well as the server version from windows server 2008

windows xp and windows server 2003 being obsolete for far too long

I don't find it useful to keep support for these versions
so that it works without problem you must have the latest service pack of your installation especially on windows vista 7 and windows server 2008

on higher versions it should work without any service pack or update

but without guarantee always install the latest updates for your security
