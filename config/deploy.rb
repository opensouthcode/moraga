require 'mina/rails'
require 'mina/git'

MORAGA_DEPLOY_DOMAIN = ENV.fetch('MORAGA_DEPLOY_DOMAIN', 'dale.infra.opensuse.org')
MORAGA_DEPLOY_PORT = ENV.fetch('MORAGA_DEPLOY_PORT', '22')
MORAGA_DEPLOY_USER = ENV.fetch('MORAGA_DEPLOY_USER', 'MORAGA')
MORAGA_DEPLOY_DIR = ENV.fetch('MORAGA_DEPLOY_DIR', '/home/MORAGA/events')
MORAGA_DEPLOY_REPO = ENV.fetch('MORAGA_DEPLOY_REPO', 'https://github.com/openSUSE/MORAGA.git')
MORAGA_DEPLOY_BRANCH = ENV.fetch('MORAGA_DEPLOY_BRANCH', 'master')

set :application_name, 'moraga'
set :domain, MORAGA_DEPLOY_DOMAIN
set :user, MORAGA_DEPLOY_USER
set :port, MORAGA_DEPLOY_PORT
set :deploy_to, MORAGA_DEPLOY_DIR
set :repository, MORAGA_DEPLOY_REPO
set :branch, MORAGA_DEPLOY_BRANCH

# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
set :shared_dirs, fetch(:shared_dirs, []).push('public/system', '.bundle', 'tmp/pids')
set :shared_files, fetch(:shared_files, []).push('.env.production')

desc "Deploys the current version to the server."
task :deploy do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{sudo systemctl restart moraga}
        command %{sudo systemctl restart moraga-dj}
      end
    end
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
