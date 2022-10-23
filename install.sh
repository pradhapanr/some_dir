#!/bin/bash
sudo apt-get update

# Installation for React Project
# sudo apt-get install nodejs
# sudo apt install npm
sudo apt-get install wget
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.39.0/install.sh | bash
source ~/.profile
nvm ls-remote
nvm install 16.17.0


sudo apt-get install nginx
npm install react-bootstrap bootstrap

# npm sprint-4/start

# Serving the React Application

# sudo rm /etc/nginx/sites-enabled/default
# Need the actual React file. Need to replace the /react-flask-app.nginx
# sudo ln -s /etc/nginx/sites-available/react-flask-app.nginx /etc/nginx/sites-enabled/react-flask-app.nginx
# sudo systemctl reload nginx

# Installation for the Python Environment 
sudo apt install python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools # Install the packages that will allow you to build the Python Enviroment
sudo apt install python3-venv 

python3 -m venv server/venv
source server/venv/bin/activate

pip install wheel # wheel with the local instance of pip to ensure that your packages will install even if they are missing wheel archives
pip install uwsgi -I --no-cache-dir
pip install flask 
pip install -r server/requirements.txt
# flask run

# cd server 
# Configuring uWSGI and Serving the Flask Application
# uwsgi --socket 0.0.0.0:5000 --protocol=http -w wsgi:app
# cd ..
deactivate

sudo cp -a server/server.service /etc/systemd/system/  # Copy server.server to sysmtem folder
 
sudo systemctl start server  # start the uWSGI service you created and enable it so that it starts at boot
sudo systemctl enable server

sudo systemctl status server # Check status

# sudo rm /etc/nginx/sites-enabled/default
sudo cp -a server/server /etc/nginx/sites-available/server #configure Nginx to pass web requests to that socket using the uwsgi protocol
sudo ln -s /etc/nginx/sites-available/server /etc/nginx/sites-enabled #To enable the Nginx server block configuration you’ve just created, link the file to the sites-enabled directory

sudo nginx -t #test for syntax errors
sudo systemctl restart nginx
