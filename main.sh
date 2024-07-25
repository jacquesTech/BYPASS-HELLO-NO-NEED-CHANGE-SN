#!/bin/bash

# Run generate.sh
echo "Running generate.sh..."
./GenerateFiles.sh

# Check if GenerateFiles.sh ran successfully
if [ $? -ne 0 ]; then
    echo "GenerateFiles.sh encountered an error. Exiting."
    exit 1
fi

# Run Activate.sh
echo "Running activate.sh..."
./Activate.sh

# Check if activate.sh ran successfully
if [ $? -ne 0 ]; then
    echo "activate.sh encountered an error. Exiting."
    exit 1
fi

# Display thank you message
echo "Thanks for Using GSM ADJAA ISHELL ACTIVATOR"
