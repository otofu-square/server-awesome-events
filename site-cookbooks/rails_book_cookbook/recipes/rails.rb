%w{build-essential curl zlib1g-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev sqlite3 libsqlite3-dev nodejs make gcc ncurses-dev libgdbm-dev libffi-dev tk-dev libssl-dev libreadline-dev}.each do |pkg|
  package pkg do
    action :install
  end
end

git "/home/ops/.rbenv" do
  repository "git://github.com/sstephenson/rbenv.git"
  reference "master"
  action :sync
  user "ops"
  group "ops"
end

%w{/home/ops/.rbenv/plugins}.each do |dir|
  directory dir do
    action :create
    user "ops"
    group "ops"
  end
end

git "/home/ops/.rbenv/plugins/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
  reference "master"
  action :sync
  user "ops"
  group "ops"
end

bash "insert_line_rbenvpath" do
  environment "HOME" => '/home/ops'
  code <<-EOS
    echo 'export PATH="/home/ops/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    chmod 777 ~/.bashrc
    source ~/.bashrc
  EOS
end

bash "install ruby" do
  user "ops"
  group "ops"
  environment "HOME" => '/home/ops'
  code <<-EOS
    /home/ops/.rbenv/bin/rbenv install 2.3.1
    /home/ops/.rbenv/bin/rbenv rehash
    /home/ops/.rbenv/bin/rbenv global 2.3.1
  EOS
end
