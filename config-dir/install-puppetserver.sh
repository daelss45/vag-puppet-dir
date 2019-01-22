source /etc/lsb-release
puppet_url='https://apt.puppetlabs.com/puppet5-release-'${DISTRIB_CODENAME}.deb
puppet_deb='puppet5-release-'${DISTRIB_CODENAME}.deb
node=$(hostname -s)
if [ ! -f $puppet_deb ];then
  curl -o $puppet_deb $puppet_url
fi
sudo apt-get update && sudo dpkg -i $puppet_deb
if [[ $node =~ 'mgmt' ]];then
    sudo apt-get update && sudo apt-get install -y puppetserver
    sudo sed -i 's/2g/512m/g' /etc/default/puppetserver
    sudo mkdir -p /etc/puppetlabs/r10k
    sudo systemctl enable puppetserver && sudo systemctl start puppetserver
    sudo /opt/puppetlabs/puppet/bin/gem install gpgme --no-rdoc --no-ri
    sudo /opt/puppetlabs/puppet/bin/gem install hiera-eyaml-gpg --no-rdoc --no-ri
    sudo /opt/puppetlabs/puppet/bin/gem install r10k --no-rdoc --no-ri
    sudo cat <<!
---
:cachedir: '/var/cache/r10k'
:sources:
  :my-org:
    remote: 'https://github.com/daelss45/vag-puppet-repo.git'
    basedir: '/etc/puppetlabs/code/environments'
!
else
    sudo apt-get update && sudo apt-get install -y puppet-agent
    sudo systemctl start puppet
    sudo systemctl enable puppet
fi
sudo echo 'Defaults        secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/opt/puppetlabs/bin:/opt/puppetlabs/puppet/bin"' >/etc/sudoers.d/puppet
