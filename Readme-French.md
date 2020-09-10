# Sentora-Windows-Installation-et-mise-à-jour
Ce projet est conçu pour installer ou mettre à niveau Sentora 1.0.3 pour Windows

pour la mise à jour il peut travailler avec ZPanel 10.0.2 ou 10.1.1 ou Sentora for Windows 1.0.0 Version de MarkDark

Installateur Mise à Niveau Version Beta 1

SVP Visitez la page <a href="../../releases/">releases</a> pour Télécharger le fichier de l'installateur

Nouveaux, vous pouvez maintenant choisir le dossier d'installation

il et égallement possible comme beaucoup l'avez demander a l'époque d'installer dans un autres disque dur que le disque C

# Attention

Si vous metez à jour Zpanel vers Sentora 1.0.3

n'installer pas dans le dossier C:\zpanel

si vous metez à jour Sentora 1.0.0 Version de MarkDark vers Sentora 1.0.3

n'installer pas dans le dossier C:\sentora

afin d'éviter de fournir un pack très encombrant (4 Go 32 + 64bit) et de pouvoir permettre la mise à jour rapide de celui-ci

le programme d'installation fourni est inférieur à 10 Mo

et télécharge lui-même toutes les dépendances

donc si vous êtes en 64 bits

il va télécharger les dépendances pour la version 64 bits

pour la version 32 bits et bien c'est le contraire

au lieu d'avoir un pack de près de 4 Go, il téléchargera moins de 2 Go

cela et possible grâce à l'utilisation de Inno Download Plugin

cet installateur et disponible en plusieurs langues

mais seuls l'anglais et le français sont entièrement traduits

pour les autres langues, vous aurez la traduction de base d'inno setup

vous pouvez participer à la traduction des messages personnalisés (custom message)

note seule les langues présente dans d'inno setup peuvent être ajoutée si vous souhaitez ajouter une langue qui n'existe pas dans inno Setup, il vous faudra d'abord ajouter la langue dans le projet inno setup

fichier de langue anglais par défaut de inno setup

https://github.com/jrsoftware/issrc/blob/main/Files/Default.isl

dossier pour les tradauction

https://github.com/jrsoftware/issrc/tree/main/Files/Languages

Supporte les Systèmes suivant

Windows 7 (extendend Support 2023)

Windows Server 2008 (extendend Support 2023)

Windows 8

Windows Server 2012

Windows 10

Windows Server 2016

ne supporte pas (Raison .NET Framework 4.5.2 N'est pas compatible)

Windows Vista

Windows XP

Windows ME

et toutes les ancienne version de Windows

Dependence de ce Pack

requis pour utiliser ce pack installer automatiquement par l'installateur

Microsoft Visual C++ 2005 redistribuable 64 bit ou 32 bit

Microsoft Visual C++ 2008 redistribuable 64 bit ou 32 bit

Microsoft Visual C++ 2011 redistribuable 64 bit ou 32 bit

Microsoft Visual C++ 2013 redistribuable 64 bit ou 32 bit

Microsoft .NET Framework 3.5 MultiArch (Windows 8, Windows server 2012, Windows 10 and Windows Server 2016 installer automatiquement en utilisant dism)

Microsoft .NET Framework 4.5.2 MultiArch

ce Pack contient

HTTPD Apache 2.4.38 64 bit ou 32 bit (derniére version d'apache compiler avec le vc11 par apache lounge php 5.6 requis une version vc11)

PHP 5.6.40 64 bit ou 32 bit inclut suhosin 0.9.37.1

MySQL 5.7.29 64 bit ou 32 bit

BIND (named) 9.14.8 64 bit ou 32 bit

HmailServer 5.7.0-B2519 pour 64 bit (résout le problème libmysql.dll non lu)

HmailServer 5.6.7-B2425 for 32 bit

Filezilla Server 0.9.60.2 32 bit

nnCron LITE 1.17 (résout le problème du daemon qui s'ouvre en fenétre)

Sendmail for Windows 32 bit la même version que dans zpanel

p7zip (7z.exe) 19.00 32 bit ou 64 bit

cygtools contient (outil cygwin minimal) 32 bit ou 64 bit

bzip2 1.0.8 

cat (GNU coreutils) 8.26

grep (GNU grep) 3.0

gzip 1.8

gunzip fichier bat redirige vers gzip -d

ls (GNU coreutils) 8.26

sed (GNU sed) 4.4

tar 3.3.2 (bsdtar 3.3.2 - libarchive 3.3.2 zlib/1.2.5.f-ipp)

unzip 6.00

wget GNU Wget 1.19.1 built on cygwin (ssl fonctionne parfaitement tls 2 ok)

xz (XZ Utils) 5.2.4

zip 3.0



service fichier bat convertit commande net

option disponible

service start servicename

service stop servicename

service restart servicename

service reload servicename

service force-reload servicename





systemctl fichier bat converti les commande net et sc

option disponible

atention ne pas utiliser servicename.service

systemctl enable servicename

systemctl disable servicename

systemctl start servicename

systemctl stop servicename

systemctl restart servicename

systemctl reload servicename

systemctl force-reload servicename

Désinstallation

par rapport au précédente version cette installateur résout les problème suivant

lors de sa désinstallation

service non suprimer

variable PATH non désinstaller

si vous metes a jour la variable PATH sera réunitialiser a sa variable par défaut

en revanche lors d'une l'installation propre ainsi que lors de la désinstallation le programme  rajoutera ou enléveraenléve unqiuement les dossier de sentora

sans modifier vos autres dossier présent dans la variable y compris si vous l'installer sans mettre à jour

clès de registre de hmailserver et bind (named) non désinstaller

Any questions, comments or support, please post in our forums here: http://forums.sentora.org/forumdisplay.php?fid=61

