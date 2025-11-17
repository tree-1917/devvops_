# Create scripts directory 
sudo mkdir -p /opt/scripts

# Move updaterCluster Script to Target Path 
sudo cp ./updaterCluster.sh /opt/scripts

# make script execuatable 
sudo chmod +x /opt/scripts/updaterCluster.sh

# Move Systemd service file 
sudo cp ./updaterCluster.service /etc/systemd/system

# Reload systemd 
sudo systemctl daemon-reload
