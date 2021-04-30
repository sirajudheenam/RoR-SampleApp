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