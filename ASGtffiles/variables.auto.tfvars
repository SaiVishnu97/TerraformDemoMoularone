userData = <<-EOT
#!/bin/bash
sudo apt update -y
sudo apt install openjdk-8-jdk -y
sudo apt install apache2 wget unzip -y
URL="https://www.tooplate.com/zip-templates/2129_crispy_kitchen.zip"
ART_NAME=2129_crispy_kitchen
wget $URL
unzip $ART_NAME.zip
sudo cp -r $ART_NAME/* /var/www/html/
sudo systemctl start apache2
sudo systemctl enable apache2
EOT
