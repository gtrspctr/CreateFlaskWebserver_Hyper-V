# Setting Up Flask with Nginx and Gunicorn on Ubuntu Server

## Introduction
This repository provides a step-by-step guide to set up a Flask web application on a fresh Ubuntu Server. We'll utilize Nginx as a reverse proxy and Gunicorn as the application server to ensure smooth deployment and reliable performance. Whether you're a beginner or an experienced developer, this guide will walk you through the process, allowing you to gain hands-on experience with web server configuration.

## Prerequisites
Before you begin, ensure you have the following:
- A freshly created Ubuntu Server (If you're on Windows and have Hyper-V, you can run [my script here to quickly create an Ubuntu server](https://github.com/gtrspctr/Powershell_CreateUbuntuServer_Hyper-V))
- Basic familiarity with the Ubuntu command line

## Step 1: VM Setup
1. Update and upgrade your Ubuntu server:
   - ```sudo apt update```
   - ```sudo apt -y upgrade```
2. Install necessary packages and enable the firewall:
   - ```sudo apt install net-tools``` (This allows 'ifconfig' which is one way we can get the device's IP)
   - ```sudo ufw allow ssh```
   - ```sudo ufw enable```
   - ```sudo ufw status``` (Used to verify that the firewall is active)

## Step 2: Install Python and Create a Virtual Environment
1. Python 3.x should be installed by default in Ubuntu. To verify:
   - If installed, ```python3``` should return info on the installed Python version, and will open a Python command line. Enter ```quit()``` to exit Python.
2. Install Pip (which lets you install Python libraries):
   - ```sudo apt install -y python3-pip```
3. Install Python virtual environment:
   - ```sudo apt install -y python3-venv```
   - ```mkdir ~/venvs```
4. Create and activate the virtual environment:
   - ```cd ~/venvs/```
   - ```mkdir webserver``` ("webserver" is my example project name. Replace it with the name of your project.)
   - ```python3 -m venv webserver```
   - ```source webserver/bin/activate```
     - Your terminal prompt should now show "(webserver)" at the front, indicating you are in the virtual environment.
     - If you need to leave your virtual environment, enter ```deactivate```

## Step 3: Install Flask and Other Libraries
1. Find the "requirements.txt" file in this repository. Copy the contents or otherwise duplicate it onto your server under ~/venvs/webserver directory.
2. Activate the virtual environment, and install the dependencies:
   - ```source webserver/bin/activate```
   - ```pip install -r /path/to/requirements.txt```

## Step 4: Install Nginx
1. Install Nginx:
   - ```sudo apt update```
   - ```sudo apt install -y nginx```
2. Allow Nginx through the firewall:
   - ```sudo ufw allow 'Nginx HTTP'``` (Adjust this according to your needs, e.g., 'Nginx HTTPS' or 'Nginx Full')
3. Test that Nginx is working by going to http://DEVICE_IP in a browser. (Replace DEVICE_IP with the IP of your ubuntu server.) You should expect to see the default Nginx page.
   
## Step 5: Configure Nginx and Gunicorn
1. Delete the default Nginx site configuration:
   - ```sudo rm /etc/nginx/sites-enabled/default```
2. Create a new site configuration file for your Flask app:
   - ```sudo nano /etc/nginx/sites-enabled/APP_NAME``` # Replace APP_NAME with your app's name
3. Find the "nginx_conf.txt" file in this repository. Copy/paste the configuration data found there into this new APP_NAME file. Save and exit.
4. Edit `nginx.conf` to include your app's server proxy information:
   - ```sudo nano /etc/nginx/nginx.conf```
   - Find the line that says ```include /etc/nginx/sites-enabled/*;``` and replace the * with your APP_NAME.
5. Test if the Nginx configuration syntax is correct:
   - ```sudo nginx -t``` will tell you if the data you entered is valid or not.
6. Reload Nginx to apply the changes:
   - ```sudo nginx -s reload```
7. Test that things are working by going to http://DEVICE_IP in a browser. You should now expect a "502 Bad Gateway" error page.

## Step 6: Create Flask Application
1. Under your project's directory (`~/venvs/webserver`), create the necessary folders for your Flask app:
   - ```mkdir app && cd app```
   - ```mkdir website && cd website```
   - ```mkdir templates```
   - ```mkdir static && cd static```
   - ```mkdir images```
   - ```mkdir scripts```
   - ```cd ..```
   - If you need a database, create an "instance" folder:
     - ```mkdir instance```
2. Navigate back to ~/venvs/webserver. Create the main files for your Flask app:
   - ```touch main.py```
   - ```cd website```
   - ```touch __init__.py views.py```
3. Copy the contents of `main.py`, `__init__.py`, and `views.py` from this repository. Paste them into their respective files on your Ubuntu server.
4. Copy the contents of the HTML files in this repository (under app/website/templates) from this repository. Paste them into your website/templates folder on your Ubuntu server.
5. Once all files are created and your Flask app is coded, test it out:
   - From the ~/venvs/webserver/app directory, ```python3 main.py```
6. In a browser, visit the IP address specified by the terminal after running the previous command.
   - Nginx should automatically pass traffic to port 8000, so you don't need to enter the port name.
   - If you see your HTML page, it's working.

## Step 7: Run Gunicorn
1. To test Gunicorn:
   - ```gunicorn -w 4 -b 0.0.0.0:8000 "main:app"```
   - Visit http://DEVICE_IP:8000 to see if it's working.
2. To run Gunicorn as a daemon (in the background):
   - ```gunicorn -w 4 -b 0.0.0.0:8000 "main:app" --daemon```
   - This will keep the web server up even after disconnecting SSH. However, it will not run automatically after a reboot. To set it up to run on boot, you can follow the instructions in the "Systemd" section of the Gunicorn documentation: [Gunicorn Deployment](https://docs.gunicorn.org/en/latest/deploy.html)

Your website should now be up and running. Simply visit `http://DEVICE_IP` (without the port) in your browser to access it.

## Usage and Customization
This repository contains sample Python code that represents a basic Flask website. Feel free to explore the code, customize the Flask app, and add your own features to match your project requirements. The included `nginx_conf.txt` file provides configuration settings for Nginx, which you can modify as needed.

## License
This project is licensed under the [MIT License](LICENSE).

## Support
This repository is basically just to serve as instructions/practice for myself. I am no expert in Nginx, Gunicorn, or Flask. Or Python or Ubuntu, for that matter. However, if you have basic questions or if you see an issue with the instructions or included code, you can [open an issue](../../issues) on this repository.
