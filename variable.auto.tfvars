userData = <<-EOT
#!/bin/bash
sudo apt update -y
sudo apt install openjdk-8-jdk -y
sudo apt install apache2 wget unzip -y
URL="https://www.tooplate.com/zip-templates/2129_crispy_kitchen.zip"
ART_NAME=2129_crispy_kitchen
wget $URL
unzip $ART_NAME.zip
echo "<h2> This from $HOSTNAME </h2>" >> $ART_NAME/index.html
sudo cp -r $ART_NAME/* /var/www/html/
sudo systemctl start apache2
sudo systemctl enable apache2
EOT


