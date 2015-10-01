<?php

/**
 * @copyright 2014-2015 Sentora Project (http://www.sentora.org/) 
 * Sentora is a GPL fork of the ZPanel Project whose original header follows:
 *
 * Generic template place holder class.
 * @package zpanelx
 * @subpackage dryden -> ui -> tpl
 * @version 1.0.0
 * @author Bobby Allen (ballen@bobbyallen.me)
 * @copyright Sentora Project (http://www.sentora.org/)
 * @link http://www.sentora.org/
 * @license GPL (http://www.gnu.org/licenses/gpl.html)
 */
class ui_tpl_totalftp {

    public static function Template() {
        $currentuser = ctrl_users::GetUserDetail();
        $ftpaccountsquota = $currentuser['ftpaccountsquota'];
        if ($ftpaccountsquota < 0)
            return '&#8734;';
        else
            return $ftpaccountsquota;
    }

}

?>
