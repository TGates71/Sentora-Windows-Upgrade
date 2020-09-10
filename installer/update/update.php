<?php
$install_folder = $argv[1];
$temp_dir = $argv[2];
$temp_phpdir = str_replace("\\", "/", $temp_dir);
$your_full_name = $argv[3];
$your_email = $argv[4];
$your_fqdn = $argv[5];
$password_for_zadmin = $argv[6];
$arch = $argv[7];
$install_phpdir = str_replace("\\", "/", $install_folder);
$install_slash = str_replace("\\", "\\\\", $install_folder);
fwrite(STDOUT, "\r
install folder " . $install_folder . "\r
install php dir " . $install_phpdir . "\r
install slash " . $install_slash . "\r
temp dir " . $temp_dir . "\r
full name " . $your_full_name . "\r
email " . $your_email . "\r
fqdn " . $your_fqdn . "\r
zadmin password " . $password_for_zadmin . "\r
arch " . $arch . " bit\r");
$version = "1.0.3";
include '' . $install_phpdir . '/bk/db.php';
$hostname_db = "localhost";
$username_db = "root";
$password_db = "";
$db = mysql_pconnect($hostname_db, $username_db, $password_db) or trigger_error('Unable to connect to database server.');

// Set MySQL ROOT password to a random password and display to user!
fwrite(STDOUT, "\rConfiguring MySQL 'root' password...\r\r");
$sql = "SET PASSWORD FOR `root`@`localhost`=PASSWORD('" . $pass . "')";
$resault = @mysql_query($sql, $db) or die(mysql_error());
$sql = "FLUSH PRIVILEGES;";
$resault = @mysql_query($sql, $db) or die(mysql_error());

exec("" . $install_folder . "\bin\mysql\bin\mysql.exe -u root -p" . $pass . " < " . $install_folder . "\all_databases.sql");

// Set default MySQL account details etc...
$hostname_db = "localhost";
$username_db = "root";
$password_db = $pass;
$db = mysql_pconnect($hostname_db, $username_db, $password_db) or trigger_error('Unable to connect to database server.');
// Create system.php file for database access:-
$db_settings_file = fopen("" . $install_phpdir . "/panel/cnf/db.php", "w");
fwrite($db_settings_file, "<?php\n");
fwrite($db_settings_file, "/**\n");
fwrite($db_settings_file, " * Database configuration file.\n");
fwrite($db_settings_file, " * @package sentora\n");
fwrite($db_settings_file, " * @subpackage core -> config\n");
fwrite($db_settings_file, " * @author Bobby Allen (ballen@zpanelcp.com)\n");
fwrite($db_settings_file, " * @copyright Sentora Project (http://www.sentora.org/)\n");
fwrite($db_settings_file, " * @link http://www.sentora.org/\n");
fwrite($db_settings_file, " * @license GPL (http://www.gnu.org/licenses/gpl.html)\n");
fwrite($db_settings_file, " */\n");
fwrite($db_settings_file, "\$host = \"localhost\";\n");
fwrite($db_settings_file, "\$dbname = \"sentora_core\";\n");
fwrite($db_settings_file, "\$user = \"root\";\n");
fwrite($db_settings_file, "\$pass = \"" . $password_db . "\";\n");
fwrite($db_settings_file, "?>");
fclose($db_settings_file);
// SQL script executor...

function RunSQL($sqlFileToExecute) {
    $f = fopen($sqlFileToExecute, "r+");
    $sqlFile = fread($f, filesize($sqlFileToExecute));
    $sqlArray = explode(';', $sqlFile);
    foreach ($sqlArray as $stmt) {
        if (strlen($stmt) > 3) {
            $result = mysql_query($stmt);
            if (!$result) {
                $sqlErrorCode = mysql_errno();
                $sqlErrorText = mysql_error();
                $sqlStmt = $stmt;
                break;
            }
        }
    }
}

// Get the 'true' server IP address.

function GetServerIPFromZWS() {
    $response = @file_get_contents('http://api.sentora.org/ip.txt');
    return $response;
}

mysql_select_db('sentora_hmail', $db);
$sqlFileToExecute = "" . $install_phpdir . "/bin/hmailserver/DBScripts/Upgrade5320to5400MySQL.sql";
$res = RunSQL($sqlFileToExecute);

mysql_select_db('sentora_hmail', $db);
$sqlFileToExecute = "" . $install_phpdir . "/bin/hmailserver/DBScripts/Upgrade5400to5500MySQL.sql";
$res = RunSQL($sqlFileToExecute);

mysql_select_db('sentora_hmail', $db);
$sqlFileToExecute = "" . $install_phpdir . "/bin/hmailserver/DBScripts/Upgrade5500to5501MySQL.sql";
$res = RunSQL($sqlFileToExecute);

mysql_select_db('sentora_hmail', $db);
$sqlFileToExecute = "" . $install_phpdir . "/bin/hmailserver/DBScripts/Upgrade5501to5502MySQL.sql";
$res = RunSQL($sqlFileToExecute);

mysql_select_db('sentora_hmail', $db);
$sqlFileToExecute = "" . $install_phpdir . "/bin/hmailserver/DBScripts/Upgrade5502to5600MySQL.sql";
$res = RunSQL($sqlFileToExecute);

mysql_select_db('sentora_hmail', $db);
$sqlFileToExecute = "" . $install_phpdir . "/bin/hmailserver/DBScripts/Upgrade5600to5601MySQL.sql";
$res = RunSQL($sqlFileToExecute);

if ($arch == "64") {
mysql_select_db('sentora_hmail', $db);
$sqlFileToExecute = "" . $install_phpdir . "/bin/hmailserver/DBScripts/Upgrade5601to5700MySQL.sql";
$res = RunSQL($sqlFileToExecute);
}

// Update the current Apache Config to include the new Apache configs as part of the 'config_packs':-
$db_settings_file = fopen("" . $install_phpdir . "/bin/apache/conf/extra/httpd-vhosts.conf", "w");
fwrite($db_settings_file, "# Include the Sentora managed http-vhosts file.\r\n");
fwrite($db_settings_file, "Include " . $install_phpdir . "/configs/apache/httpd-vhosts.conf");
fclose($db_settings_file);
// Ask user what domain they will be hosting the control panel on and then create it and add entries to the hosts file...
$fullname = $your_full_name;
$email = $your_email;
$location = $your_fqdn;

//add service command parameter for permit use reload ,force-reload and restart fonction
$db_settings_file = fopen("" . $install_phpdir . "/bin/cygtools/bin/service.bat", "w");
fwrite($db_settings_file, "@echo off\r\n");
fwrite($db_settings_file, "if %1 equ reload (goto restart)\r\n");
fwrite($db_settings_file, "if %1 equ force-reload (goto restart)\r\n");
fwrite($db_settings_file, "if %1 equ restart (goto restart)\r\n");
fwrite($db_settings_file, "if %1 equ start (goto start)\r\n");
fwrite($db_settings_file, "if %1 equ stop (goto stop)\r\n");
fwrite($db_settings_file, ":restart\r\n");
fwrite($db_settings_file, "net stop %2\r\n");
fwrite($db_settings_file, "net start %2\r\n");
fwrite($db_settings_file, "goto exit\r\n");
fwrite($db_settings_file, ":stop\r\n");
fwrite($db_settings_file, "net stop %2\r\n");
fwrite($db_settings_file, "goto exit\r\n");
fwrite($db_settings_file, ":start\r\n");
fwrite($db_settings_file, "net start %2\r\n");
fwrite($db_settings_file, "goto exit\r\n");
fwrite($db_settings_file, ":exit");
fclose($db_settings_file);

//register zppy
$db_settings_file = fopen("" . $install_phpdir . "/bin/cygtools/bin/zppy.bat", "w");
fwrite($db_settings_file, "@echo off\r\n");
fwrite($db_settings_file, "" . $install_folder . "\bin\php\php.exe " . $install_folder . "\panel\bin\zppy %*");
fclose($db_settings_file);
//register setso
$db_settings_file = fopen("" . $install_phpdir . "/bin/cygtools/bin/setso.bat", "w");
fwrite($db_settings_file, "@echo off\r\n");
fwrite($db_settings_file, "" . $install_folder . "\bin\php\php.exe " . $install_folder . "\panel\bin\setso %*");
fclose($db_settings_file);
//register setzadmin
$db_settings_file = fopen("" . $install_phpdir . "/bin/cygtools/bin/setzadmin.bat", "w");
fwrite($db_settings_file, "@echo off\r\n");
fwrite($db_settings_file, "" . $install_folder . "\bin\php\php.exe " . $install_folder . "\panel\bin\setzadmin %*");
fclose($db_settings_file);


//setso update install directory to database
exec("" . $install_folder . "\bin\cygtools\bin\setso --set dbversion " . $version . "");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set sentora_domain " . $location . "");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set email_from_address " . $email . "");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set daemon_lastrun 0");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set daemon_dayrun 0");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set daemon_weekrun 0");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set daemon_monthrun 0");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set apache_changed true");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set sentora_root " . $install_phpdir . "/panel/");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set root_drive C:/");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set php_exer " . $install_phpdir . "/bin/php/php.exe");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set zip_exe " . $install_phpdir . "/bin/cygtools/bin/zip.exe");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set ftp_php filezilla.php");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set ftp_config_file " . $install_phpdir . "/bin/filezilla/FileZilla Server.xml");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set ftp_service \"Filezilla Server\" ");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set ftp_service_root service");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set ftp_config_file filezilla.php");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set mailserver_db sentora_hmail");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set mailserver_php hmail.php");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set httpd_exe " . $install_phpdir . "/bin/apache/bin/httpd.exe");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set apache_sn apache");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set apache_restart \"-n apache -k restart\"");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set mysqldump_exe " . $install_phpdir . "/bin/mysql/bin/mysqldump.exe");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set named_checkconf " . $install_phpdir . "/bin/bind/bin/named-checkconf.exe");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set named_checkzone " . $install_phpdir . "/bin/bind/bin/named-checkzone.exe");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set named_compilezone " . $install_phpdir . "/bin/bind/bin/named-compilezone.exe");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set temp_dir " . $install_phpdir . "/temp/");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set logfile " . $install_phpdir . "/logs/sentora.log");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set named_dir " . $install_phpdir . "/configs/bind/etc/");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set zone_dir " . $install_phpdir . "/configs/bind/zones/");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set bind_log " . $install_phpdir . "/logs/bind/bind.log");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set hosted_dir " . $install_phpdir . "/hostdata/");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set apache_vhost " . $install_phpdir . "/configs/apache/httpd-vhosts.conf");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set static_dir " . $install_phpdir . "/panel/etc/static/");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set parking_path " . $install_phpdir . "/panel/etc/static/parking/");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set upload_temp_dir " . $install_phpdir . "/temp/");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set openbase_temp " . $install_phpdir . "/temp/");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set log_dir " . $install_phpdir . "/logs/");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set apache_budir " . $install_phpdir . "/backups/");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set zsudo " . $install_phpdir . "/panel/bin/zsudo");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set daemon_exer " . $install_phpdir . "/panel/bin/daemon.php");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set cron_reload_command ");
exec("" . $install_folder . "\bin\cygtools\bin\setso --set server_ip " . GetServerIPFromZWS() . "");
//update cron config
$sql = "UPDATE sentora_core.x_settings SET so_name_vc = 'cron_file' WHERE x_settings.so_id_pk =117;";
$resault = @mysql_query($sql, $db) or die(mysql_error());
$sql = "UPDATE sentora_core.x_settings SET so_cleanname_vc = 'Cron File' WHERE x_settings.so_id_pk =117;";
$resault = @mysql_query($sql, $db) or die(mysql_error());
$sql = "UPDATE sentora_core.x_settings SET so_value_tx = '" . $install_phpdir . "bin/crond/cron.tab' WHERE x_settings.so_id_pk =117;";
$resault = @mysql_query($sql, $db) or die(mysql_error());
$sql = "UPDATE sentora_core.x_settings SET so_desc_tx = 'Path to the user cron file' WHERE x_settings.so_id_pk =117;";
$resault = @mysql_query($sql, $db) or die(mysql_error());
$sql = "UPDATE sentora_core.x_settings SET so_value_tx = '' WHERE x_settings.so_id_pk =116;";
$resault = @mysql_query($sql, $db) or die(mysql_error());
$sql = "DELETE FROM sentora_core.x_settings WHERE x_settings.so_id_pk = 118;";
$resault = @mysql_query($sql, $db) or die(mysql_error());
$sql = "DELETE FROM sentora_core.x_settings WHERE x_settings.so_id_pk = 119;";
$resault = @mysql_query($sql, $db) or die(mysql_error());


