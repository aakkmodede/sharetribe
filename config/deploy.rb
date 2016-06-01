# config valid only for current version of Capistrano
lock '3.5.0'   ## TODO: set your version of cap here

namespace :deploy do
  namespace :db do
    desc "Load the database schema if needed"
    task load: [:set_rails_env] do
      on primary :db do
        if not test(%Q[[ -e "#{shared_path.join(".schema_loaded")}" ]])
          within release_path do
            with rails_env: fetch(:rails_env) do
              execute :rake, "db:schema:load"
              execute :touch, shared_path.join(".schema_loaded")
            end
          end
        end
      end
    end
  end

  before "deploy:migrate", "deploy:db:load"
end

set :application, 'rentuspace'
set :repo_url, 'git@github.com:aakkmodede/sharetribe.git'

set :deploy_to, '/var/www/rentuspace'

set :passenger_restart_with_touch, true

# Use SSH PEM Authentication
set :pty, true

set :ssh_options, {
  forward_agent: true,
   auth_methods: ['publickey'],
           keys: ['/Users/donavonmcdonald/Downloads/donavon-developer.pem']
}

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/application.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

set :keep_releases, 10

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
end
