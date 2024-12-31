#!/bin/bash

# Set Tomcat version
TOMCAT_VERSION=9.0.73
TOMCAT_DIR="/opt/tomcat"

# Download Tomcat package
wget https://downloads.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -P /tmp

# Extract Tomcat
sudo mkdir -p ${TOMCAT_DIR}
sudo tar -xf /tmp/apache-tomcat-${TOMCAT_VERSION}.tar.gz -C ${TOMCAT_DIR} --strip-components=1

# Set permissions
sudo chmod -R 755 ${TOMCAT_DIR}
sudo chown -R www-data:www-data ${TOMCAT_DIR}

# Create a systemd service file for Tomcat
sudo tee /etc/systemd/system/tomcat.service > /dev/null <<EOF
[Unit]
Description=Apache Tomcat
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
Environment=CATALINA_PID=${TOMCAT_DIR}/temp/tomcat.pid
Environment=CATALINA_HOME=${TOMCAT_DIR}
Environment=CATALINA_BASE=${TOMCAT_DIR}

ExecStart=${TOMCAT_DIR}/bin/startup.sh
ExecStop=${TOMCAT_DIR}/bin/shutdown.sh

User=www-data
Group=www-data

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start Tomcat
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat

echo "Tomcat installed and started successfully."

