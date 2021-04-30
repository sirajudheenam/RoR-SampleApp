# Part - 2: Deploy on Heroku:

Add your app to your version control system github: (you need to create an account on github.com)

```bash
cd sample_app
git init
bundle lock --add-platform x86_64-linux
git add .
git commit -m "initial commit"
git remote add origin https://github.com/sirajudheenam/RoR-SampleApp.git
git push -u origin main
```
Install the [heroku CLI](https://devcenter.heroku.com/articles/heroku-command-line)

## You need to create an account with heroku and logged in with your credentials 


```bash
# Using homebrew on Mac
brew tap heroku/brew && brew install heroku
heroku autocomplete --refresh-cache
heroku autocomplete
printf "$(heroku autocomplete:script bash)" >> ~/.bashrc; source ~/.bashrc



# Verify the installation
heroku --version

# heroku free instance
heroku create --stack cedar

# Do git stuff
$ git add .
$ git commit -am "add few improvements"
$ git push -u origin main

# Push it to heroku
$ git push heroku main

# Do db migration
heroku run rake db:migrate

# Open your app on browser:
heroku open

```

## Precompile your assets locally for production before deploying to production

RAILS_ENV=production bundle exec rake assets:precompile



## Use Profile for your app

```
cat <<'EOF' >>Procfile
web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
EOF
```
Run using `heroku local` 

# Other heroku commands

## Find out how many free dyno hours remaining for your app

heroku ps -a <app name>

heroku ps -a sam-rubyonrails

```
Free dyno hours quota remaining this month: 550h 0m (100%)
Free dyno usage for this app: 0h 0m (0%)
For more information on dyno sleeping and how to upgrade, see:
https://devcenter.heroku.com/articles/dyno-sleeping

=== web (Free): bin/rails server -p ${PORT:-5000} -e $RAILS_ENV (1)
web.1: up 2021/05/01 00:02:40 +0530 (~ 4m ago)
```

## Look at the logs

heroku logs -t

## Login to heroku bash
heroku run bash

du -hd 1 tmp/cache/assets/
386M  tmp/cache/assets/sprockets
~ $ du -hd 1 tmp/cache/assets/ --apparent-size
27M tmp/cache/assets/sprockets




# Troubleshooting:

```
# If you have already initialized git on the app directory 
# If app is created via dashboard
heroku git:remote -a sam-rubyonrails
git commit -am "add ABC feature"
git push heroku main

# Asset precompile issues while deploying on heroku:

# Try running locally first:
NODE_ENV=production RAILS_ENV=production rails assets:precompile --trace

# heroku can't run sqlite so we need to add production on `config/database.yml`.

RAILS_ENV=production rake db:create


```
