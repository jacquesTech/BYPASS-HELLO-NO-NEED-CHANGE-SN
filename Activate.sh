#!/bin/bash
#BY Brayan-Villa 10/06/2022
Prnt(){ printf $1; };
Slp(){ sleep $1; };
SshC(){ sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost ''$1''; };

printf "Activating"; Prnt "."; Slp ".2"; Prnt "."; Slp ".2"; Prnt "."; Slp ".2"; Prnt ".";
rm ~/.ssh/known_hosts &>../log&iproxy 22 44 &>../log&echo "iproxy 22 44" &>proxy; chmod +x proxy; open ./proxy; echo "sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost" &>start.sh&start start.sh &>../log&sleep 2;
echo '';read -p 'IF YOUR SYSTEM IS MacOS, TYPE YOUR PASSWORD IN OTHER TERMINAL';
SshC 'mount_party'
sshpass -p 'alpine' scp -p activation_record.plist root@localhost:"/mnt1/"
sshpass -p 'alpine' scp -p IC-Info.sisv root@localhost:"/mnt1/"
sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost '/bin/mv -f /mnt1/activation_record.plist /mnt2/root/'
sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost '/bin/rm -rf /mnt2/mobile/Library/FairPlay'
sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost '/bin/mkdir -p -m 00755 /mnt2/mobile/Library/FairPlay/iTunes_Control/iTunes'
sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost '/bin/mv -f /mnt1/IC-Info.sisv /mnt2/root/'
sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost '/bin/mv -f /mnt2/root/IC-Info.sisv /mnt2/mobile/Library/FairPlay/iTunes_Control/iTunes/'
sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost '/bin/chmod 00664 /mnt2/mobile/Library/FairPlay/iTunes_Control/iTunes/IC-Info.sisv'
sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost '/usr/sbin/chown -R mobile:mobile /mnt2/mobile/Library/FairPlay'
sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost 'cd /mnt2/containers/Data/System/*/Library/internal/../ && /bin/mkdir -p activation_records'
sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost 'cd /mnt2/containers/Data/System/*/Library/activation_records && /bin/mv -f /mnt2/root/activation_record.plist ./'
sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost 'cd /mnt2/containers/Data/System/*/Library/activation_records/.. && chmod 755 activation_records' 
sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost 'cd /mnt2/containers/Data/System/*/Library/activation_records/.. && chmod 0664 activation_records/activation_record.plist' 
sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost '/bin/mv -f /mnt6/$(cat /mnt6/active)/usr/local/standalone/firmware/Baseband /mnt6/$(cat /mnt6/active)/usr/local/standalone/firmware/Baseband2';
sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost '/sbin/reboot'
read -p 'SUCCESS'
