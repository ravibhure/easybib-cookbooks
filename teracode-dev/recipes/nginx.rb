node[:dev][:dirs].each { |dir|
  directory "/www/#{dir}/current" do
    mode "0755"
    owner "teracode"
    action :create
    recursive true
  end
}

template "/etc/nginx/sites-enabled/sites.conf" do
  source "vhost.conf.erb"
  mode "0644"
  owner "www-data"
  group "www-data"
end
