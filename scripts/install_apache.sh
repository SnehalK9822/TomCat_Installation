#!/bin/bash

# Update the package list
sudo apt-get update -y

# Install Apache HTTP Server
sudo apt-get install apache2 -y

# Enable and start Apache service
sudo systemctl enable apache2
sudo systemctl start apache2

echo "Apache HTTP Server installed successfully."

