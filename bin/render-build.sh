set -o errexit

bundle install
bundle exec rails db:migrate
bundle exec rails db:seed
