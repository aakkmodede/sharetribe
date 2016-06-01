require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/bundler'
require 'capistrano/rbenv'
require 'capistrano/rails/migrations'
require 'capistrano/passenger'
require "airbrussh/capistrano"

set :rbenv_type, :user
set :rbenv_ruby, '2.3.1'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }

# require 'capistrano/honeybadger'
Rake::Task[:production].invoke
