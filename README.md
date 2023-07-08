# CreateFlaskWebserver_Hyper-V
 
### VM Setup
1. Run .ps1 file.
2. Once VM is booted, go through setup.
3. Install updates:
   - ```sudo apt update```
   - ```sudo apt -y upgrade```
4. Install packages:
   - ```sudo apt install net-tools```
5. Enable firewall:
   - ```sudo ufw allow ssh```
   - ```sudo ufw enable```
   - ```sudo ufw status```
6. If you are going to use github, create github directory, but don't clone repo yet.
   - ```mkdir github && cd ./github```
7. Python should be installed by default. Verify, and install pip:
   - Check Python version:
     - ```python3```
   - Install pip:
     - ```sudo apt install -y python3-pip```
8. Install Python virtual environment.
   - ```sudo apt install -y python3-venv```
   - Create folder for your environments to live:  ```mkdir environments && cd environments```
9. If using github, clone repository now:
   - Install with the following:  https://github.com/cli/cli/blob/trunk/docs/install_linux.md
   - Clonerepo using:  ```gh repo clone USERNAME/REPOSITORY```
10. Even if not using github, create a folder for your project.
    - So the directories should be like /home/USER/github/environments/REPOSITORY
11. Create and activate project environment:
    - ```python3 -m venv REPOSITORY``` (I will use 'webserver' as an example)
    - Activate environment:  ```source webserver/bin/activate```
      - You should see "(webserver)" in front of the terminal line, indicating you are working in the environment.
    - Deactivate environment:  ```deactivate```

### Install Flask and other libraries
1. Activate virtual environment, upload requirements.txt and install.
   - requirements.txt can be found in this repository.
   - Upload with whatever method. Github, FTP, whatever.
   - ```pip install -r /path/to/requirements.txt```

### Install Nginx
1. ```sudo apt update```
2. ```sudo apt install -y nginx```
3. Add allow rule to firewall:
   - ```sudo ufw allow 'Nginx HTTP'``` or ```'Nginx HTTPS'``` or ```'Nginx Full'```
4. Test that Nginx is working by going the http://IP in a browser. We expect a default Nginx page.

### Configure Nginx and GUnicorn
1. Delete default site in sites-enabled directory:
   - ```sudo rm /etc/nginx/sites-enabled/default```
2. Create new site in sites-enabled directory:
   - ```sudo nano /etc/nginx/sites-enabled/APP_NAME```
   - Enter the data found in this repository: nginx_conf.txt
3. Edit nginx.conf to add server proxy info:
   - ```sudo nano /etc/nginx/nginx.conf```
   - Towards the bottom where it says ```include /etc/ngninx/sites-enabled/*;```, repace the star with your APP_NAME from step 2.
   - Now it should say ```include /etc/ngninx/sites-enabled/APP_NAME;```
4. Test if syntax is correct:
   - ```sudo nginx -t```
5. Reload nginx:
   - ```sudo nginx -s reload```
6. Test that things are working by going to http://IP in a browser. We now expect a 502 Bad Gateway error page.

### Create Flask Application
1. Activate virtual environment.
2. Under /home/USER/github/environments/webserver:
   - ```mkdir app && cd app```
   - ```mkdir website && cd website```
   - ```mkdir templates```
     - The templates directory will hold all .html files.
   - ```mkdir static && cd static```
     - The static directory will hold all files that don't change.
   - ```mkdir images```
   - ```mkdir scripts```
   - ```cd``` back to ...../webserver/app 
   - If creating database, ```mkdir instance```
     - The instance directory will hold .db file(s)
3. Under app directory, create main.py.
4. Under app/website directory, create __init__.py and views.py. Use the 'app' folder included in this repository as a guide.
5. Create .html files, including a layout.html file for creating a template with Jinja. Store those under the website/templates folder.
   - Main/home page should be named index.html.
6. Once all files are created and a Flask webserver coded, test it out:
   - ```python3 main.py```
   - In a browser, go to http://ip as dictated by what the terminal says after running the previous command.
   - Nginx should now automatically be passing traffic to port 8000, so you don't need to enter the port name.
   - If you see your html page, it's working.

### Run GUnicorn
1. To test gunicorn:
   - ```gunicorn -w 4 -b 0.0.0.0:8000 "main:app"```
   - Go to http://IP:8000 and see if it's working.
2. To run gunicorn as a daemon:
   - ```gunicorn -w 4 -b 0.0.0.0:8000 "main:app" --daemon```
   - This will keep the webserver up even after disconnecting SSH.
   - This will NOT run automatically after a reboot though. For that, view the "Systemd" section on this website:
     - https://docs.gunicorn.org/en/latest/deploy.html
3. The website should now be running if you simply go to http://IP without the port.


### To Come Later...
Add HTTPS with LetsEncrypt.