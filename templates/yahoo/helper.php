<?php

/**
 * getClientMac
 * Gets the mac address of a client by the IP address
 * Returns the mac address as a string
 * @param $clientIP : The clients IP address
 * @return string
 */
function getClientMac($clientIP)
{
    return trim(exec("grep " . escapeshellarg($clientIP) . " /tmp/dhcp.leases | awk '{print $2}'"));
}

/**
 * getClientSSID
 * Gets the SSID a client is associated by the IP address
 * Returns the SSID as a string
 * @param $clientIP : The clients IP address
 * @return string
 */
function getClientSSID($clientIP)
{
    // Get the clients mac address. We need this to get the SSID
    $mac = getClientMac($clientIP);

    // get the path to the log file
    $pineAPLogPath = trim(file_get_contents('/etc/pineapple/pineap_log_location'));

    // get the ssid
    return trim(exec("grep " . $mac . " " . $pineAPLogPath . "pineap.log | grep 'Association' | awk -F ',' '{print $4}'"));

}

/**
 * getClientHostName
 * Gets the host name of the connected client by the IP address
 * Returns the host name as a string
 * @param $clientIP : The clients IP address
 * @return string
 */
function getClientHostName($clientIP)
{
    return trim(exec("grep " . escapeshellarg($clientIP) . " /tmp/dhcp.leases | awk '{print $4}'"));
}