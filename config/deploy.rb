require 'mongrel_cluster/recipes'


set :user, "fguillen"
set :runner, "fguillen"


set :application, "elbautizadordetelefonos"
set :repository,  "http://elbautizadordetelefonos.googlecode.com/svn/trunk/elbautizadordetelefonos"
#set :scm_username, "fguillen"
#set :scm_password, "xxx"


# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/railsapps/#{application}"


set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"


# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

role :app, "elbautizadordetelefonos.com:1022"
role :web, "elbautizadordetelefonos.com:1022"
role :db,  "elbautizadordetelefonos.com:1022", :primary => true
