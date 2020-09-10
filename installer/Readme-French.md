Inno Setup installateur et updatter Version de dévelopement

SVP ne pas utilisé sur une serveur en production

pour compiller cette installateur vous aurrait besoin de

Télécharger le dossier installer de ce git

Installer Inno Setup

https://jrsoftware.org/isdl.php#stable

Version Actuel 6.0.5

https://jrsoftware.org/download.php/is.exe

Installer Inno Download Plugin

https://mitrichsoftware.wordpress.com/inno-setup-tools/inno-download-plugin/

Version actuel 1.5.1

BitBucket

https://bitbucket.org/mitrich_k/inno-download-plugin/downloads/idpsetup-1.5.1.exe

Google Drive

https://drive.google.com/open?id=0Bzw1xBVt0mokWHlicktGUVNXeTA

une fois ceci installer ouvrez le fichier installer\install_script.iss dans inno setup et clicquez sur compiller

si vous avez l'erreur

Line 1:
[ISPP] File not found: 'installer\{tmp}\install_script.iss'.

il vous faudra indiquer le chemin d'accès complet vers ce fichier

exemple

C:\Users\votrenom\Téléchargements\Sentora-Windows-Upgrade\installer\{tmp}\install_script.iss

bien que le véritable code ce trouve dans ce fichier installer\{tmp}\install_script.iss

il et très important de maintenir cette include

car cela permet de récupérer le fichier source lorsque qui et décompiller avec innounp

exemple

innounp -x -m Sentora-1_0_3.exe

si votre ordinateur et en 32 bits ce qui plutôt rare de nos jours

il vous faudra modifier dans le fichier installer\{tmp}\install_script.iss

le chemin d'accès vers le Program Files

exemple

C:\Program Files au lieu de C:\Program Files (x86)

cette installation est prévu pour être compatible sur toutes version standard de windows a partir de windows vista

ainsi que les version serveur a partir de windows server 2008

windows xp et windows server 2003 étant obsoléte depuis bien trop longtemps

je ne trouve pas utile de conserver un support vers ces version
afin que celui fonctionne sans problème vous devez disposez des dernier service pack de votre installation notament sur windows vista 7 et windows server 2008

sur les version suppérieur il devrait fonctionner sans aucun service pack ni mise à jour

mais sans garantit veillez toujours installer les derniére mise à jour pour votre sécurité



