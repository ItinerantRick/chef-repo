#!/bin/bash

# install chef server, see http://www.opscode.com/chef/install/ for more info.
wget https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chef-server_11.0.8-1.ubuntu.12.04_amd64.deb
sudo dpkg -i chef-server_11.0.8-1.ubuntu.12.04_amd64.deb
sudo chef-server-ctl reconfigure
floating_ip=`curl http://169.254.169.254/2009-04-04/meta-data/public-ipv4`
echo "nginx['url'] = \"https://$floating_ip\"" | sudo tee /etc/chef-server/chef-server.rb
sudo chef-server-ctl reconfigure
# verify it's running
sudo  chef-server-ctl service-list
sudo  chef-server-ctl status
