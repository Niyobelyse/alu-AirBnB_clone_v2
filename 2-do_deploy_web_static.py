#!/usr/bin/python3
"""Fabric script that distributes an archive to your web servers"""

from fabric.api import env, put, run
from os.path import exists

# Define your server IP addresses
env.hosts = ['98.81.134.183', '54.227.186.156']
env.user = "ubuntu"
env.key = "~/.ssh/id_rsa"

def do_deploy(archive_path):
    """Distributes an archive to the web servers"""
    if not exists(archive_path):
        return False

    try:
        # Extract the filename and name without extension
        file_name = archive_path.split("/")[-1]
        name = file_name.split(".")[0]
        path_name = "/data/web_static/releases/" + name
        
        # Upload the archive to the /tmp/ directory on the web server
        put(archive_path, "/tmp/")
        
        # Create the directory where the archive will be uncompressed
        run("mkdir -p {}/".format(path_name))
        
        # Uncompress the archive to the folder
        run("tar -xzf /tmp/{} -C {}/".format(file_name, path_name))
        
        # Remove the uploaded archive from the web server
        run("rm /tmp/{}".format(file_name))
        
        # Move the files from the uncompressed folder to the correct location
        run("mv {}/web_static/* {}".format(path_name, path_name))
        run("rm -rf {}/web_static".format(path_name))  # Remove the redundant web_static folder
        
        # Remove the old symbolic link and create a new one
        run("rm -rf /data/web_static/current")
        run("ln -s {}/ /data/web_static/current".format(path_name))
        
        # Ensure the static files are accessible via Nginx
        run("sudo service nginx restart")
        
        return True
    except Exception as e:
        print("Error:", e)
        return False

