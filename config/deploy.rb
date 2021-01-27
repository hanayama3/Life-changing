# production環境、stading環境どちらにも当てはまる設定ファイル

lock "~> 3.15.0"  # capostranoのバージョン

set :application, "Life-changing"  #デプロイするアプリケーション名
set :repo_url, "git@github.com:hanayama3/Life-changing.git"  #どのリポジトリからpullするか指定

# set :branch, 'master' deployするブランチ デフォルトがmasterなのでコメントアウト

set :rbenv_type, :user
set :rbenv_ruby, '2.6.3'

set :deploy_to, "/var/rails/Life-changing"  # deploy先のディレクトリ

# set :linked_files, fetch(:linked_files, []).push("config/master.key")

# gitの管理外のファイルもデプロイするための記述？
# 多分/var/rails/Life-changing/ 以下を指してる
append :linked_files, "config/master.key"
append :linked_dirs, "shared/log", "shared/tmp/pids", "shared/tmp/cache", "shared/tmp/sockets", "shared/public/system"

set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
