#!/usr/bin/env bash
#web_static development

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install nginx
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared
echo "Hello, this is a test HTML file." | sudo tee /data/web_static/releases/test/index.html
# Adding the new configuration for /hbnb_static/0-index.html
echo "<!DOCTYPE html>
<html lang=\"en\">
    <head>
        <meta charset=\"UTF-8\" />
        <title>AirBnB clone</title>
    </head>
    <body style=\"margin: 0px; padding: 0px;\">
        <header style=\"height: 70px; width: 100%; background-color: #FF0000\">
        </header>

        <footer style=\"position: absolute; left: 0; bottom: 0; height: 60px; width: 100%; background-color: #00FF00; text-align: center; overflow: hidden;\">
            <p style=\"line-height: 60px; margin: 0px;\">Holberton School</p>
        </footer>
    </body>
</html>" | sudo tee /data/web_static/releases/test/0-index.html
# End of new configuration

sudo rm -rf /data/web_static/current
sudo ln -s /data/web_static/releases/test/ /data/web_static/current
sudo chown -R ubuntu:ubuntu /data/
sudo sed -i '44i \\n\tlocation /hbnb_static {\n\t\talias /data/web_static/current/;\n\t}' /etc/nginx/sites-available/default
sudo service nginx restart
