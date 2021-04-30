# Part 1 - Ruby on Rails with Stimulus

Components:

 - WebPacker
 - CoffeeScript
 - Bootstrap
 - JQuery
 - Popper.js
 - [Stimulus](https://stimulus.hotwire.dev/)

This Sample App also demonstrates the use of bootstrap along with jQuery and Popper.js frameworks.

```bash
$ rails new sample_app --webpack

# Inspect the Gemfile, amend if needed:
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Gems are up to date as of 30 Apr 2021

gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'coffee-rails', '~> 5.0.0'
gem 'uglifier', '~> 4.2.0'
gem 'font-awesome-rails', '~> 4.7.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'rspec', '~> 3.10.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#---

bundle install

# Now add bootstrap jquery and popper to your yarn 
yarn add bootstrap jquery popper.js

# Let us configure the jQuery & popper:
cat <<'EOF' >>config/webpack/environment.js
      const { environment } = require('@rails/webpacker')
      const webpack = require("webpack") 

      environment.plugins.append("Provide", new webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery',
        Popper: ['popper.js', 'default']
      }))

      module.exports = environment
EOF

vi app/javascript/packs/application.js

#Add these two lines after other imports

import "bootstrap"
import "../stylesheets/application"

# Create Stylesheets directory
mkdir -p app/javascript/stylesheets

# Open the custom styles file:
vi app/javascript/stylesheets/application.scss

# Add these two lines of code 
@import "~bootstrap/scss/bootstrap";
@import url('https://fonts.googleapis.com/css?family=Merriweather:400,700');

# Add these styles also for the current application:
$white: white;
$black: black;

.navbar {
        margin-bottom: 0;
        background: $black;
}
body {
        background: $black;
        color: $white;
        font-family: 'Merriweather', sans-serif;
}
h1,
h2 {
        font-weight: bold;
}
p {
        font-size: 16px;
        color: $white;
}
a:visited {
        color: $black;
}
.jumbotron {
        background: #0048CD;
        color: $white;
        text-align: center;
        p {
                color: $white;
                font-size: 26px;
        }
}
.link {
        color: $white;
}
.btn-primary {
        color: $white;
        border-color: $white;
        margin-bottom: 5px;
}
.btn-sm {
        background-color: $white;
        display: inline-block;
}
img,
video,
audio {
        margin-top: 20px;
        max-width: 80%;
}
caption {

        float: left;
        clear: both;

}
#----

# Generate scaffold for Shark:

rails generate scaffold Shark name:string facts:text

# Edit the `config/routes.rb`

Rails.application.routes.draw do
  resources :sharks
  root 'sharks#index'
  
end


# Let us prevent duplicate for `name` field and checks the presence of `name` and `facts`
# Edit the file `app/models/shark.rb`

class Shark < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :facts, presence: true
end

# Let us add some basic authentication 
# TO DO => Enhance it with devise or bcrypt auth later.
# Edit the file `app/controllers/application_controller.rb`

class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: 'admin', password: 'admin', except: [:index, :show]
end


# Let us create a nested resource: `Post` nested inside `Shark`

#  including the :references keyword, which sets up an association between the Shark and Post models. Specifically, this will ensure that a foreign key representing each shark entry in the sharks database is added to the posts database

# Generate a model for Post:
rails generate model Post body:text shark:references

# Edit the file `app/models/shark.rb` to include the `has_many` option for the `posts`and also to ensure that the `destroy` action on a given `shark` deletes any associated `posts`

class Shark < ApplicationRecord
      has_many :posts, dependent: :destroy
      validates :name, presence: true, uniqueness: true
      validates :facts, presence: true
end


# Now edit the `config/routes.rb` file. Note now `Posts` are nested inside `Sharks`.

Rails.application.routes.draw do
  resources :sharks do
    resources :posts
  end
  root 'sharks#index'
end

# Create DB: (optional for SQLite)
rails db:create

# Run DB Migration to create database and tables needed for this project
rails db:migrate

# Create PostsController with the file `app/controllers/posts_controller.rb`

cat <<'EOF' >>app/controllers/posts_controller.rb
class PostsController < ApplicationController
  before_action :get_shark

  def create
    @post = @shark.posts.create(post_params)
  end

  def destroy
    @post = @shark.posts.find(params[:id])
    @post.destroy
  end

  private

  def get_shark
    @shark = Shark.find(params[:shark_id])
  end

  def post_params
    params.require(:post).permit(:body, :shark_id)
  end
end
EOF

# The above will run `get_shark` method before any action in this Controller. So it is easier to relate `shark` associated with the post.


# ReOrganizing views with Partials:

# Edit the `app/views/sharks/show.html.erb` file to look similar to this.

<p id="notice"><%= notice %></p>

<p>
  <strong>Name:</strong>
  <%= @shark.name %>
</p>

<p>
  <strong>Facts:</strong>
  <%= @shark.facts %>
</p>

<!-- This is Added -->
<h2>Posts</h2>
<%= render 'sharks/posts' %>
<!-- This is Added -->

<%= link_to 'Edit', edit_shark_path(@shark) %> |
<%= link_to 'Back', sharks_path %>

<!-- This is Added -->
<div>
  <%= render 'sharks/all' %>
</div>
<!-- This is Added -->

#---

# Edit the `config/initializers/content_security_policy.rb` file to apply application-wide security policy.

Rails.application.config.content_security_policy do |policy|
  policy.connect_src :self, :https, 'http://localhost:3035', 'ws://localhost:3035' if Rails.env.development?
end

# Edit `app/views/layouts/application.html.erb`
# Replace <title> and meta tags and add header

<title><%= content_for?(:title) ? yield(:title) : "About Sharks" %></title>
<meta name="description" content="<%= content_for?(:description) ? yield(:description) : "About Sharks" %>">

<body>
    <header>
      <%= render 'layouts/navigation' %>
    </header>
    <main role="main">
    <%= content_for?(:content) ? yield(:content) : yield %>
    </main>
    ....
</body>

# Create a partial file `app/views/layouts/_navigation.html.erb`

cat <<'EOF' >>app/views/layouts/_navigation.html.erb
<nav class="navbar navbar-dark navbar-static-top navbar-expand-md">
    <div class="container">
        <button type="button" class="navbar-toggler collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false"> <span class="sr-only">Toggle navigation</span>
        </button> <%= link_to "Everything Sharks", root_path, class: 'navbar-brand' %>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav mr-auto">
            <li class='nav-item'><%= link_to 'Home', home_index_path, class: 'nav-link' %></li>
            <li class='nav-item'><%= link_to 'Sharks', sharks_path, class: 'nav-link' %></li>

                </li>
            </ul>
        </div>
    </div>
</nav>
EOF

# Create a file `app/views/layouts/sharks.html.erb`

cat <<'EOF' >>app/views/layouts/sharks.html.erb
<% content_for :content do %>
    <div class="jumbotron text-center">
        <h1>Shark Info</h1>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-lg-6">
                <p>
                    <%= yield %>
                </p>
            </div>
            <div class="col-lg-6">
                <p>

                    <div class="caption">You can always count on some sharks to be friendly and welcoming!</div>
                    <img src="https://assets.digitalocean.com/articles/docker_node_image/sammy.png" alt="Sammy the Shark">
                </p>

            </div>
        </div>
    </div>
<% end %>
      <%= render template: "layouts/application" %>
EOF

# Include font-awesome in the stylesheet `app/assets/stylesheets/application.css`

 *= require_tree .
 *= require_self
 # Add this line
 *= require font-awesome



###################### --- Stimulus --based --set up --- STARTS -----###################### 

# Install webpacker - Skip if this is done already
bundle exec rails webpacker:install

# Installing webpacker will create a directory structure

├── javascript
│   ├── channels
│   │   ├── consumer.js
│   │   └── index.js
│   |── packs
│   |   └── application.js
│   └── stylesheets
│       └── application.scss

# Install [stimulus](https://stimulus.hotwire.dev/) to your app
bundle exec rails webpacker:install:stimulus

# Installing stimulus will create a directory structure

├── javascript
│   ├── controllers
│   │   ├── hello_controller.js
│   │   └── index.js
│   └── packs
│       └── application.js



# Make sure `app/views/layouts/application.html.erb` has `javascript_pack_tag`

<%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
<%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>


# Look at the `app/javascripts/controllers/index.js` file,  
# This code uses webpack helper methods to require the controllers in the app/javascript/controllers directory and load this context for use in your application.

// Load all the controllers within this directory and all subdirectories. 
// Controller files must be named *_controller.js.

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))

# if you don't have any other frameworks on your app, then you can even place 
# above contents at `app/javascript/packs/application.js`


# Using Stimulus in Rails Partials

# Our sharks/posts partial will use the `form_with` form helper to create a new `post` object. It will also make use of Stimulus’s three core concepts: controllers, targets, and actions. These concepts work as follows:

#     Controllers are JavaScript classes that are defined in JavaScript modules and exported as the module’s default object. Through controllers, you have access to particular HTML elements and the Stimulus Application instance defined in app/javascript/packs/application.js.
#     Targets allow you to reference particular HTML elements by name, and are associated with particular controllers.
#     Actions control how DOM events are handled by controllers, and are also associated with particular controllers. They create a connection between the HTML element associated with the controller, the methods defined in the controller, and a DOM event listener.



# Create a _posts partial `app/views/sharks/_posts.html.erb`

cat <<'EOF' >>app/views/sharks/_posts.html.erb
<div data-controller="posts">
        <%= form_with model: [@shark, @shark.posts.build], data: { action: "posts#addBody"} do |form| %>
                <%= form.text_area :body, placeholder: "Your post here", data: { target: "posts.body" } %>
                <br>
                <%= form.submit %>
        <% end %>
  <ul data-target="posts.add">
  </ul>

</div>
EOF

# Create a _all partial `app/views/sharks/_all.html.erb`

cat <<'EOF' >>app/views/sharks/_all.html.erb
<% for post in @shark.posts  %>
    <ul>

        <li class="post">
            <%= post.body %>
            <%= button_tag "Remove Post", data: { controller: "posts", action: "posts#remove" } %>
            <%= button_tag "Upvote Post", data: { controller: "posts", action: "posts#upvote" } %>
        </li>

    </ul>
    <% end %>
EOF

# Change the file `app/views/sharks/show.html.erb` to support stimulus.
cat <<'EOF' >>app/views/sharks/show.html.erb
<p id="notice"><%= notice %></p>

<p>
  <strong>Name:</strong>
  <%= @shark.name %>
</p>

<p>
  <strong>Facts:</strong>
  <%= @shark.facts %>
</p>

<h2>Posts</h2>

<%= render 'sharks/posts' %>

<%= link_to 'Edit', edit_shark_path(@shark) %> |
<%= link_to 'Back', sharks_path %>

<div data-controller="posts">

      <button data-action="posts#showAll">Show Older Posts</button>

      <div data-target="posts.show" style="visibility:hidden">
        <%= render 'sharks/all' %>
      </div>
</div>
EOF

# Create the Stimulus Controller:

# We shall create four actions in the Controller 
    # addBody(), to add new posts.
    # showAll(), to show older posts.
    # remove(), to remove posts from the current view.
    # upvote(), to attach an upvote icon to posts.

# Stimulus is installed at app/javascript folder and create a Controller file `app/javascript/controllers/posts_controller.js`

cat <<'EOF' >>app/javascript/controllers/posts_controller.js

import { Controller } from "stimulus"

export default class extends Controller {

    static targets = ["body", "add", "show"]

    addBody() {
        let content = this.bodyTarget.value;
        this.addTarget.insertAdjacentHTML('beforebegin', "<li>" + content + "</li>");
    }

    showAll() {
        this.showTarget.style.visibility = "visible";
    }

    upvote() {
        let post = event.target.closest(".post");
        post.insertAdjacentHTML('beforeend', '<i class="fa fa-check-circle"></i>');
    }

    remove() {
        let post = event.target.closest(".post");
        post.style.visibility = "hidden";
    }
}

EOF

# Replace the existing `link_to` helpers in the file with the following `button_to` helpers
# on the file `app/views/sharks/index.html.erb` so that it looks like:

  <tbody>
    <% @sharks.each do |shark| %>
      <tr>
        <td><%= shark.name %></td>
        <td><%= shark.facts %></td>
        <td><%= button_to 'Show', shark_path(:id => shark.id), :method => :get %></td>
        <td><%= button_to 'Edit', edit_shark_path(:id => shark.id), :method => :get %></td>
        <td><%= button_to 'Destroy', shark_path(:id => shark.id), :method => :delete %></td>
      </tr>
    <% end %>
  </tbody>

###################### --- Stimulus --based --set up --- ENDS -----###################### 

```


References:
1. [Build a Ruby on Rails App](https://www.digitalocean.com/community/tutorials/how-to-build-a-ruby-on-rails-application)
2. [Add bootstrap to Ruby-On-Rails App](https://www.digitalocean.com/community/tutorials/how-to-add-bootstrap-to-a-ruby-on-rails-application)
3. [Add stimulus to your Ruby-On-Rails App](https://www.digitalocean.com/community/tutorials/how-to-add-stimulus-to-a-ruby-on-rails-application)

