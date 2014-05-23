# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'White'
set :repo_url, 'git@github.com:korny/firsthaibane.git'

# use the same ruby as used locally for deployment
# set :rvm1_ruby_version, '2.1.0'

# Default branch is :master
set :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml config/secrets.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets public/system system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 1

# use forward agent
# set :ssh_options, forward_agent: true

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 1 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  desc 'Reset all cached actions and pages'
  task :clear_cache do
    on roles(:web) do
      within release_path do
        execute :rake, 'tmp:cache:clear'
      end
    end
  end

  after :finishing, "deploy:cleanup"

end
