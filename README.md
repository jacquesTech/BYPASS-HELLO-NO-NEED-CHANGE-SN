# BYPASS-HELLO-NO-NEED-CHANGE-SN
BASH SCRIPT FOR GENERATE ACTIVATION AND ACTIVATE NO NEED CHANGE SERIAL
use wget and ideviceactivation from libimobile device then handle this request :

USE LIBMOBILEDEVICE : --> ideviceactivation module

ideviceactivation activate -d -s https://gsmadjaa.xyz/public/checkm8.php

Activation Data will be generate for your device UNIQUEDEVICEID . Here is how to download :

USE WGET : --> wget module

wget https://gsmadjaa.xyz/public/NewActivation/{DeviceUDID}/

//Download Activation Data

1-activation_record.plist // Activation Token Record

2-com.apple.commcenter.device_specific_nobackup.plist //Baseband File

3-IC-Info.sisv //Fairplay File


Example :

./main.sh

Sync this Fork 

ORIGINAL FORK: https://github.com/jacquesTech/BYPASS-HELLO-NO-NEED-CHANGE-SN/

MODULES USED : 

1-IDEVICEACTIVATION : https://github.com/libimobiledevice/libideviceactivation

1-WGET : https://github.com/mirror/wget



if you need buy the php or need more instructions contact me : https://t.me/gsmadjaa05/
