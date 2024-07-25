#!/bin/bash

# Function definitions
Prnt(){ printf $1; }
Slp(){ sleep $1; }
Replace(){ sed "s/$1/$2/g"; }
Devi(){ ./ideviceinfo | grep -w $1 | awk '{printf $NF}'; }
PLutil(){ echo -e $1 >>$2; }

# Define folder to save the downloaded files
DOWNLOAD_FOLDER="./activation_files"

# Create folder if it does not exist
mkdir -p $DOWNLOAD_FOLDER

# Check and install missing dependencies
install_dependencies() {
    DEPENDENCIES=("ideviceactivation" "ideviceinfo" "wget")

    for DEP in "${DEPENDENCIES[@]}"; do
        if ! command -v $DEP &> /dev/null; then
            echo "$DEP could not be found. Installing..."
            # This is a placeholder. The actual installation command depends on your package manager.
            # For example, on Ubuntu, you might use `apt-get install`:
            sudo apt-get install -y libimobiledevice-utils wget
        else
            echo "$DEP is already installed."
        fi
    done
}

# Install dependencies
install_dependencies

# Make ideviceinfo executable
chmod +x ideviceinfo

# Generate activation files
printf "generating activation files ..."; Prnt "."; Slp ".2"; Prnt "."; Slp ".2"; Prnt "."; Slp ".2"; Prnt "."
ideviceactivation activate -d -s "https://gsmadjaa.xyz/public/checkm8.php"
echo "FILES SUCCESSFULLY GENERATED"

# Download Record files
wget -P $DOWNLOAD_FOLDER "https://gsmadjaa.xyz/public/NewActivation/$(Devi UniqueChipID)/activation_record.plist" -O $DOWNLOAD_FOLDER/activation_record.plist
# Download Baseband files
wget -P $DOWNLOAD_FOLDER "https://gsmadjaa.xyz/public/NewActivation/$(Devi UniqueChipID)/com.apple.commcenter.device_specific_nobackup.plist" -O $DOWNLOAD_FOLDER/com.apple.commcenter.device_specific_nobackup.plist
# Download Fairplay files
wget -P $DOWNLOAD_FOLDER "https://gsmadjaa.xyz/public/NewActivation/$(Devi UniqueDeviceID)/IC-Info.sisv" -O $DOWNLOAD_FOLDER/IC-Info.sisv

# Verify ActivationRecord Download
if [[ -f "$DOWNLOAD_FOLDER/activation_record.plist" ]]; then
    echo "Downloaded activation_record.plist successfully."
else
    echo "Failed to download activation_record.plist."
fi

# Verify Baseband Download
if [[ -f "$DOWNLOAD_FOLDER/com.apple.commcenter.device_specific_nobackup.plist" ]]; then
    echo "Downloaded com.apple.commcenter.device_specific_nobackup.plist successfully."
else
    echo "Failed to download com.apple.commcenter.device_specific_nobackup.plist."
fi

# Verify Fairplay Download
if [[ -f "$DOWNLOAD_FOLDER/IC-Info.sisv" ]]; then
    echo "Downloaded IC-Info.sisv successfully."
else
    echo "Failed to download IC-Info.sisv."
fi
