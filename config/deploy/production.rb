set :branch, 'master'
set :rails_env, 'production'

# CONFIGURE THIS
role :web, "update-me.developertown.com"                          # Your HTTP server, Apache/etc
# CONFIGURE THIS
role :app, "update-me.developertown.com"                          # This may be the same as your `Web` server
# CONFIGURE THIS
role :db,  "update-me.developertown.com", :primary => true        # This is where Rails migrations will run
