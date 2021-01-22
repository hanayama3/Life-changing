# production環境、stading環境どちらにも当てはまる設定ファイル

lock "~> 3.15.0"  # capostranoのバージョン

set :application, "Life-changing"  #デプロイするアプリケーション名
set :repo_url, "git@github.com:hanayama3/Life-changing.git"  #どのリポジトリからpullするか指定

# set :branch, 'master' deployするブランチ デフォルトがmasterなのでコメントアウト

set :rbenv_type, :user
set :rbenv_ruby, '2.6.3'

set :deploy_to, "/var/www/rails/Life-changing"  # deploy先のディレクトリ

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/hanayama_key_rsa']  #hanayama_key_rsa.pub?

# 本番環境でしかunicornは使ってないからproduction.rbに記述？
# プロセス番号を記載したファイルの場所
# set :unicorn_pid, -> { "/var/www/rails/Life-changing/tmp/pids/unicorn.pid" }
# set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" } #{shared_path} こっちでもいい？

# Unicornの設定ファイルの場所
# set :unicorn_config_path, -> { "/var/www/rails/Life-changing/config/unicorn.conf.rb" }
# set :unicorn_config_path, -> { "#{current_path}/config/unicorn.conf.rb" }  こっちでもいい？


# gitの管理外のファイルもデプロイするための記述？
#append :linked_files, "config/master.key"
#append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

#デプロイと同時にcd:migrateなどをするにはここに追加で記述する必要がある？
