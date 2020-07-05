<?php
//prepare for upgrade
$install_folder = $argv[1];
$temp_dir = $argv[2];
$temp_phpdir = str_replace("\\", "/", $temp_dir);
$your_full_name = $argv[3];
$your_email = $argv[4];
$your_fqdn = $argv[5];
$password_for_zadmin = $argv[6];
$install_phpdir = str_replace("\\", "/", $install_folder);
$install_slash = str_replace("\\", "\\\\", $install_folder);
$filename1 = 'C:/zpanel/panel/cnf/db.php';
$filename2 = 'C:/sentora/panel/cnf/db.php';
//update for zpanelx backup database and transfert file
if (file_exists($filename1)) {
//here command for backup zpanel db and check update to 10.1.1
include 'C:/zpanel/panel/cnf/db.php';
$version = exec("setso --show dbversion");
if ($version == "10.0.2") {
// file  https://github.com/zpanel/zpanelx/blob/10.1.1/etc/build/config_packs/ms_windows/zpanelx-update/10-1-0/zpanel_update.sql
exec("C:\zpanel\bin\mysql\bin\mysql.exe -u root -p" . $pass . " < " . $temp_dir ."\zpanel_10-1-0_update.sql");
// file https://github.com/zpanel/zpanelx/blob/10.1.1/etc/build/config_packs/ms_windows/zpanelx-update/10-1-0/roundcube_update.sql
exec("C:\zpanel\bin\mysql\bin\mysql.exe -u root -p" . $pass . " < " . $temp_dir ."\roundcube_update.sql");
// file https://github.com/zpanel/zpanelx/blob/10.1.1/etc/build/config_packs/ms_windows/zpanelx-update/10-1-1/zpanel_update.sql
exec("C:\zpanel\bin\mysql\bin\mysql.exe -u root -p" . $pass . " < " . $temp_dir ."\zpanel-10-1-1_update.sql");
}
// file https://github.com/andykimpe/Sentora-Windows-Upgrade/blob/master/installer/update/update.sql
exec("C:\zpanel\bin\mysql\bin\mysql.exe -u root -p" . $pass . " < " . $temp_dir ."\update.sql");
// change database name command based on linux version line 777
// just remove proftpd and postfix et adding hmail 
// https://github.com/sentora/sentora-installers/blob/1.0.3-release/sentora_install.sh
exec("C:\zpanel\bin\mysql\bin\mysqldump.exe -u root -p" . $pass . " zpanel_core | C:\zpanel\bin\mysql\bin\mysql.exe -u root -p" . $pass . " -D sentora_core");
exec("C:\zpanel\bin\mysql\bin\mysqldump.exe -u root -p" . $pass . " zpanel_roundcube | C:\zpanel\bin\mysql\bin\mysql.exe -u root -p" . $pass . " -D sentora_roundcube");
exec("C:\zpanel\bin\mysql\bin\mysqldump.exe -u root -p" . $pass . " zpanel_hmail | C:\zpanel\bin\mysql\bin\mysql.exe -u root -p" . $pass . " -D sentora_hmail");
//drop old table
exec("C:\zpanel\bin\mysql\bin\mysql.exe -u root -p" . $pass . " -e \"DROP DATABASE 'zpanel_core';\"");
exec("C:\zpanel\bin\mysql\bin\mysql.exe -u root -p" . $pass . " -e \"DROP DATABASE 'zpanel_roundcube';\"");
exec("C:\zpanel\bin\mysql\bin\mysql.exe -u root -p" . $pass . " -e \"DROP DATABASE 'zpanel_hmail';\"");
exec("C:\zpanel\bin\mysql\bin\mysqldump.exe -u root -p" . $pass . " --all-databases > " . $install_folder . "\all_databases.sql");
if ($install_folder != "C:\zpanel") {
exec("mkdir " . $install_folder . "\hostdata");
exec("move /Y c:\zpanel\hostdata " . $install_folder . "\hostdata");
}
exec("copy C:/zpanel/panel/cnf/db.php " . $install_folder . "\dbbk..php");
//update for sentora 1.0.0 for windows MarkDark version backup database and transfert file
} else if (file_exists($filename2)) {
// here command for update sentora for windows 1.0.0
include 'C:/sentora/panel/cnf/db.php';
// file https://github.com/andykimpe/Sentora-Windows-Upgrade/blob/master/installer/update/update.sql
exec("C:\sentora\bin\mysql\bin\mysql.exe -u root -p" . $pass . " < " . $temp_dir ."\update.sql");
// change database name command based on linux version line 777
// just remove proftpd and postfix et adding hmail 
// https://github.com/sentora/sentora-installers/blob/1.0.3-release/sentora_install.sh
exec("C:\sentora\bin\mysql\bin\mysqldump.exe -u root -p" . $pass . " zpanel_core | C:\sentora\bin\mysql\bin\mysql.exe -u root -p" . $pass . " -D sentora_core");
exec("C:\sentora\bin\mysql\bin\mysqldump.exe -u root -p" . $pass . " zpanel_roundcube | C:\sentora\bin\mysql\bin\mysql.exe -u root -p" . $pass . " -D sentora_roundcube");
exec("C:\sentora\bin\mysql\bin\mysqldump.exe -u root -p" . $pass . " zpanel_hmail | C:\sentora\bin\mysql\bin\mysql.exe -u root -p" . $pass . " -D sentora_hmail");
//drop old database
exec("C:\sentora\bin\mysql\bin\mysql.exe -u root -p" . $pass . " -e \"DROP DATABASE 'zpanel_core';\"");
exec("C:\sentora\bin\mysql\bin\mysql.exe -u root -p" . $pass . " -e \"DROP DATABASE 'zpanel_roundcube';\"");
exec("C:\sentora\bin\mysql\bin\mysql.exe -u root -p" . $pass . " -e \"DROP DATABASE 'zpanel_hmail';\"");
exec("C:\sentora\bin\mysql\bin\mysqldump.exe -u root -p" . $pass . " --all-databases > " . $install_folder . "\all_databases.sql");
if ($install_folder != "C:\sentora") {
exec("mkdir " . $install_folder . "\hostdata");
exec("move /Y c:\sentora\hostdata " . $install_folder . "\hostdata");
}
exec("copy C:/sentora/panel/cnf/db.php " . $install_folder . "\dbbk..php");
}

