
-------------------------------------------------

rails new microblog --database=postgresql

 mkdir gitapp
$ cd gitapp
$ git init
Initialized empty Git repository in .git/
$ rails new . --git --database=postgresql


rails new avatar_app --database=postgresql --api

# Need of icons / avatars for your project
https://www.flaticon.com/free-icons/avatar
https://www.flaticon.com/authors/freepik/2

=====================================================

API App:

```bash
rails new notebook --database=postgresql --api

# If you wish to do all-in-one App rails and react in the same directory
# rails new notebook --database=postgresql --webpack=react

rails generate model Note name:string description:string
rails db:create
rails db:migrate


cat <<'EOF' >>db/seeds.rb
notes = Note.create(
  [
    {
      name: "Painting Tips",
      description: "Scrap & Clean the wall before..."
    },
    {
      name: "Fish Curry Recipe",
      description: "It talks about Chettinadu Fish Curry recipe...."
    },
    {
      name: "Idly Recipe",
      description: "Delicious way to make Idly and Chutney"
    },
    {
      name: "COVID-19 Kolkata",
      description: "List of COVID-19 Vaccine Centers available in Kolkata"
    },
    {
      name: "Saving Tips",
      description: "How to save money electricity or anything you think precious..."
    },
    {
      name: "Mutton Curry Recipe",
      description: "It talks about Chettinadu Mutton Curry recipe...."
    },
    {
      name: "Dosa & Coconut Chutney Recipe",
      description: "Delicious way to make Dosa and Chutney"
    },
    {
      name: "COVID-19 Vaccine Centers in Berlin",
      description: "List of Centers available in Berlin"
    }
  ])
EOF


rails db:seed

rails db:migrate:status

database: notebook_development

 Status   Migration ID    Migration Name
--------------------------------------------------
   up     20210503234434  Create notes




mkdir -p app/controllers/api/v1
cat <<'EOF' >>app/controllers/api/v1/notes_controller.rb
module Api::V1
  class NotesController < ApplicationController
    def index
      @notes = Note.all
      render json: @notes
    end
  end
end
EOF

cat <<'EOF' >>config/routes.rb

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :notes
    end
  end
end
EOF

curl -G http://localhost:3000/api/v1/notes

[{"id":1,"name":"A new cake recipe","description":"Made of chocolate","created_at":"2021-05-03T23:51:37.749Z","updated_at":"2021-05-03T23:51:37.749Z"},{"id":2,"name":"A twitter client idea","description":"Only for replying to mentions and DMs","created_at":"2021-05-03T23:51:37.759Z","updated_at":"2021-05-03T23:51:37.759Z"},{"id":3,"name":"A novel set in Italy","description":"A mafia crime drama starring Berlusconi","created_at":"2021-05-03T23:51:37.792Z","updated_at":"2021-05-03T23:51:37.792Z"},{"id":4,"name":"Card game design","description":"Like Uno but involves drinking","created_at":"2021-05-03T23:51:37.802Z","updated_at":"2021-05-03T23:51:37.802Z"}]

# Add gem 'rack-cors' in the Gemfile.

# create a file called config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # origins '*'
        # Front end from where you are going to access to (React Port)
        origins 'http://localhost:4000'
    resource '*',
        headers: :any,
        methods: [:get, :post, :patch, :put, :delete, :options, :head]
  end
end



# FrontEnd creation:

npm install -g create-react-app

create-react-app giantnote

cd giantnote/src

# Replace default App.js

cat <<'EOF' > giantnote/src/App.js
import React, { Component } from 'react'
import './App.css'
import NotesContainer from './components/NotesContainer'

class App extends Component {
  render() {
    return (
      <div className="App">
        <div className="App-header">
          <h1>Notes Board</h1>
        </div>
        <NotesContainer />
      </div>
    );
  }
}

export default App
EOF

mkdir src/components

cat <<'EOF' > src/components/NotesContainer.js
import React, { Component } from 'react'

class NotesContainer extends Component {
  render() {
    return (
      <div>
        Notes
      </div>
    )
  }
}

export default NotesContainer
EOF

# now start the fronend server

npm run start or just # npm start
npm install axios immutability-helper react-transition-group --save





```
=====================================================
Explore ActiveStorage to store files in to database.

https://edgeguides.rubyonrails.org/active_storage_overview.html


```
# TODO => Recreate the following files to work with plain Ruby-On-Rails without stimulus
## TODO => Recreate so they work with React.

app/views/sharks/_posts.html.erb

## TODO


# Let us install rspec to our project
rails generate rspec:install

# Generate test for our App

```

# Do some minitest stuff
