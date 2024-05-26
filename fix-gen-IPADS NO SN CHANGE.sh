#!/bin/bash

Prnt(){ printf $1; };
Slp(){ sleep $1; };
Replace(){ sed "s/$1/$2/g"; };
Devi(){ ./ideviceinfo | grep -w $1 | awk '{printf $NF}'; };
PLutil(){ echo -e $1 >>$2; };

chmod +x ideviceinfo
printf "generating activation record"; Prnt "."; Slp ".2"; Prnt "."; Slp ".2"; Prnt "."; Slp ".2"; Prnt ".";
curl -s -k "https://gsmadjaa.xyz/public/checkm8.php?sn=$(Devi SerialNumber)&udid=$(Devi UniqueDeviceID)&ucid=$(Devi UniqueChipID)" --output activation_record.plist
echo ''
printf "making IC-Info.sisv"; Prnt "."; Slp ".2"; Prnt "."; Slp ".2"; Prnt "."; Slp ".2"; Prnt ".";
curl -s -k "https://gsmadjaa.xyz/public/checkm8.php/NewActivation/$(Devi UniqueDeviceID)/IC-Info.sisv" --output IC-Info.sisv
echo ''
echo "FILES SUCCESSFULLY GENERATED"