@mysql_select_db('sentora_core', $db);
// We now update the MySQL user for the default 'zadmin' account..
$log = "UPDATE x_accounts SET ac_pass_vc='" . md5($password_for_zadmin) . "', ac_email_vc='" . $email . "', ac_created_ts=" . time() . " WHERE ac_user_vc='zadmin'";
$do = @mysql_query($log, $db) or die(mysql_error());

// Now we add the server admin to the server admin database table..
$sql = "UPDATE x_profiles SET ud_created_ts=" . time() . ", ud_fullname_vc='" . $fullname . "' WHERE ud_user_fk=1;";
mysql_query($sql, $db);

// Create db.inc.php for Roundcube webmail:-
$db_settings_file = fopen("" . $install_phpdir . "/panel/etc/apps/webmail/config/db.inc.php", "w");
fwrite($db_settings_file, "<?php\n");
fwrite($db_settings_file, "\$rcmail_config = array();\n");
fwrite($db_settings_file, "\$rcmail_config['db_dsnw'] = 'mysql://root:" . $password_db . "@localhost/sentora_roundcube';\n");
fwrite($db_settings_file, "\$rcmail_config['db_dsnr'] = '';\n");
fwrite($db_settings_file, "\$rcmail_config['db_max_length'] = 512000;\n");
fwrite($db_settings_file, "\$rcmail_config['db_persistent'] = FALSE;\n");
fwrite($db_settings_file, "\$rcmail_config['db_table_users'] = 'users';\n");
fwrite($db_settings_file, "\$rcmail_config['db_table_identities'] = 'identities';\n");
fwrite($db_settings_file, "\$rcmail_config['db_table_contacts'] = 'contacts';\n");
fwrite($db_settings_file, "\$rcmail_config['db_table_session'] = 'session';\n");
fwrite($db_settings_file, "\$rcmail_config['db_table_cache'] = 'cache';\n");
fwrite($db_settings_file, "\$rcmail_config['db_table_messages'] = 'messages';\n");
fwrite($db_settings_file, "\$rcmail_config['db_sequence_users'] = 'user_ids';\n");
fwrite($db_settings_file, "\$rcmail_config['db_sequence_identities'] = 'identity_ids';\n");
fwrite($db_settings_file, "\$rcmail_config['db_sequence_contacts'] = 'contact_ids';\n");
fwrite($db_settings_file, "\$rcmail_config['db_sequence_cache'] = 'cache_ids';\n");
fwrite($db_settings_file, "\$rcmail_config['db_sequence_messages'] = 'message_ids';\n");
fwrite($db_settings_file, "?>");
fclose($db_settings_file);

