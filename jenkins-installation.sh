# /bin/bash
# LTS release
# for linux
ossoftware=`awk -F \" '/^NAME/ {print $2}' /etc/os-release`
case $ossoftware in
    Ubuntu | Debian)
        sudo apt-get update 
        sudo apt-get install openjdk-11-jdk -y
        wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
        sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
        /etc/apt/sources.list.d/jenkins.list'
        sudo apt-get update
        sudo apt-get install jenkins -y
        sudo systemctl start jenkins
        sudo systemctl status jenkins
        ;;
    Fedora)
        sudo dnf update
        sudo dnf install java-1.8.0-openjdk.x86_64 -y
        sudo wget -O /etc/yum.repos.d/jenkins.repo \
        https://pkg.jenkins.io/redhat-stable/jenkins.repo
        sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
        sudo dnf upgrade -y
        # Add required dependencies for the jenkins package
        sudo dnf install chkconfig java-devel -y
        sudo dnf install jenkins -y
        sudo systemctl start jenkins
        sudo systemctl status jenkins
        ;;
    'Red Hat Enterprise Linux'| 'CentOS Linux'| 'Amazon Linux')
        sudo yum update 
        sudo yum install wget java-1.8.0-openjdk -y
        sudo wget -O /etc/yum.repos.d/jenkins.repo \
        https://pkg.jenkins.io/redhat-stable/jenkins.repo
        sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
        sudo yum upgrade -y
        sudo yum install epel-release java-11-openjdk-devel -y
        sudo yum install jenkins -y 
        sudo systemctl daemon-reload
        sudo systemctl start jenkins
        sudo systemctl status jenkins
        ;;
    *)
        echo "os is not matched the os may be different"
        ;;
esac 