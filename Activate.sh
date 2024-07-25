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
SshC 'mount' // # mount jailbreak
sshpass -p 'alpine' scp -p ./activation_files/activation_record.plist root@localhost:"/private/var/mobile/"
sshpass -p 'alpine' scp -p ./activation_files/IC-Info.sisv root@localhost:"/private/var/mobile/"
SshC 'mv -f /private/var/mobile/activation_record.plist /private/var/mobile/'
SshC 'rm -rf /private/var/mobile/Library/FairPlay'
SshC 'mkdir -p -m 00755 /private/var/mobile/Library/FairPlay/iTunes_Control/iTunes'
SshC 'mv -f /private/var/mobile/IC-Info.sisv /private/var/mobile/'
SshC 'mv -f /private/var/mobile/IC-Info.sisv /private/var/mobile/Library/FairPlay/iTunes_Control/iTunes/'
SshC 'chmod 00664 /private/var/mobile/Library/FairPlay/iTunes_Control/iTunes/IC-Info.sisv'
SshC '/usr/sbin/chown -R mobile:mobile /private/var/mobile/Library/FairPlay'
SshC 'cd /private/var/containers/Data/System/*/Library/internal/../ && mkdir -p activation_records'
SshC 'cd /private/var/containers/Data/System/*/Library/activation_records && mv -f /private/var/root/activation_record.plist ./'
SshC 'cd /private/var/containers/Data/System/*/Library/activation_records/.. && chmod 755 activation_records'
SshC 'cd /private/var/containers/Data/System/*/Library/activation_records/.. && chmod 0664 activation_records/activation_record.plist'
SshC 'kill 1'

# Confirmation message
read -p 'SUCCESS BYPASSED DEVICE'
