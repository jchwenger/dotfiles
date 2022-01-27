function vpn-ocproxy() {
  read -p "vpn: " vpn
  echo "connecting to $vpn using ocproxy..."
  read -p "username: " username
  read -s -p "password: " password
  echo
  read -p "internal port to ssh into (leave empty for default: 2222): " port
  if [ -z port ]
  then
    port=2222
    listener=11080
  else
    listener=11081
  fi
  read -p "ip to connect to: " ip
  echo $password |\
    sudo openconnect \
    -b \
    -u $username \
    -d \
    --timestamp \
    -v \
    --passwd-on-stdin \
    --script-tun \
    --script \
      "ocproxy -L $port:$ip:22 -D $listener -v -g" $vpn
  echo "you can now connect to the other machine through the vpn like so:"
  echo "ssh -p$port usernameOnOtherMachine@localhost"
}

vpn-ocproxy
