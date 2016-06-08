package 'libsqlite3-dev' do
  package_name value_for_platform(
    %w(centos redhatt suse fedora) => { 'default' => 'sqlite-devel' },
    'default' => 'libsqlite3-dev'
  )
end
