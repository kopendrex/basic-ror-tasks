#!/bin/bash
if [ "$APP_MODE" == "SERVER" ]; then
echo "Running Application in Server Mode."
bundle exec rails db:migrate && bundle exec rails s -p $PORT -b 0.0.0.0
exit $?
fi

if [ "$APP_MODE" == "SIDEKIQ" ]; then
echo "Running Application in Sidekiq Mode."
bundle exec sidekiq
exit $?
fi

if [ "$APP_MODE" == "CRONO" ]; then
echo "Running Application in Crono Mode."
bundle exec crono
exit $?
fi

echo "Using default command."
rails server -b 0.0.0.0 -p $PORT
