cd /vagrant/config-dir
bash local-dns-hosts.sh
sudo apt-get update && sudo apt-get install -y curl vim python-pip
sudo pip install -U pip
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get install -y git
bash install-puppetserver.sh
sudo apt-get update && sudo apt-get -y upgrade
