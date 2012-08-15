set :branch, 'master'
set :rails_env, 'production'

# CONFIGURE THIS
role :web, "updateowl-prodweb01.devtown.int"                          # Your HTTP server, Apache/etc
# CONFIGURE THIS
role :app, "updateowl-prodweb01.devtown.int"                          # This may be the same as your `Web` server
# CONFIGURE THIS
role :db,  "updateowl-prodweb01.devtown.int", :primary => true        # This is where Rails migrations will run
