# production環境、stading環境どちらにも当てはまる設定ファイル

lock "~> 3.15.0"  # capostranoのバージョン

set :application, "Habit-is-power"  #デプロイするアプリケーション名
set :repo_url, "git@github.com:hanayama3/Habit-is-power.git"

# set :branch, 'master' deployするブランチ デフォルトがmasterなのでコメントアウト

set :rbenv_type, :user
set :rbenv_ruby, '2.6.3'

set :deploy_to, "/var/rails/Habit-is-power"  # deploy先のディレクトリ

append :linked_files, "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/storage"

set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
