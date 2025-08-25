lock '3.19.2'

# Capistranoのログの表示に利用する
set :application, 'furima-46253'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:Ri9mochi/furima-46253.git'
set :branch, 'main'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '3.2.0'

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                                  keys: ['~/.ssh/my-key-pair.pem'] 

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

set :default_env, {
'BUNDLE_FORCE_RUBY_PLATFORM' => 'true',
'BUNDLE_BUILD__MYSQL2' => '--with-mysql-config=/usr/bin/mysql_config --with-openssl-dir=/usr/lib64/openssl11'
}


# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

