#!/bin/bash

# assign variables

function install_nginx() {
sudo yum update -y
sudo amazon-linux-extras install nginx1.12 -y
sudo systemctl enable nginx.service
sudo aws s3 cp s3://palj9691-assignment-3/index.html /usr/share/nginx/html/index.html
sudo systemctl start nginx.service
}

function remove_files() {
sudo systemctl stop nginx.service
sudo rm /usr/share/nginx/html/*
sudo yum remove nginx
}

function display_version() {
version=1.0.0
echo $version
}

function display_help() {
cat << EOF
Usage: ${0} {-r|--remove|-v|--version|-h|--help} <filename>

OPTIONS:
        -r | --remove   Stop Nginx service. Delete related files and uninstall software package
        -v | --version  Display version of file
        -h | --help     Display the command help

Examples:
        Uninstall Nginx:
                $ ${0} -r

        Display  version of the file:
                $ ${0} -v

        Display help:
                $ ${0} -h

EOF
}

if [ -z $1 ]
then
        install_nginx
        echo "Nginx install complete."
else
        ACTION=${1}
fi

case "$ACTION" in
        -r| --remove)
                remove_files
                ;;
        -v| --version)
                display_version
                ;;
        -h| --help)
                display_help
                ;;
        *)
        echo "Usage ${0} {-r} {-v} {-h}"
        exit 1
esac
