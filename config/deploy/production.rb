set :rails_env, 'production'

# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
            keys: ['~/.ssh/hanayama_key_rsa']  #記述の仕方がおかしい？

#EC2が2台構成の場合は2つ記述すれば2台にデプロイできる？
# roles my_property　ってなんだ？
server "52.196.77.54", user: "hanayama", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}

# プロセス番号を記載したファイルの場所
 set :unicorn_pid, -> { "/var/rails/Life-changing/shared/tmp/pids/unicorn.pid" } #参照しに行く
 # set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" } #{shared_path} 本番サーバー /var/rails/sharedを参照 

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "/var/rails/Life-changing/current/config/unicorn.conf.rb" } #参照しに行く
# set :unicorn_config_path, -> { "#{current_path}/config/unicorn.conf.rb" }

# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/user_name/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }
