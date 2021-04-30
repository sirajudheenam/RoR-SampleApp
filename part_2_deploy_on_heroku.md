# Part - 2: Deploy on Heroku:

Install the [heroku CLI](https://devcenter.heroku.com/articles/heroku-command-line)

```

# Using homebrew on Mac
brew tap heroku/brew && brew install heroku
heroku autocomplete --refresh-cache
heroku autocomplete
printf "$(heroku autocomplete:script bash)" >> ~/.bashrc; source ~/.bashrc


# Verify the installation
heroku --version

# You need to create an account with heroku and logged in with your credentials 


# If you have already initialized git on the app directory
heroku git:remote -a sam-rubyonrails


$ git add .
$ git commit -am "make it better"
$ git push heroku master



```
