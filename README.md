# fail2ban_help
The script uses fail2ban and iptables. It looks at the fail2ban logfile and ways to analyse it using a simple command-line script.

##install
sudo apt-get install -y git
git https://github.com/VeggieVampire/fail2ban_help
cd fail2ban_help
sudo apt-get -y install dnsutils
sudo apt-get -y install fail2ban
./install.sh
