#!/bin/bash

# Function definitions
Prnt(){ printf $1; }
Slp(){ sleep $1; }
SshC(){ sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost "$1"; }

# Function to check and install missing dependencies
install_dependencies() {
    DEPENDENCIES=("sshpass" "iproxy" "ssh")

    for DEP in "${DEPENDENCIES[@]}"; do
        if ! command -v $DEP &> /dev/null; then
            echo "$DEP could not be found. Installing..."
            # This is a placeholder. The actual installation command depends on your package manager.
            # For example, on Ubuntu, you might use `apt-get install`:
            sudo apt-get install -y $DEP
        else
            echo "$DEP is already installed."
        fi
    done
}

# Install dependencies
install_dependencies

# Main script execution
printf "Activating"; Prnt "."; Slp ".2"; Prnt "."; Slp ".2"; Prnt "."; Slp ".2"; Prnt "."

# Remove known hosts to avoid SSH issues
rm ~/.ssh/known_hosts &>../log

# Start iproxy
iproxy 22 44 &>../log &

# Create and open proxy script
echo "iproxy 22 44" &> proxy
chmod +x proxy
open ./proxy

# Create and start SSH script
echo "sshpass -p 'alpine' ssh -o StrictHostKeyChecking=no root@localhost" &> start.sh
chmod +x start.sh
./start.sh &>../log &
sleep 2

# Prompt for password on MacOS
echo ''
read -p 'IF YOUR SYSTEM IS MacOS, TYPE YOUR PASSWORD IN OTHER TERMINAL'

# Execute commands on the remote device
SshC 'mount_party' // # mount ramdisk
SshC 'mount' // # mount jailbreak
sshpass -p 'alpine' scp -p ./activation_files/activation_record.plist root@localhost:"/mnt1/"
sshpass -p 'alpine' scp -p ./activation_files/IC-Info.sisv root@localhost:"/mnt1/"
SshC '/bin/mv -f /mnt1/activation_record.plist /mnt2/root/'
SshC '/bin/rm -rf /mnt2/mobile/Library/FairPlay'
SshC '/bin/mkdir -p -m 00755 /mnt2/mobile/Library/FairPlay/iTunes_Control/iTunes'
SshC '/bin/mv -f /mnt1/IC-Info.sisv /mnt2/root/'
SshC '/bin/mv -f /mnt2/root/IC-Info.sisv /mnt2/mobile/Library/FairPlay/iTunes_Control/iTunes/'
SshC '/bin/chmod 00664 /mnt2/mobile/Library/FairPlay/iTunes_Control/iTunes/IC-Info.sisv'
SshC '/usr/sbin/chown -R mobile:mobile /mnt2/mobile/Library/FairPlay'
SshC 'cd /mnt2/containers/Data/System/*/Library/internal/../ && /bin/mkdir -p activation_records'
SshC 'cd /mnt2/containers/Data/System/*/Library/activation_records && /bin/mv -f /mnt2/root/activation_record.plist ./'
SshC 'cd /mnt2/containers/Data/System/*/Library/activation_records/.. && chmod 755 activation_records'
SshC 'cd /mnt2/containers/Data/System/*/Library/activation_records/.. && chmod 0664 activation_records/activation_record.plist'
SshC '/bin/mv -f /mnt6/$(cat /mnt6/active)/usr/local/standalone/firmware/Baseband /mnt6/$(cat /mnt6/active)/usr/local/standalone/firmware/Baseband2'
SshC '/sbin/reboot'

# Confirmation message
read -p 'SUCCESS BYPASSED DEVICE'
