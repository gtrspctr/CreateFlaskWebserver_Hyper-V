# CreateFlaskWebserver_Hyper-V
 
DIRECTIONS
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
6. Verify Python is installed, and install pip
   - Check version:
     - ```python3```
   - Install pip:
     - ```sudo apt install -y python3-pip```
7. Upload requirements.txt and install.
   - requirements.txt can be found in this repository.
   - Upload with whatever method. Github, FTP, whatever.
   - ```pip install -r /path/to/requirements.txt```
8. TBD... Install Apache.
9. TBD... Install wsgi.
