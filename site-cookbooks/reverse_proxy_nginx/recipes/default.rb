directory "/var/cache/nginx" do
  owner "www-data"
  group "www-data"
  mode 00644
  action :create
end

directory "/var/cache/nginx/tmp" do
  owner "www-data"
  group "www-data"
  mode 00644
  action :create
end

application_name = node.app.name

template_variables = {
  application_name: application_name,
  application_domain: node.app.domain,
  application_root: node.app.root,
  application_current_path: "#{node.app.root}/current",
  application_shared_path: "#{node.app.root}/shared"
}

template "/etc/nginx/nginx.conf" do
  source 'nginx.conf.erb'

  variables template_variables

  notifies :restart, resources(service: 'nginx')
end

template "/etc/nginx/sites-include/#{application_name}.conf" do
  source 'app_nginx_include.conf.erb'

  variables template_variables

  notifies :reload, resources(service: 'nginx')
end

template "/etc/nginx/sites-available/#{application_name}.conf" do
  source 'app_nginx.conf.erb'

  variables template_variables

  notifies :reload, resources(service: 'nginx')
end

nginx_site application_name do
  action :enable
end
