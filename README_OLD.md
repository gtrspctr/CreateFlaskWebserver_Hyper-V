# UbuntuWebServer_Nginx_GUnicorn_Flask
This GitHub repository contains step-by-step instructions and sample code to set up a Flask website on a fresh install of Ubuntu Server, utilizing Nginx as a reverse proxy and Gunicorn as the application server. The purpose of this repository is to provide a simple and user-friendly guide for individuals looking to deploy a Flask web application on an Ubuntu server, making it accessible to both beginners and experienced developers.

## Features:
- Detailed instructions for setting up a virtual environment, installing Flask, and managing project dependencies.
- Configuration guidelines to install and configure Nginx as a reverse proxy, allowing seamless communication with the Gunicorn application server.
- Sample Python code that demonstrates a basic Flask website structure, including HTML templates and static assets organization.
- Instructions on running Gunicorn workers and deploying the Flask web application as a daemon for reliable and continuous operation.
- Clear explanations and straightforward commands to streamline the setup process.

## Overview:
1. Ensure you have a freshly created Ubuntu server and follow the VM setup instructions provided in the README.md.
2. Install Flask and other necessary libraries using the provided `requirements.txt`.
3. Set up Nginx and Gunicorn following the instructions below.
4. Create your Flask web application and place it in the appropriate project directory.
5. Test your website and Gunicorn setup to ensure everything is working correctly.

Feel free to explore the code and customize the Flask web application according to your project's requirements. This repository serves as a resource for developers who want to quickly deploy a Flask website with Nginx and Gunicorn on an Ubuntu server.

## Prerequisites
- A freshly created Ubuntu Server
- Basic familiarity with the Ubuntu command line

## Instructions
### VM Setup
1. Have a freshly created Ubuntu server.
2. Install updates:
   - `sudo apt update`
   - `sudo apt -y upgrade`
4. Install packages:
   - `sudo apt install net-tools`
5. Enable the firewall:
   - `sudo ufw allow ssh`
   - `sudo ufw enable`
   - `sudo ufw status`
6. If you are going to use GitHub, create a GitHub directory, but don't clone the repository yet.
   - `mkdir github && cd ./github`
7. Python should be installed by default. Verify, and install pip:
   - Check Python version:
     - `python3`
   - Install pip:
     - `sudo apt install -y python3-pip`
8. Install Python virtual environment.
   - `sudo apt install -y python3-venv`
   - Create a folder for your virtual environments to live: `mkdir venvs && cd venvs`
9. If using GitHub, clone the repository now:
   - Install the GitHub CLI with the following: [GitHub CLI Installation](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)
   - Clone the repository using: `gh repo clone USERNAME/REPOSITORY`
10. Even if not using GitHub, create a folder for your project.
    - So the directories should be like `/home/USER/github/environments/REPOSITORY`
11. Create and activate the project environment:
    - `python3 -m venv REPOSITORY` (I will use 'webserver' as an example)
    - Activate the environment:  `source webserver/bin/activate`
      - You should see "(webserver)" in front of the terminal line, indicating you are working in the environment.
    - Deactivate the environment:  `deactivate`

### Install Flask and Other Libraries
1. Activate the virtual environment, upload `requirements.txt`, and install the dependencies.
   - `requirements.txt` can be found in this repository.
   - Upload it using any method you prefer: GitHub, FTP, etc.
   - `pip install -r /path/to/requirements.txt`

### Install Nginx
1. `sudo apt update`
2. `sudo apt install -y nginx`
3. Add an allow rule to the firewall:
   - `sudo ufw allow 'Nginx HTTP'` or `'Nginx HTTPS'` or `'Nginx Full'`
4. Test that Nginx is working by going to http://IP in a browser. You should see the default Nginx page.

### Configure Nginx and GUnicorn
1. Delete the default site in the `sites-enabled` directory:
   - `sudo rm /etc/nginx/sites-enabled/default`
2. Create a new site in the `sites-enabled` directory:
   - `sudo nano /etc/nginx/sites-enabled/APP_NAME` (Replace APP_NAME with your app's name)
   - Enter the data found in the `nginx_conf.txt` file from this repository.
3. Edit `nginx.conf` to add server proxy info:
   - `sudo nano /etc/nginx/nginx.conf`
   - Towards the bottom where it says `include /etc/ngninx/sites-enabled/*;`, replace the star with your APP_NAME from Step 2.
   - Now it should say `include /etc/ngninx/sites-enabled/APP_NAME;`
4. Test if the syntax is correct:
   - `sudo nginx -t`
5. Reload Nginx:
   - `sudo nginx -s reload`
6. Test that things are working by going to http://IP in a browser. You should now expect a "502 Bad Gateway" error page.

### Create Flask Application
1. Activate the virtual environment.
2. Under `/home/USER/github/environments/webserver`:
   - `mkdir app && cd app`
   - `mkdir website && cd website`
   - `mkdir templates`
     - The `templates` directory will hold all .html files.
   - `mkdir static && cd static`
     - The `static` directory will hold all files that don't change.
   - `mkdir images`
   - `mkdir scripts`
   - `cd ..` (back to `...../webserver/app`)
   - If creating a database, `mkdir instance`
     - The `instance` directory will hold .db file(s)
3. Under the `app` directory, create `main.py`.
4. Under the `app/website` directory, create `__init__.py` and `views.py`. Use the 'app' folder included in this repository as a guide.
5. Create .html files, including a `layout.html` file for creating a template with Jinja. Store those under the `website/templates` folder.
   - The main/home page should be named `index.html`.
6. Once all files are created and a Flask web server is coded, test it out:
   - `python3 main.py`
   - In a browser, go to `http://IP` as dictated by what the terminal says after running the previous command.
   - Nginx should now automatically be passing traffic to port 8000, so you don't need to enter the port number.
   - If you see your HTML page, it's working.

### Run GUnicorn
1. To test Gunicorn:
   - `gunicorn -w 4 -b 0.0.0.0:8000 "main:app"`
   - Go to `http://IP:8000` and see if it's working.
2. To run Gunicorn as a daemon:
   - `gunicorn -w 4 -b 0.0.0.0:8000 "main:app" --daemon`
   - This will keep the web server up even after disconnecting SSH.
   - This will NOT run automatically after a reboot, though. For that, view the "Systemd" section on this website:
     - [Gunicorn Deployment](https://docs.gunicorn.org/en/latest/deploy.html)
3. The website should now be running if you simply go to `http://IP` without the port.

### To Come Later...
Add HTTPS with LetsEncrypt.