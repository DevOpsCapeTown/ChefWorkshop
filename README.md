```
dpkg -i /chef/chef-server-core_12.1.2-1_amd64.deb
chef-server-ctl reconfigure
# chef-server-ctl user-create user_name first_name last_name email password --filename FILE_NAME
chef-server-ctl user-create admin Admin Devops admin@devops.com secretpassword --filename admin.pem
# chef-server-ctl org-create short_name "full_organization_name" --association_user user_name --filename ORGANIZATION-validator.pem
chef-server-ctl org-create devops "DevOps, Inc." --association_user admin -f devops-validator.pem

cat > knife.rb << EOF
current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "admin"
client_key               "admin.pem"
validation_client_name   "devops-validator"
validation_key           "devops-validator.pem"
chef_server_url          "https://172.17.8.101/organizations/devops"
syntax_check_cache_path  "#{ENV['HOME']}/.chef/syntaxcache"
cookbook_path            ["/chef/cookbooks"]
EOF

# Show a user
knife user list
knife cookbook upload apache2
knife cookbook upload website

knife role from file /chef/roles/website.rb

knife bootstrap 172.17.8.102 -N webserver01 -x vagrant -P vagrant --sudo -r website
```
