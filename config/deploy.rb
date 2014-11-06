# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'maemuki'
set :repo_url, 'git@github.com:BASASI/maemuki.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/maemuki'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{.env config/secrets.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

set :rbenv_type, :system
set :rbenv_ruby, '2.1.3'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

set :unicorn_config_path, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/maemuki.pid"

SSHKit.config.command_map[:rake] = 'bundle exec rake'

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

namespace :rails do
  desc 'Remote console'
  task :console do
    on roles(:app) do |h|
      run_interactively "bundle exec rails console #{fetch(:rails_env)}", h.user
    end
  end

  def run_interactively(command, user)
    info "Running `#{command}` as #{user}@#{host}"
    exec %Q(ssh #{user}@#{host} -p #{host.port} -t "bash --login -c 'cd #{fetch(:deploy_to)}/current && #{command}'")
  end

  namespace :worker do
    desc 'Run workers'
    task :start do
      on roles(:app) do |h|
        within current_path do
          with rails_env: fetch(:rails_env), pidfile: './tmp/resque.pid', background: 'yes', queue: '*' do
            execute :rake, 'environment resque:work'
          end
        end
      end
    end
  end
end

namespace :db do
  namespace :migrate do
    desc 'Reset and migrate the database'
    task :reset do
      on roles(:db) do |h|
        within current_path do
          with rails_env: fetch(:rails_env) do
            execute :rake, 'db:migrate:reset'
          end
        end
      end
    end
  end

  desc 'Load the seed data'
  task :seed do
    on roles(:db) do |h|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end
end