// Create hMailServer.INI for hMailServer MySQL configuration:-
$db_settings_file = @fopen("" . $install_phpdir . "/bin/hmailserver/Bin/hMailServer.ini", "w");
fwrite($db_settings_file, "\r
################################################################\r
# hMailServer configuration file                               #\r
# Automatically generated by Sentora installer for Windows     #\r
################################################################\r
\r");
fwrite($db_settings_file, "\r\n");
fwrite($db_settings_file, "[Directories]\r\n");
fwrite($db_settings_file, "ProgramFolder=" . $install_folder . "\bin\hmailserver\r\n");
fwrite($db_settings_file, "DataFolder=" . $install_folder . "\bin\hmailserver\Data\r\n");
fwrite($db_settings_file, "LogFolder=" . $install_folder . "\logs\r\n");
fwrite($db_settings_file, "TempFolder=" . $install_folder . "\bin\hmailserver\Temp\r\n");
fwrite($db_settings_file, "EventFolder=" . $install_folder . "\bin\hmailserver\Events\r\n");
fwrite($db_settings_file, "\r\n");
fwrite($db_settings_file, "[GUILanguages]\r\n");
fwrite($db_settings_file, "ValidLanguages=english,swedish\r\n");
fwrite($db_settings_file, "\r\n");
fwrite($db_settings_file, "[Database]\r\n");
fwrite($db_settings_file, "Type=MYSQL\r\n");
fwrite($db_settings_file, "Username=root\r\n");
fwrite($db_settings_file, "Password=" . $password_db . "\r\n");
fwrite($db_settings_file, "PasswordEncryption=0\r\n");
fwrite($db_settings_file, "Port=3306\r\n");
fwrite($db_settings_file, "Server=localhost\r\n");
fwrite($db_settings_file, "Database=sentora_hmail\r\n");
fwrite($db_settings_file, "Internal=0\r\n");
fwrite($db_settings_file, "\r\n");
fwrite($db_settings_file, "[Security]\r\n");
fwrite($db_settings_file, "AdministratorPassword=" . md5($password_for_zadmin) . "\r\n");
fclose($db_settings_file);

fwrite(STDOUT, "\r
################################################################\r
# YOUR SENTORA SERVER LOGIN DETAILS                             #\r
################################################################\r
\r
\r
Your new MySQL 'root' password is: " . $password_db . "\r
\r
Your new Sentora details are as follows:-\r
\r
URL: http://" . $location . "/\r
Username: zadmin\r
Password: " . $password_for_zadmin . "\r
\r
These details can also be found in c:\zpanel\login_details.txt\r
\r
Thank you for installing Sentora!\r\r");
// Add the password details to a file in C:\zpanel
$db_settings_file = fopen("" . $install_phpdir . "/login_details.txt", "w");
fwrite($db_settings_file, "MySQL Root Password: " .$password_db. "\r\n");
fwrite($db_settings_file, "Sentora URL: http://" .$location. "\r\n");
fwrite($db_settings_file, "Sentora account: zadmin\r\n");
fwrite($db_settings_file, "Sentora and HmailAdmin password: " . $password_for_zadmin . "");
fclose($db_settings_file);
?>
