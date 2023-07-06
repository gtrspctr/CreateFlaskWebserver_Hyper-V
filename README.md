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
6. Install and sign into Github
   - ```mkdir github && cd ./github```
   - Install with the following:  https://github.com/cli/cli/blob/trunk/docs/install_linux.md
   - Install repo using:  ```gh repo clone USERNAME/REPOSITORY```
7. Python should be installed by default. Verify, and install pip:
   - Check Python version:
     - ```python3```
   - Install pip:
     - ```sudo apt install -y python3-pip```
8. Upload requirements.txt and install.
   - requirements.txt can be found in this repository.
   - Upload with whatever method. Github, FTP, whatever.
   - ```pip install -r /path/to/requirements.txt```
9. Install and configure virtual environment.
   - ```sudo apt install python3-venv```
   - Create folder for your environments to live:  ```mkdir environments && cd environments```
   - Create project environment:  ```python3 -m venv webserver```
   - Enter/activate environment:  ```source webserver/bin/activate```
     - You should see "(webserver)" in front of the terminal line, indicating you are working in the environment.

### Install Nginx
1. ```sudo apt install -y....``` to come later
2. /etc/nginx/nginx.conf add proxy pass stuff
   - https://www.youtube.com/watch?v=BpcK5jON6Cg
3. get rid of default sites

### Install GUnicorn
1. pip3 install ..... to come later

LATER....
1. Install wsgi / gunicorn