sudo apt-get -y install dnsutils
sudo apt-get -y install fail2ban
echo .
echo .
dpkg --get-selections | grep dnsutils
dpkg --get-selections | grep fail2ban
