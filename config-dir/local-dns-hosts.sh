host_ip=$(cat<<!
10.0.15.10|mgmt.example.com|mgmt|puppet
10.0.15.21|node1.example.com|node1|
10.0.15.22|node2.example.com|node2|
!
)
for nameip in $host_ip;do
  ip=$(echo $nameip | awk -F\| '{print $1}')
  full=$(echo $nameip | awk -F\| '{print $2}')
  short=$(echo $nameip | awk -F\| '{print $3}')
  puppet=$(echo $nameip | awk -F\| '{print $4}')
  grep -q $ip /etc/hosts
  if [ $? -ne 0 ];then
    sudo echo "$ip	$full	$short	$puppet" >> /etc/hosts
  fi
done
