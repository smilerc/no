web: bundle exec rails server -p $PORT
worker: bundle exec sidekiq -C config/sidekiq.yml
release: bundle exec rails db:migrate