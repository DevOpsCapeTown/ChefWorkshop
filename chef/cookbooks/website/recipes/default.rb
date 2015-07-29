#
# Cookbook Name:: website
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apache2'

# Let's create our website
directory '/var/www/html' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

cookbook_file '/var/www/html/index.html' do
  source 'index.html'
  mode '0644'
  action :create
end

# Now we create the template
#template '/etc/apache2/sites-available/my_website.conf' do
#  source 'my_website.conf.erb'
#  owner 'root'
#  group 'root'
#  mode '0644'
#end

web_app 'my_website' do
   template 'my_website.conf.erb'
   application_name node['my_website']['app_name']
   server_name node['my_website']['hostname']
   doc_root node['my_website']['docroot']
end

