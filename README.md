# GoodPods
GoodReads for Podcasts

# Dev Environment Set-up

1. Move prod environment variables down to dev
  `heroku config -s >> .env`

2. `rake db:create && rake db:migrate`

3. `heroku local web` then open another terminal and run `heroku local log`


