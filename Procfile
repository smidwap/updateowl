web:    bundle exec rails server puma -p $PORT -e $RACK_ENV
resque:  bundle exec rake environment resque:work QUEUE=*
scheduler: bundle exec rake VERBOSE=true environment resque:scheduler