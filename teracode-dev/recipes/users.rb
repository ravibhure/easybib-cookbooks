node[:dev][:users].each do |user|

  home_dir = "/home/#{user}"

  directory "#{home_dir}" do
    mode 0755
    recursive true
    action :create
  end

  group "#{user}" do
    group_name "#{user}"
  end

  user "#{user}" do
    comment "#{user}"
    home "#{home_dir}"
    gid "#{user}"
    shell "/bin/zsh"
  end

  execute "Fix permissions" do
    command "chown -R #{user}:#{user} #{home_dir}"
  end

  directory "#{home_dir}/.ssh" do
    mode 0700
    owner "#{user}"
    group "#{user}"
    action :create
  end

  remote_file "/home/#{user}/.ssh/authorized_keys" do
    source "#{user}-pub.key"
    mode "0600"
    owner "#{user}"
    group "#{user}"
    action :create
  end

end
