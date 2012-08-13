web:     bundle exec thin start -p $PORT
resque:  bundle exec rake environment resque:work QUEUE=*
scheduler: bundle exec rake VERBOSE=true environment resque:scheduler