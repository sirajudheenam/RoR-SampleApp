# Part B - Active Storage in your app:

```
# If you wish to create an app from scratch
rails new avatar_app --database=postgresql --api

rails active_storage:install

# Skip this if you wish to use the model User from part 1.

rails g resource User

# change the migration file

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :login
	  t.string :password

      t.timestamps
    end
  end
end

# Change the User model app/models/user.rb
class User < ApplicationRecord
	has_one_attached :avatar
end

# Run to see the migration number

rake db:migrate:status  # [OR]

rails db:migrate:status

database: sampleapp_dev

 Status   Migration ID    Migration Name
--------------------------------------------------
   up     20210429214404  Create sharks
   up     20210429222311  Create posts
   up     20210501142553  Create users
   up     20210502153929  Create active storage tablesactive storage


# Observe each table has different migration number. It is easier to drop and create again the one we need to without deleting the entire DB or other tables.

# Edit the user migration file `db/migrate/20210501142553_create_users.rb` to create and `up` and `down` method instead of `change`:

class CreateUsers < ActiveRecord::Migration[6.1]
  def up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :login
      t.string :password

      t.timestamps
    end
  end

  def down
	drop_table :users
  end
end

# Now it has the up and down method, so we can drop the table easily and up.

rails db:migrate:down VERSION=20210501142553

rails db:migrate:up VERSION=20210501142553

# Let us get some avatars available from this [site](https://www.flaticon.com/free-icons/avatar) and save it to 
public/avatars directory

mkdir public/avatars

# TODO -- > ADD a small script to download from the site (https://www.flaticon.com/free-icon/user_219969) and save it under `public/avatars` using wget or curl or ruby script.

tree public/avatars

public/avatars/
├── man01.png
├── man02.png
├── man03.png
├── man04.png
├── man05.png
├── woman01.png
├── woman02.png
├── woman03.png
├── woman04.png
└── woman05.png

So we have now avatars collection available locally to use in our app.

# Let us change the `db/seeds.rb` file to seed table with data.

User.destroy_all
sam = User.create(name: 'Sam Miller', email: 'sam@example.org', login: 'sam', password: 'password')

sam.avatar.attach(
	io: File.open('./public/avatars/man01.png'),
	filename: 'man01.png',
	content_type: 'application/png'
	)

# Let us seed it.

rails db:seed

# Let us just verify that we have inserted the record successfully.

rails console

User.all

Running via Spring preloader in process 12367
Loading development environment (Rails 6.1.3.1)

2.7.2 :001 > User.all
  User Load (0.8ms)  SELECT "users".* FROM "users" /* loading for inspect */ LIMIT $1  [["LIMIT", 11]]
 => #<ActiveRecord::Relation [#<User id: 1, name: "Sam Miller", email: "sam@example.org", login: "sam", password: [FILTERED], created_at: "2021-05-02 17:25:47.223511000 +0000", updated_at: "2021-05-02 17:25:47.434491000 +0000">]>
2.7.2 :002 >exit

# The record is there.

# Add these lines to app/controllers/users_controller.rb

  def index
    @users = User.all
    render json: @users
  end

# leave the other actions blank for now.

  def show
  end

  def new
  end

  def edit
  end   

# Edit the `Gemfile` to add `rack-cors` gem. Make sure you have the latest version.
# find more about it on https://github.com/cyu/rack-cors

rack-cors 1.1.1

# Middleware that will make Rack-based apps CORS compatible. 
gem 'rack-cors', '~> 1.1.1'

# Find more about CORS on https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
# Place a file at config/initializers/cors.rb with the following content.

cat <<'EOF' >>config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource '*', 
    	headers: :any, 
    	methods: [:get, :post, :patch, :put, :delete, :options, :head]
  end
end
EOF

# now do `bundle install`
bundle install




```

## React App creation:

Let us create a standalone React App first then we try to integrate with our existing Rails 
App.

```
npx create-react-app avatar_app_frontend

✨  Done in 20.03s.

Created git commit.

Success! Created avatar_app_frontend at /Users/i072278/Dev/ruby/rails/avatar_app_frontend
Inside that directory, you can run several commands:

  yarn start
    Starts the development server.

  yarn build
    Bundles the app into static files for production.

  yarn test
    Starts the test runner.

  yarn eject
    Removes this tool and copies build dependencies, configuration files
    and scripts into the app directory. If you do this, you can’t go back!

We suggest that you begin by typing:

  cd avatar_app_frontend
  yarn start

# create-react-app runs application on port 3000 by default:
# To change that edit your `package.json` file

"scripts": {
        "start": "export port=4000 && react-scripts start",
    }

# Start the server with different default port.
# or 

npm run start port=4000

or 

echo 'port=4000' > .env


npm install --save activestorage react-router react-router-dom



=== START A NEW SERVER :
https://codesandbox.io/s/pmj6jw1v3j?file=/index.js
======




```

References / Inspiration:

- [Connect your React App to Rails API - part 1](https://medium.com/@jennyjean8675309/connect-your-react-application-to-a-rails-api-using-active-storage-part-1-e59dcacc481b)
- [Connect your React App to Rails API - part 2](https://medium.com/@jennyjean8675309/connect-your-react-application-to-a-rails-api-using-active-storage-part-2-84e7978ba11d)
