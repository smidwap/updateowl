web:     bundle exec puma -e $RAILS_ENV -p $PORT
resque:  bundle exec rake environment resque:work QUEUE=*
scheduler: bundle exec rake VERBOSE=true environment resque:scheduler