# CreateFlaskWebserver_Hyper-V
 
### VM Setup
1. Run .ps1 file.
2. Once VM is booted, go through setup.
3. Install updates:
   - ```sudo apt update```
   - ```sudo apt -y upgrade```
4. Install packages:
   - ```sudo apt install net-tools```
5. Install and sign into Github
   - ```mkdir github && cd ./github```
   - Install with the following:  https://github.com/cli/cli/blob/trunk/docs/install_linux.md
   - Install repo using:  ```gh repo clone USERNAME/REPOSITORY```
6. Python should be installed by default. Verify, and install pip:
   - Check Python version:
     - ```python3```
   - Install pip:
     - ```sudo apt install -y python3-pip```
7. Upload requirements.txt and install.
   - requirements.txt can be found in this repository.
   - Upload with whatever method. Github, FTP, whatever.
   - ```pip install -r /path/to/requirements.txt```
8. Install and configure virtual environment.
   - ```sudo apt install python3-venv```
   - Create folder for your environments to live:  ```mkdir environments && cd environments```
   - Create project environment:  ```python3 -m venv webserver```
   - Enter/activate environment:  ```source webserver/bin/activate```
     - You should see "(webserver)" in front of the terminal line, indicating you are working in the environment.

### Install Apache

1. Allow Apache through firewall.
   - Check available apps:
     - ```sudo ufw app list```
   - Allow:
     - ```sudo ufw allow 'Apache'```
   - Verify Apache is running:
     - ```sudo systemctl status apache2```
   -

LATER....
1. Install Apache
2. Install wsgi