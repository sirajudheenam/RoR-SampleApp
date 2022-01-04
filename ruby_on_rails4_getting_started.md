# Ruby on Rails 4 : Getting Started
Chapters:
1. [Introduction](#1.Introduction)
2. [Models and Migrations](#2.Models_and_Migrations)
3. [ActionMailer and ActiveJob](#3.ActionMailer_and_ActiveJob)
4. [Basics of the AssetPipeline](#4.Basics_of_the_AssetPipeline)
5. [Deployment](#5.Deployment)





## 1.Introduction

### What are we building

Question and Answer Website
User can ask questions and answer to exiting questions

Learning:
Route = URL + HTTP Verb (  GET   , POST, PATCH, DELETE)
Controller = C in MVC.

Overview:

Action View
Action Controller
Layout and Rendering
Routing
Helpers (View Helpers)
Action Mailer and Active Job (To send emails)
Asset Pipeline (Static Assets)
Deployment (Heroku)
Debugging (Trobleshooting & Self-Reliant)

Models and Database
-------------------

Active Record Basics (Read Write from DB using Ruby Language)
Active Record Migrations (Create Tables using Ruby)
Active Record Associations (Relations in DB belong_to, has_many)
Active Record Query Interface
Active Record Validations (email address is required and in a certain format)
SQLite
PostGreSQL

### Starting a Rails Project

Recent Version of Ruby:

`ruby -v`

Install using rvm or rbenv:

Recent Version of Rails:

```rails -v```

Install using `gem`:

```gem install rails```

Create a new project:

`rails new HU`

Change to the directory 'HU' :

'cd HU'

Start the Server:

`rails server`

Go the browser and type `localhost:3000`

Look at the console/terminal for `logs`

It displays the default pages and their respective controllers and actions:

```
Rails::WelcomeController#index
Rails::InfoController#properties
```

Generate a controller:

```rails generate controller home index```


'home' - name of the controller
'index' - action of the controller

Point your browser to `localhost:3000/home/index`


Go the file

Change the content of `HU/app/views/home/index.html.erb` to

`<h1>Welcome</h1>`


Change the root page for our application using the route:

HU/config/routes.rb

```ruby
Rails.application.routes.draw do
  root to: 'home#index'
  # or with shortcut
  root 'home#index'
  get 'home/index'
end
```

`route to:` decides the root of the application.

Create a new route for about us page in the `routes.rb` file.

`get '/about' => 'home#about'`

Create an empty method called `about` in the HomeController file (HU/app/controllers/home_controller.rb) as a good practice.

```ruby
class HomeController < ApplicationController
  def index
  end

  def about
  end

end
```

Create a new view template file `HU/app/views/home/about.html.erb` to match our action for the about us page with the following content:

`<h1>About Us </h1>`


Point your browser to `localhost:3000/home/about`


## More on routes:

Simple Match Route:
===================

`get 'demo/index'` is equivalent to `match "demo/index", :to => "demo#index", :via => :get`

Default Route:
==============
We need to have a way to handle more routes.

Default Route Structure:
:controller/:action/:id

Eg.,

`GET /students/edit/52`

StudentsController, edit action

can be written as:

get ':controller(/:action(/:id))'

`match ':controller(/:action(/:id))', :via => :get`

This can load the default action if no action is mentioned explicitely. eg., `demo/` and `demo` will take us to `demo/index`.

If you are going to use different format of the file, then
`match ':controller(/:action(/:id(.:format)))', :via => :get`
That was the default route shipped with rails earlier.

Root Route:
===========

```ruby
root :to => "demo#index"

root "demo#index" #Short form
```
Routes are processed from top to bottom. Once it found a route for request, then it will not look further for routes.
It means routes which are on the top get precedence than the bottom one and so on.

Let us take `get 'demo/hello'` route. It will look for an action (hello) in the (demo) DemoController  code, if it finds an action then it executes else it will look for template (views/demo/hello.html.erb) for an action with matching name then it renders it.

It is good practice to add an action in the controller for each template we are rendering.

We can also specify the controller to render a template

```ruby
class DemoController < ApplicationController
  layout false

  def index
    # render(:template => 'demo/hello') # template name without the .html.erb extenstion.
    # render('demo/hello') # we can simply pass the controller and template name
    render('hello') # since we are in the DemoController we can leave out the explicitely mentioning the controller name.
  end

  def hello
    # render(:template => 'demo/index')
    # render('demo/index')
    render('index')
  end
end
```

### Redirecting Actions:

The difference between rendering and redirecting is that `render` will merely render a template whereas `redirect_to` will ask another `controller` for an `action`.

It is not part of Rails Framework but part of HTTP spec HTTP Redirect.
Status Code of redirect is 302.
Once browser gets redirect code 302 and URL to redirect then it redirects the user to the URL that comes with 302.

```
HTTP/1.1 302 Found
Location: http://localhost:3000/demo/hello
```

Let us do a redirect action on rails

```ruby
class DemoController < ApplicationController
  layout false

  def index
    render('hello')
  end

  def hello
    render('index')
  end
  def other_hello
    redirect_to(:controller => 'demo', :action => 'index')
  end
  def lynda # We can also redirect to an URL.
    redirect_to("http://lynda.com")
  end
end
```
Even if we have a template file named `other_hello.html.erb`, it won't be rendered as `redirect_to` action will takes precedence.

### View Templates:

ERb - Embedded Ruby
eRuby Templating System to embed to ruby code to HTML.
hello.html.erb
Template Name: hello
Process with: ERb
Output : HTML

If there is no file extension `erb` is given, erb processing will not be used.
We can also use other extensions such as javascript (js) or xml or json.

How to embed the code.

```bash

<% code %> #Executes the code
<%= code %> # Executes and output the results

<h1>demo#hello</h1>
<p>Hello World </p>
<%= 1+1 %>
<% target="universe" %>
<%= "Hello #{target}" %>

<% 3.times %>
<%= "abc" %>
<% end %>
```
### Instance Variables:

variable #local variable
@instance_variable

Controllers make the @instance_variable available in their views.

When a request comes to the controller, it creates an instance of the Class `DemoController` then make those instance variables available to that instance.

```ruby
#on controller - creating an instance variable.
def hello
  @array = [1,2,3,4,5]
end
#on view @array is available
<% @array.each do | n | %>
  <%= n %> <br />
<% end %>
```

It is important to understand only Controller can send values via @instance_variables not vice versa.

Links:

HTML links:
<a href="http://localhost:3000/demo/index">Index Page </a>

Rails Links:
<%= link_to(text, target) %>

<%= link_to("Index Page", "/demo/index") %>

<%= link_to("Index Page", {:controller => 'demo', :action => 'index'}) %>

```ruby
#index.html.erb
<a href="/demo/hello">Hello Page 1</a>
<%= link_to("Hello Page 2", {:action => "hello"}) %>
<%= link_to("Hello Page 3", {:controller => 'demo',:action => "hello"}) %>

#hello.html.erb
<a href="/demo/hello">Index Page 1</a>
<%= link_to("Index Page 2", {:action => "index"}) %>
<%= link_to("Index Page 3", {:controller => 'demo',:action => "index"}) %>
# When you rollover the links on hello page `Index Page 2` and `Index Page 2` will just show you the `localhost:3000/` instead of `localhost:3000/demo/index` since it has access to the routes file and renders a shorter link to the /.
```

### URL Parameters:
HTML Links with parameters:
*key value pairs
/demo/hello/1?page=3&name=siraj


Rails URL Hash with Parameters:
{
  :controller => 'demo', # default is current controller
  :action => 'hello', # default is current action
  :id => 1,
  :page => 3,
  :name => 'siraj'
}

/demo/hello/1?page=3&name=siraj

### Parameters Hash:

params
Contains both GET and POST variables

HashWithIndifferentAccess

params[:id]
params['id']

<%= link_to("Hello with parameters", {:controller => 'demo',:action => 'hello', :id => 25, :page => 3 }) %>
This is transformed to

http://localhost:3000/demo/hello/25?page=3

```ruby
#DemoController
def hello
  @id = params['id']
  @page = params[:page]
end

#hello.html.erb
ID:<%= params[:id] %><br />
ID: <%= @id %><br />
Next Page: <%= @page + 1 %><br /> # this will result in error as it is still string. no implicit conversion of Fixnum into String
```
Let us rewrite this:

```ruby
#DemoController
def hello
  @id = params['id']
  @page = params[:page].to_i # explicit conversion from string to integer
end
# parameters are always string

#hello.html.erb
ID:<%= params[:id] %><br />
ID: <%= @id %><br />
Next Page: <%= @page + 1 %><br />

# To troubleshoot further do an inspect on params.
<hr />
<%= params.inspect %>
```

##Databases

An application may contain one or more Database

Database
  - Set of Tables
      - Set of Columns and Rows
        1 Table = 1 Model
        Represents Single Concept (a noun)
        Examples: products, customers, orders, users (Plurals in lowercase)
      - Column
        Set of data of a single simple type.
        Examples first_name, last_name, email, password
        Columns have types: strings, integers etc.,
      - Row
        Single record of data
        Example "Sirajudheen", "Mohamed Ali", "sirajudheenam@gmail.com"
      - Field
        Intersection of a column and a row
        first_name => "Sirajudheen"
      - Index
        Data structure on a table to increase lookup speed.
        Like the index at the back of a book
      - Foreign Keys
        Table column whose value reference rows in another table. People relate a table with another table with this foreign key. The foundation of relational databases.
        Example: pages table with subject_id.
        Always put indexes on your foreign keys
      - Schema:
        Structural definition of a database.
        Importing a schema creates a complete database.
      - CRUD:
        Create Read Update and Delete

Create Database on mysql:
  SQL Commands:
    SHOW DATABASES;
    CREATE DATABASE db_name;
    USE db_name;
    DROP DATABASE db_name;

```bash    
mysql -u root -p
Enter Password:
mysql>
SHOW DATABASES;

CREATE DATABASE simple_cms_development;

GRANT ALL PREVILEGES ON db_name.*
  TO 'username@localhost'
  IDENTIFIED BY 'password';

SHOW GRANTS FOR 'username@localhost';

$ mysql -u simple_cms -p simple_cms_development
```

Configuring the project to use our Database:

YAML - YAML Ain\'t Markup Language.

Inspect the `config/database.yml`

```yaml
development:
  adapter: mysql2
  encoding: 'utf-8'
  database: simple_cms_development
  pool: 5
  username: simple_cms
  password: verysecretpassword
  socket: /tmp/mysql.sock
test:
  adapter: mysql2
  encoding: 'utf-8'
  database: simple_cms_test
  pool: 5
  username: simple_cms
  password: verysecretpassword
  socket: /tmp/mysql.sock
production:
  adapter: mysql2
  encoding: 'utf-8'
  database: simple_cms_production
  pool: 5
  username: simple_cms
  password: verysecretpassword
  socket: /tmp/mysql.sock
```

Rail Environments:

Development:
Test:
Production:

config/development.rb
config/test.rb
config/production.rb

Working with DB:

```ruby
rake db:schema:dump
# Look for the folder db/schema.rb
```
### Rake:

Rake is a Simple Ruby helper program

Like linux, Ruby\'s make. Rake takes its name from Linux\'s make.

#To list available rake\'s tasks.
rake -T

# To get the specific tasks related to db
rake -T db

#to pass with environemnt variables:
rake db:schema:dump RAILS_ENV=production

### Migrations:

- set of database instructions
- Written in Ruby
- Migrate your database from one state to another.
- Contain instructions for both
  - Moving up to a state.
  - Move back down to the previous state.
Why use migrations:
  - Keeps database schema with application code.
  - Executable and Repeatable
  - Allows sharing schema changes. Share DB Changes to another developer.
  - Helps with versioning.
  - Allows writing in Ruby instead of SQL.
  - It is not a better solution but better than working without them.

Generating migrations:
migration stays in the folder:
db/
rails generate migration DoNothingYet



```ruby
# db/migration/do_nothing_yet.rb
class DoNothingYet < ActiveRecord::Migration

  def up

  end

  def down

  end

end
```
Generate a model first: This generates a model and migation files

rails generate model User

It creates migration and model files
db/migrate/20201114034358_create_users.rb
app/models/user.rb

Model name is singular and Table name is plural.

open up `db/migrations/20201114034358_create_users.rb` file in a text editor:

```ruby
#db/migrations/20201114034358_create_users.rb
class CreateUsers < ActiveRecord::Migration[6.0]
  def up
    create_table :users do |t|
      t.column "first_name", :string, :limit => 25
      t.string "last_name", :string, :limit => 50
      t.string "email", :default => "", :null => false
      t.string "password", :limit => 40

      # t.datetime "created_at"
      # t.datetime "modified_at"
      # the following will create the above two columns for us
      t.timestamps

    end
  end

  def down
    drop_table :users
  end
end
```
#### Every rails table is created with unique auto incrementing `:id` column. Whenever a record (row) is added to the table, it will auto increment its value and persistently stores it. This `:id` is also known as primary key for the table.
If you wish to override the default behaviour of adding a column to the table, then add this after the table name `, { :id => false }`

```ruby
create_table "table", { :id => false } do |t|
  t.column "name", :type, options
  t.type "name", options
end
```

Create table tormat:

create_table "table" do |t|
  t.column "name", :type, options
  t.type "name", options
end

Table columns types:

binary
boolean
date
datetime
decimal
float
integer # becomes int
string  # becomes varchar
text    # become text
time

Table column options:

:limit => size
:default => value
:null => true/false

:precision => number
scale => number



Running migrations:

Migration Up:

```bash
$ rails db:migrate RAILS_ENV=development

# Specifying this `RAILS_ENV=development` is not necessary as it will by default will migrate in development environment.

$ mysql -u simple_cms -p simple_cms_development

mysql> SHOW TABLES;

mysql> SHOW FIELDS FROM users;

mysql> SHOW FIELDS FROM schema_migrations;

mysql> SELECT * FROM schema_migrations;

mysql> exit;

```
schema.rb contains the table schema and its schema migration number.

Migration Down:

Bring the tables down using migration. Revert back to the state of the database before migrations.

rake db:migrate VERSION=0

mysql> SELECT * FROM schema_migrations;
Empty set (0.00 sec)

Deleted all the migration versions as we dropped the tables and bring to the state of the DB before migration.

Migration Status:

$ rake db:migrate:status

It will have migration numbers

$ rake db:migration VERSION=20201114034358

This will migrate only one table with the migration number `20201114034358`

$ rake db:migrate

This will do the rest of the migrations which are pending.

rake db:migrate:up VERSION=20201114034358
This will run the up method of the migration which is in turn creating table.

rake db:migrate:down VERSION=20201114034358
This will run the down method of the migration which is in turn deleting table.

`rake db:migrate:redo`

This will run the down then up.

Other Rake methods

`rake db:drop db:create db:migrate`

Warning: This will delete existing DB entirely.

```
### Migration Methods:

#### Table migaration methods:

```
create_table(table, options)  do |t|
  ...columns
end

drop_table(table)

rename_table(table, new_name)
```

#### Column migration methods:

```ruby
add_column(table, column, type, options)

remove_column(table, column)

rename_column(table, column, new_name)

change_column(table, column, type, options)
```

#### Index migration methods:

add_index(table, column, options)
remove_index(table, column)

#### Index migration method options:

:unique => true/false
:name => "your_custom_name"

#### Execute migration methods:
It can run any SQL on the DB directly. SQL will be specific to particular DB Type. SQL written for mysql may not be suitable for SQLite or PostGreSQL and vice versa.

execute("Any SQL Statements specific to the DB Type")

Let us create some migrations
rails generate migration AlterUsers

```ruby
#db/migrations/20201113438858_alter_users.rb
class AlterUsers < ActiveRecord::Migration[6.0]
  def up
    puts "*** Renaming table name from `users` to `admin_users` ***"
    rename_table("users", "admin_users")
    puts "*** Adding username column to `admin_users` table ***"
    add_column("admin_users", "username", :string, :limit => 25, :after => "email")
    puts "*** Any previous options for email field will be wiped away. `:limit => 100` is the only option will get effect.***"
    puts "***  Changing column email on the table admin_users   ***"
    change_column("admin_users", "email", :string, :limit => 100)
    puts "***Renaming password column to hashed_password***"
    rename_column("admin_users","password", "hashed_password")
    puts "***Adding index to the column username***"
    add_index("admin_users", "username")
    end
  end
  def down
    remove_index("admin_users", "username")
    rename_column("admin_users", "hashed_password", "password")
    remove_column("admin_users", "username")
    change_column("admin_users", "email", :string, :default => "", :null => false)
    rename_table("admin_users", "users")
  end
end
```

rake db:migrate

rake db:migrate VERSION=0

rake db:migrate

or add a version number.

rake db:migrate VERSION=20201113438858

Let us create a bug in our code and run migration.

```
#db/migrations/20201113438858_alter_users.rb
class AlterUsers < ActiveRecord::Migration[6.0]
  def up
    rename_table("users", "admin_users")
    add_column("admin_users", "username", :string, :limit => 25, :after => "email")
    change_column("admin_users", "email", :string, :limit => 100)
    rename_column("admin_users","broken", "hashed_password")
    add_index("admin_users", "username")
    end
  end
  def down
    remove_index("admin_users", "username")
    rename_column("admin_users", "hashed_password", "password")
    remove_column("admin_users", "username")
    change_column("admin_users", "email", :string, :default => "", :null => false)
    rename_table("admin_users", "users")
  end
end
```

If you run `rake db:migrate`, it will do half migration and throw error, since there is no column named `broken`

To overcome this problem, comment out the line in which the migration already run and try to run the db:migrate:up method.

```ruby
def up
  # rename_table("users", "admin_users")
  # add_column("admin_users", "username", :string, :limit => 25, :after => "email")
  # change_column("admin_users", "email", :string, :limit => 100)
  rename_column("admin_users","broken", "hashed_password")
  add_index("admin_users", "username")
  end
end
```
Now run `rake db:migrate:up VERSION=20201113438858` should resolve the error and uncomment those lines and save it.

Make sure you are able to rake db:migrate VERSION=0 then db:migrate

#### Migration Advice:

- Comment out the executed code lines to get back on track.
  - Write SQL commands as a last resort.
- Keep migrations small and concise.
- Test all migrations thoroughly in development

Miagration Challenge for Content Migration:

Simple CMS Blueprint:

---------------------------------------------------------------
| Subject One  |                Page Three                     |
|  * Page One  |    Section:                                   |
|  * Page Two  |      Lorem ipsum dolor sit amet,              |
|              |      consectetur adipisicing elit,            |
| Subject Two  |      sed do eiusmod tempor incididunt         |
| * Page Four  |      ut labore et dolore magna aliqua.        |                               
| * Page Five  |                                    |
|  * Page Six  |    Section:                                   |
|  * Page 7    |      Lorem ipsum dolor sit amet,              |
|              |      consectetur adipisicing elit,            |
| Subject Three|      sed do eiusmod tempor incididunt         |
| * Page Eight |      ut labore et dolore magna aliqua.        |                               
| * Page Nine  |                                    |
| * Page Ten   |    Section:                                   |
| * Page 11    |      Lorem ipsum dolor sit amet,              |
|              |      consectetur adipisicing elit,            |
| Subject Four |      sed do eiusmod tempor incididunt         |
| * Page Three |      ut labore et dolore magna aliqua.        |                               
----------------------------------------------------------------

Subject => has several pages
Page => has several sections

page_id
subject_id

Each page will have a subject_id as foreign key
Each section will have a page_id as foreign key
Objective:

Generate Models:
  - Subject
  - Page
  - Section

Solution:
rails generate model Subject
rails generate model Page
rails generate model Section


Write migrations:
- Subjects: name (string), position (integer), visible (boolean)
- Pages: name (string), permalink (integer), position (integer), visible (boolean)
- Sections: name (string), position (integer), visible (boolean), content_type (string), content (text)
- Add foreign keys
- Add indexes
  - Three additional indexes and none of which will be under Subjects table.

```ruby
#cms/db/migrate/20201119194553_create_subjects.rb
class CreateSubjects < ActiveRecord::Migration[6.0]
  def up
    create_table :subjects do |t|
      t.string "name"
      t.integer "position"
      t.boolean "visible", :default => false

      t.timestamps
    end
  end
  def down
    drop_table :subjects
  end
end


#cms/db/migrate/20201119194559_create_pages.rb
# Pages: name (string), permalink (string), position (integer), visible (boolean)
class CreatePages < ActiveRecord::Migration[6.0]
  def up
    create_table :pages do |t|
      t.integer "subject_id"
      # same as: t.references :subject
      # same as t.belongs_to :subject, foreign_key: true
      t.string "name"
      t.string "permalink"
      t.integer "position"
      t.boolean "visible"


      t.timestamps
    end
    add_index("pages", "subject_id")
    add_index("pages", "permalink")
  end
  def down
    drop_table :pages
  end
end

# cms/db/migrate/20201119194625_create_sections.rb
# Sections: name (string), position (integer), visible (boolean), content_type (string), content (text)
# If the migration can be reversible, we can just leave the method name as change and we can still do migration up and down.
class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.integer "page_id"
      #same as : t.references :page
      #same as : t.belongs_to :page, foreign_key: true
      t.string "name"
      t.integer "position"
      t.string "content_type"
      t.text "content"
      t.boolean "visible", :default => false

      t.timestamps
    end
    add_index("sections", "page_id")
  end
end

```

Run Migrations:
  - All the way up
  - All the way down
  - To different versions


ActiveRecords and ActiveRelation

 - active record: design pattern in relational databases
 - ActiveRecord: Rails implementation of active record design pattern
  * Retrive and manipulate data as objects, not as static rows.

ActiveRecord objects are "intelligent"
 - Understands the structure of the table.
 - Contains data from table rows.
 - Knows how to create, edit, update and delete rows.

 ActiveRecord example:

 user = User.new
 user.first_name = "Sam"
 user.save #SQL INSERT

 user.last_name = "Miller"
 user.save # SQL UPDATE

 user.delete # SQL DELETE


 ActiveRelation:
 - Added in Rails version v3
 - Also known as ARel

 What is ActiveRelation:
  - Simplifies the generation of complex DB queries
  - Simple Queries are chainable (like most Ruby objects)
  - Complex joins and aggregations use efficient SQL
  - Queries do not execute until needed.

ActiveRelation example:

users = User.where(:first_name => "Sam")
users = users.order("last_name ASC").limit(5)
users = users.include(:articles_authorized)

The SQL for the above would be:

SELECT users.*, articles.*
FROM users
LEFT JOIN articles ON (users.id = articles.author_id)
WHERE users.first_name = "Sam"
ORDER_BY last_name ASC LIMIT 5;

What happens when we change a table name, we can change it on the configuration something like this.

```ruby
class User < ActiveRecord::Base
  self.table_name = "admin_users"
end
```

It is best practice to rename the file user.rb to admin_user.rb then change the class name from User to AdminUser.

#### Rails Console:

rails console

Specifying Environments:

rails console production


Creating Records:

subject = Subject.new
subject.new_record?
subject.name = "First Subject"

subject = Subject.new(:name => "First Subject", :position => 1, :visible => true)
subject.new_record?
subject.save
subject.id
subject

irb>
if subject.save
  puts "Saved !"
else
  puts "Not Saved !"
end

subject = Subject.create(:name => "Second Subject", :position => 2)

It creates a row.

#### Updating Records:
  Two ways of updating records

- Find/Save
  - Find Record - subject = Subject.find(1)
  - Set values - subject.name = "Initial Subject"
  - Save - subject.save

- Find / Update Attributes
  Find Record - subject.find(2)
  Set values / save. - subject.update_attributes(:name => "Second Subject", :visible => true)

```
if subject.update_attributes(:name => "Revised Subject", :visible => true)
  puts "Record Updated !"
else
  puts "Record not updated !"
end
```

#### Delete Records:

delete and destroy methods are different

'
Subject.create(:name => "Bad Subject")
# A record is created with an :id 3
subject = subject.find(3)
subject.destroy
# subject with id 3 is deleted from the table, however subject varibale will still contain the data for references. We can\'t modify it.
'

#### Find Records:

- Primary key finder

Subject.find(:id)
Subject.find(2)

Returns an object or an error.

- Dynamic finder
    Subject.find_by_id(2)
    Subject.find_by_name("First Subject")
    Subject.find_by_position(2)
    Subject.find_by_visble(true)
    Subject.find_by_created_at('<TIME_STAMP>')
    Subject.find_by_updated_at('<TIME_STAMP>')

    Returns an object or nil
    If more than one record found, it shows the first available record
- Find by all method
    Subject.all
    Returns an array of objects

- Find by first / last method
    Subject.first
    Subject.last
    Returns an object or nil
    If more than one record found, it shows the first available record

#### Query Methods: Conditions
  - where(conditions):
      Subject.where(:visible => true)
      Returns an ActiveRelation object which can be chained.
      Subject.where(:visible => true).order("position ASC")
      Does not execute Database call immediately.
  - Condition expression types:
    - String:
    "name = 'First Subject' AND visible = true"
    Flexible, raw SQL
    Use carefully, beware of SQL injection
    "name = '#{subject_name}' AND visible = true"
    subject_name = "' -- hacker code -- "
    Becareful about inserting user provided data in to the DB.
    Hardcoded Strings are better. Never take input from user directly and insert them without inspecting what is in it.
    - Array:
    ["name = ? AND visible = true", "First Subject"]
    Flexible, escaped SQL, safe from SQL injection
    - Hash:
    {:name => "First Subject", :visible => true}
    Simple, escaped SQL, safe from SQL injection
    Each key value pair is joined with AND.
    Only supports equality, range and subset checking
    No OR, LIKE, less than, or greater than # use Array instead.

    Examples:
    subjects = Subject.where(:visible => true)
    subjects.class
    subjects.to_sql
    subjects = Subject.where("visible = true")#string
    subjects = Subject.where(["visible = ?", true])#array
    subjects = Subject.where({:visible => true, :position => 1})#hash
    subjects = Subject.where(:visible => true).where(:position => 1) #daisy chained
    #This first returns a single Subject (row) object instead of array or ActiveRelation object
    subjects = Subject.where(:visible => true).where(:position => 1).first
'
#### Query Methods: Order, Limit, Offset

order(sql_fragment):
Sort by any column either ascending or descending, alphabetically or reverse alphabetically,chrnologically or reverse chronologically.

limit(integer):
Limit number of records retrieved from table. 10 records per fetch.

offset(integer):
If we want to display 10 records per page, if we wish to display 21 page, then we need to skip those 20 pages worth of records. We can do so by offset method.

Example:
  Subject.order("position ASC").limit(10).offset(40)

Order SQL format:

table_name.column_name ASC/DESC

Order SQL Table Disambiquation:
  * Not necessary for single table.
  * Recommended with joined tables
  * Required when joined tables have same column names.
      order("subjects.created_at DESC")
      order("subjects.visible DESC, subjects.name ASC") #sort with multiple columms

Example:
  subjects = Subject.where(:visible => true).order("position ASC")
  subjects = Subject.where(:visible => true).order("position DESC").limit(1)
  subjects = Subject.where(:visible => true).order("position ASC").limit(1).offset(1)
  subjects = Subject.limit(1).offset(1).where(:visible => true).order("subjects.position ASC")

#### Named Scopes:
We have used methods provided by Rails ActiveRecord and ActiveRelation. To write our custom query, we would use Named scopes.
  - Queries defined in a model.
  - Defined using ActiveRelation query methods.
  - Can be called like ActiveRelation methods. (can be daisy chained)
  - Can accept parameters.
  - Rails 4 requires lambda syntax. Lambda is anonymus function in ruby. Stabi lambda syntax is `->`.

Define a named scope on our models:

Example 1:
  Syntax:
    scope :active, lambda {where(:active => true)}
    scope :active, -> {where(:active => true)}

    is equivalent to

    def self.active
      where(:active => true)
    end

    #list all the cutomers where :active is true.
    Customer.active

Example 2:
  scope :with_content_type, lambda {|ctype|
    where(:content_type => ctype)
  }

  def self.with_content_type(ctype)
    where(:content_type => ctype)
  end
  #list all the sections where :content_type is 'html'.
  Section.with_content_type('html')

#Evaluated when called, not when defined.

scope :recent, lambda {
  where(:created_at => 1.week.ago..Time.now)
}

# Chaining scopes
Article.recent.visible.newest_first

Example 3:
Write our named scope on our ActiveRecord Subject.

'
class Subject < ApplicationRecord
  scope :visible, lambda { where(:visible => true)}
  scope :invisible, lambda { where(:visible => false)}
  scope :sorted, lambda { order("subjects.position ASC")}
  scope :newest_first, lambda { order("subjects.created_at DESC")}
  scope :search, lambda {|query|
    where(["name LIKE ?", "%#{query}%"])} # we can just query instead.
end
'

Some outputs from the queries:

'
irb(main):009:0> Subject.all
  Subject Load (0.3ms)  SELECT "subjects".* FROM "subjects" LIMIT ?  [["LIMIT", 11]]
=> #<ActiveRecord::Relation [#<Subject id: 1, name: "First Subject", position: 1, visible: true, created_at: "2020-11-20 05:05:10", updated_at: "2020-11-20 05:05:10">, #<Subject id: 2, name: "Second Subject", position: 2, visible: false, created_at: "2020-11-20 05:05:34", updated_at: "2020-11-20 05:05:34">, #<Subject id: 3, name: "Third Subject", position: 3, visible: true, created_at: "2020-11-20 09:51:59", updated_at: "2020-11-20 09:51:59">, #<Subject id: 4, name: "Revised Subject", position: 4, visible: false, created_at: "2020-11-20 09:52:21", updated_at: "2020-11-20 09:52:21">]>

irb(main):011:0> Subject.first
  Subject Load (0.3ms)  SELECT "subjects".* FROM "subjects" ORDER BY "subjects"."id" ASC LIMIT ?  [["LIMIT", 1]]
=> #<Subject id: 1, name: "First Subject", position: 1, visible: true, created_at: "2020-11-20 05:05:10", updated_at: "2020-11-20 05:05:10">

irb(main):012:0> Subject.last
  Subject Load (0.4ms)  SELECT "subjects".* FROM "subjects" ORDER BY "subjects"."id" DESC LIMIT ?  [["LIMIT", 1]]
=> #<Subject id: 4, name: "Revised Subject", position: 4, visible: false, created_at: "2020-11-20 09:52:21", updated_at: "2020-11-20 09:52:21">

irb(main):013:0> subjects = Subject.all
irb(main):014:0> subjects.where(:visible=> true)
  Subject Load (0.3ms)  SELECT "subjects".* FROM "subjects" WHERE "subjects"."visible" = ? LIMIT ?  [["visible", 1], ["LIMIT", 11]]
=> #<ActiveRecord::Relation [#<Subject id: 1, name: "First Subject", position: 1, visible: true, created_at: "2020-11-20 05:05:10", updated_at: "2020-11-20 05:05:10">, #<Subject id: 3, name: "Third Subject", position: 3, visible: true, created_at: "2020-11-20 09:51:59", updated_at: "2020-11-20 09:51:59">]>

irb(main):016:0> subjects.where(:visible => false)
  Subject Load (0.2ms)  SELECT "subjects".* FROM "subjects" WHERE "subjects"."visible" = ? LIMIT ?  [["visible", 0], ["LIMIT", 11]]
=> #<ActiveRecord::Relation [#<Subject id: 2, name: "Second Subject", position: 2, visible: false, created_at: "2020-11-20 05:05:34", updated_at: "2020-11-20 05:05:34">, #<Subject id: 4, name: "Revised Subject", position: 4, visible: false, created_at: "2020-11-20 09:52:21", updated_at: "2020-11-20 09:52:21">]>

irb(main):018:0> subjects.where(:visible => false).order("position DESC")
  Subject Load (0.7ms)  SELECT "subjects".* FROM "subjects" WHERE "subjects"."visible" = ? ORDER BY position DESC LIMIT ?  [["visible", 0], ["LIMIT", 11]]
=> #<ActiveRecord::Relation [#<Subject id: 4, name: "Revised Subject", position: 4, visible: false, created_at: "2020-11-20 09:52:21", updated_at: "2020-11-20 09:52:21">, #<Subject id: 2, name: "Second Subject", position: 2, visible: false, created_at: "2020-11-20 05:05:34", updated_at: "2020-11-20 05:05:34">]>

irb(main):019:0> subjects.where(:visible => false).order("position ASC")
  Subject Load (0.8ms)  SELECT "subjects".* FROM "subjects" WHERE "subjects"."visible" = ? ORDER BY position ASC LIMIT ?  [["visible", 0], ["LIMIT", 11]]
=> #<ActiveRecord::Relation [#<Subject id: 2, name: "Second Subject", position: 2, visible: false, created_at: "2020-11-20 05:05:34", updated_at: "2020-11-20 05:05:34">, #<Subject id: 4, name: "Revised Subject", position: 4, visible: false, created_at: "2020-11-20 09:52:21", updated_at: "2020-11-20 09:52:21">]>

irb(main):020:0> subjects.where(:visible => false).order("position ASC").limit(1)
  Subject Load (0.8ms)  SELECT "subjects".* FROM "subjects" WHERE "subjects"."visible" = ? ORDER BY position ASC LIMIT ?  [["visible", 0], ["LIMIT", 1]]
=> #<ActiveRecord::Relation [#<Subject id: 2, name: "Second Subject", position: 2, visible: false, created_at: "2020-11-20 05:05:34", updated_at: "2020-11-20 05:05:34">]>

irb(main):021:0> subjects.where(:visible => false).order("position ASC").offset(1)
  Subject Load (0.4ms)  SELECT "subjects".* FROM "subjects" WHERE "subjects"."visible" = ? ORDER BY position ASC LIMIT ? OFFSET ?  [["visible", 0], ["LIMIT", 11], ["OFFSET", 1]]
=> #<ActiveRecord::Relation [#<Subject id: 4, name: "Revised Subject", position: 4, visible: false, created_at: "2020-11-20 09:52:21", updated_at: "2020-11-20 09:52:21">]>

irb(main):022:0> subjects.where(:visible => false).order("position DESC").offset(1)
  Subject Load (0.3ms)  SELECT "subjects".* FROM "subjects" WHERE "subjects"."visible" = ? ORDER BY position DESC LIMIT ? OFFSET ?  [["visible", 0], ["LIMIT", 11], ["OFFSET", 1]]
=> #<ActiveRecord::Relation [#<Subject id: 2, name: "Second Subject", position: 2, visible: false, created_at: "2020-11-20 05:05:34", updated_at: "2020-11-20 05:05:34">]>

irb(main):001:0> Subject.visible
   (1.5ms)  SELECT sqlite_version(*)
  Subject Load (0.3ms)  SELECT "subjects".* FROM "subjects" WHERE "subjects"."visible" = ? LIMIT ?  [["visible", 1], ["LIMIT", 11]]
=> #<ActiveRecord::Relation [#<Subject id: 1, name: "First Subject", position: 1, visible: true, created_at: "2020-11-20 05:05:10", updated_at: "2020-11-20 05:05:10">, #<Subject id: 3, name: "Third Subject", position: 3, visible: true, created_at: "2020-11-20 09:51:59", updated_at: "2020-11-20 09:51:59">]>

irb(main):002:0> Subject.invisible
  Subject Load (0.2ms)  SELECT "subjects".* FROM "subjects" WHERE "subjects"."visible" = ? LIMIT ?  [["visible", 0], ["LIMIT", 11]]
=> #<ActiveRecord::Relation [#<Subject id: 2, name: "Second Subject", position: 2, visible: false, created_at: "2020-11-20 05:05:34", updated_at: "2020-11-20 05:05:34">, #<Subject id: 4, name: "Revised Subject", position: 4, visible: false, created_at: "2020-11-20 09:52:21", updated_at: "2020-11-20 09:52:21">]>

irb(main):003:0> Subject.invisible.sorted
  Subject Load (0.7ms)  SELECT "subjects".* FROM "subjects" WHERE "subjects"."visible" = ? ORDER BY subjects.position ASC LIMIT ?  [["visible", 0], ["LIMIT", 11]]
=> #<ActiveRecord::Relation [#<Subject id: 2, name: "Second Subject", position: 2, visible: false, created_at: "2020-11-20 05:05:34", updated_at: "2020-11-20 05:05:34">, #<Subject id: 4, name: "Revised Subject", position: 4, visible: false, created_at: "2020-11-20 09:52:21", updated_at: "2020-11-20 09:52:21">]>

irb(main):001:0> Subject.newest_first
   (1.1ms)  SELECT sqlite_version(*)
  Subject Load (0.8ms)  SELECT "subjects".* FROM "subjects" ORDER BY subjects.created_at DESC LIMIT ?  [["LIMIT", 11]]
=> #<ActiveRecord::Relation [#<Subject id: 4, name: "Revised Subject", position: 4, visible: false, created_at: "2020-11-20 09:52:21", updated_at: "2020-11-20 09:52:21">, #<Subject id: 3, name: "Third Subject", position: 3, visible: true, created_at: "2020-11-20 09:51:59", updated_at: "2020-11-20 09:51:59">, #<Subject id: 2, name: "Second Subject", position: 2, visible: false, created_at: "2020-11-20 05:05:34", updated_at: "2020-11-20 05:05:34">, #<Subject id: 1, name: "First Subject", position: 1, visible: true, created_at: "2020-11-20 05:05:10", updated_at: "2020-11-20 05:05:10">]>

# "%#{query}%" enclosing with % will find even if word contains in the field as just a part.
irb(main):005:0> Subject.search("vise")
  Subject Load (0.3ms)  SELECT "subjects".* FROM "subjects" WHERE (name LIKE '%vise%') LIMIT ?  [["LIMIT", 11]]
=> #<ActiveRecord::Relation [#<Subject id: 4, name: "Revised Subject", position: 4, visible: false, created_at: "2020-11-20 09:52:21", updated_at: "2020-11-20 09:52:21">]>

irb(main):002:0> Subject.search("Third").visible
  Subject Load (0.4ms)  SELECT "subjects".* FROM "subjects" WHERE (name LIKE '%Third%') AND "subjects"."visible" = ? LIMIT ?  [["visible", 1], ["LIMIT", 11]]
=> #<ActiveRecord::Relation [#<Subject id: 3, name: "Third Subject", position: 3, visible: true, created_at: "2020-11-20 09:51:59", updated_at: "2020-11-20 09:51:59">]>


'




























### The Layout //: Current

Adding [bootstrap](getbootstrap.com) to our project

Copy-paste the stylesheet `<link>` into your `<head>` before all other stylesheets to load our CSS.

```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
```

Insert these in to `<body>` section:

```html
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
```

#### Install SimpleForm: (Additional)

rails generate simple_form:install --bootstrap


### Questions View
### Answers View
### Summary


#### Install actionText

```bash
rails action_text:install
```

WYSIWYG Editor on your form\\'s rich text edit.


## 2.Models and Migrations

### Install & Configure

On macOS:


```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew install postgresql

ps -aef | grep postgres

postgres --version

brew services 
# If you happened to get error
rm /usr/local/var/postgres/postmaster.pid
launchctl load -w /usr/local/Cellar/postgresql/13.2_1/homebrew.mxcl.postgresql.plist 

# Start and Stop postgres manually.
pg_ctl -D /usr/local/var/postgres start
pg_ctl -D /usr/local/var/postgres stop

# Start and Stop postgres brew way.
brew services start postgres
brew services stop postgres
brew services restart postgresql


initdb /usr/local/var/postgres

# Run psql with specified port and hostname
psql -p 5432 -h localhost

# create and drop DB

createdb mydatabasename
dropdb mydatabasename

createdb revenue

psql mydatabasename

# Exit the psql prompt using `CTRL + d`

CREATE DATABASE mydatabasename;
DROP DATABASE mydatabasename;

# \list - List all of your actual databases.
# \c mydatabasename - Connect to another database.
# \d - List the relations of your currently connected database.
# \d mytablename - Shows information for a specific table.


# plsql authentication system
# ---------------------------
# ident authentication uses the operating system's identification server running at TCP port 113 to verify the user's credentials.

# peer authentication on the other hand, is used for local connections and verifies that the logged in username of the operating system matches the username for the Postgres database.

sudo -u postgres psql
# or
sudo -u postgres psql template1

# If you receive an authentication error when attempting to connect to the psql client, you may need to alter the Postgres authentication config file (pg_hfa.conf).

find / -name pg_hba.conf
subl /usr/local/var/postgres/pg_hba.conf
# Add a Line like this, save and exit.
local all postgres peer

psql template1

template1-# CREATE USER postgres PASSWORD 'NewTamperedPassword'
ALTER ROLE postgres PASSWORD 'NewTamperedPassword'
template1-# ALTER ROLE
template1-# \q


export POSTGRES_HOST=localhost
export POSTGRES_PORT=5432
export POSTGRES_DB=dev_emaildb
export POSTGRES_USER=i072278
export POSTGRES_PASSWORD='NewTamperedPassword'

# For Django App:
DATABASES = {
  'default': {
    'ENGINE': 'django.db.backends.postgresql_psycopg2',
    'NAME': 'yourproject',
    'USER': 'yourprojectuser',
    'PASSWORD': 'NewTamperedPassword',
    'HOST': 'localhost',
    'PORT': '',
    }
  }

# Available Commands:
ABORT                            ALTER TEXT SEARCH TEMPLATE       CREATE PUBLICATION               DROP FUNCTION                    IMPORT FOREIGN SCHEMA
  ALTER AGGREGATE                  ALTER TRIGGER                    CREATE ROLE                      DROP GROUP                       INSERT
  ALTER COLLATION                  ALTER TYPE                       CREATE RULE                      DROP INDEX                       LISTEN
  ALTER CONVERSION                 ALTER USER                       CREATE SCHEMA                    DROP LANGUAGE                    LOAD
  ALTER DATABASE                   ALTER USER MAPPING               CREATE SEQUENCE                  DROP MATERIALIZED VIEW           LOCK
  ALTER DEFAULT PRIVILEGES         ALTER VIEW                       CREATE SERVER                    DROP OPERATOR                    MOVE
  ALTER DOMAIN                     ANALYZE                          CREATE STATISTICS                DROP OPERATOR CLASS              NOTIFY
  ALTER EVENT TRIGGER              BEGIN                            CREATE SUBSCRIPTION              DROP OPERATOR FAMILY             PREPARE
  ALTER EXTENSION                  CALL                             CREATE TABLE                     DROP OWNED                       PREPARE TRANSACTION
  ALTER FOREIGN DATA WRAPPER       CHECKPOINT                       CREATE TABLE AS                  DROP POLICY                      REASSIGN OWNED
  ALTER FOREIGN TABLE              CLOSE                            CREATE TABLESPACE                DROP PROCEDURE                   REFRESH MATERIALIZED VIEW
  ALTER FUNCTION                   CLUSTER                          CREATE TEXT SEARCH CONFIGURATION DROP PUBLICATION                 REINDEX
  ALTER GROUP                      COMMENT                          CREATE TEXT SEARCH DICTIONARY    DROP ROLE                        RELEASE SAVEPOINT
   
    ALTER INDEX                      COMMIT                           CREATE TEXT SEARCH PARSER        DROP ROUTINE                     RESET
  ALTER LANGUAGE                   COMMIT PREPARED                  CREATE TEXT SEARCH TEMPLATE      DROP RULE                        REVOKE
  ALTER LARGE OBJECT               COPY                             CREATE TRANSFORM                 DROP SCHEMA                      ROLLBACK
  ALTER MATERIALIZED VIEW          CREATE ACCESS METHOD             CREATE TRIGGER                   DROP SEQUENCE                    ROLLBACK PREPARED
  ALTER OPERATOR                   CREATE AGGREGATE                 CREATE TYPE                      DROP SERVER                      ROLLBACK TO SAVEPOINT
  ALTER OPERATOR CLASS             CREATE CAST                      CREATE USER                      DROP STATISTICS                  SAVEPOINT
  ALTER OPERATOR FAMILY            CREATE COLLATION                 CREATE USER MAPPING              DROP SUBSCRIPTION                SECURITY LABEL
  ALTER POLICY                     CREATE CONVERSION                CREATE VIEW                      DROP TABLE                       SELECT
  ALTER PROCEDURE                  CREATE DATABASE                  DEALLOCATE                       DROP TABLESPACE                  SELECT INTO
  ALTER PUBLICATION                CREATE DOMAIN                    DECLARE                          DROP TEXT SEARCH CONFIGURATION   SET
  ALTER ROLE                       CREATE EVENT TRIGGER             DELETE                           DROP TEXT SEARCH DICTIONARY      SET CONSTRAINTS
  ALTER ROUTINE                    CREATE EXTENSION                 DISCARD                          DROP TEXT SEARCH PARSER          SET ROLE
  ALTER RULE                       CREATE FOREIGN DATA WRAPPER      DO                               DROP TEXT SEARCH TEMPLATE        SET SESSION AUTHORIZATION
  ALTER SCHEMA                     CREATE FOREIGN TABLE             DROP ACCESS METHOD               DROP TRANSFORM                   SET TRANSACTION

 ALTER ROLE                       CREATE EVENT TRIGGER             DELETE                           DROP TEXT SEARCH DICTIONARY      SET CONSTRAINTS
  ALTER ROUTINE                    CREATE EXTENSION                 DISCARD                          DROP TEXT SEARCH PARSER          SET ROLE
  ALTER RULE                       CREATE FOREIGN DATA WRAPPER      DO                               DROP TEXT SEARCH TEMPLATE        SET SESSION AUTHORIZATION
  ALTER SCHEMA                     CREATE FOREIGN TABLE             DROP ACCESS METHOD               DROP TRANSFORM                   SET TRANSACTION
  ALTER SEQUENCE                   CREATE FUNCTION                  DROP AGGREGATE                   DROP TRIGGER                     SHOW
  ALTER SERVER                     CREATE GROUP                     DROP CAST                        DROP TYPE                        START TRANSACTION
  ALTER STATISTICS                 CREATE INDEX                     DROP COLLATION                   DROP USER                        TABLE
  ALTER SUBSCRIPTION               CREATE LANGUAGE                  DROP CONVERSION                  DROP USER MAPPING                TRUNCATE
  ALTER SYSTEM                     CREATE MATERIALIZED VIEW         DROP DATABASE                    DROP VIEW                        UNLISTEN
  ALTER TABLE                      CREATE OPERATOR                  DROP DOMAIN                      END                              UPDATE
  ALTER TABLESPACE                 CREATE OPERATOR CLASS            DROP EVENT TRIGGER               EXECUTE                          VACUUM
  ALTER TEXT SEARCH CONFIGURATION  CREATE OPERATOR FAMILY           DROP EXTENSION                   EXPLAIN                          VALUES
  ALTER TEXT SEARCH DICTIONARY     CREATE POLICY                    DROP FOREIGN DATA WRAPPER        FETCH                            WITH
  ALTER TEXT SEARCH PARSER         CREATE PROCEDURE                 DROP FOREIGN TABLE               GRANT
  
```


```bash

# Templated Email
rails g scaffold Email source:text, bcc_addr:text, cc_addr:text, to_addr:text, htmlbody:text, textbody:text, subject:text, reply_to_addr:text, template_id:text

# Template
rails g scaffold EmailTemplate template_name:text, subject_part:text, text_part:text, html_part:text

$ rails db:migrate

rails aborted!
SyntaxError: /Users/i072278/Dev/ruby/rails/cronusui/db/migrate/20201110122139_create_email_templates.rb:4: syntax error, unexpected '\n', expecting '.' or &. or :: or '['

# Remove the all the commas(,) after `t.text,`

class CreateEmailTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :email_templates do |t|
      t.text, :template_name
      t.text, :subject_part
      t.text, :text_part
      t.text :html_part

      t.timestamps
    end
  end
end

# Then it looks like this:
class CreateEmailTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :email_templates do |t|
      t.text :template_name
      t.text :subject_part
      t.text :text_part
      t.text :html_part

      t.timestamps
    end
  end
end

#Now run db:migration
rails db:migrate

# Create a method called

def down
  drop_table :emails
end
# Run this migration:down to delete the table
rake db:migrate:down VERSION=20201114034358

# Change `def change` to `def up` then run this migration to create table.
rake db:migrate:up VERSION=20201114034358


```

###
###
Models and Migrations:
Views to Models

#### Model/Resource



```bash
# Difference between model, resource and scaffold *
# rails g scaffold question email:string, body:text
rails g model question email:string, body:text

# It adds RESTFUL Routes to work with the model
rails g resource question email:string, body:text



```


### Migration


```bash
# created under db/migrate/20201115043553_create_questions.rb
# `add null: false to each columns`
class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string, :email, null: false
      t.text :body, null: false

      t.timestamps, null: false
    end
  end
end

# To create the table

rake db:migrate


```

### Rails Console

```bash
# Now insert some data to the table via Rails Console

Question.create email: 'sirajudheenam@gmail.com', body: 'How old is the Milky Way?'

rails console

irb(main):001:0> Question.create email: 'samer.buna@gmail.com', body: 'How old is the universe?'
   (1.1ms)  SELECT sqlite_version(*)
   (0.1ms)  begin transaction
  Question Create (0.9ms)  INSERT INTO "questions" ("email", "body", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["email", "samer.buna@gmail.com"], ["body", "How old is the universe?"], ["created_at", "2020-11-15 05:41:51.288867"], ["updated_at", "2020-11-15 05:41:51.288867"]]
   (1.8ms)  commit transaction
=> #<Question id: 1, email: "samer.buna@gmail.com", body: "How old is the universe?", created_at: "2020-11-15 05:41:51", updated_at: "2020-11-15 05:41:51">
irb(main):003:0>

irb(main):002:0> Question.create email: 'sirajudheenam@gmail.com', body: 'How old is the Milky Way?'
   (0.1ms)  begin transaction
  Question Create (0.8ms)  INSERT INTO "questions" ("email", "body", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["email", "sirajudheenam@gmail.com"], ["body", "How old is the Milky Way?"], ["created_at", "2020-11-15 06:10:32.059170"], ["updated_at", "2020-11-15 06:10:32.059170"]]
   (2.6ms)  commit transaction
=> #<Question id: 2, email: "sirajudheenam@gmail.com", body: "How old is the Milky Way?", created_at: "2020-11-15 06:10:32", updated_at: "2020-11-15 06:10:32">
irb(main):003:0>

irb(main):001:0> Question.create email: 'samer@on-site.com', body: 'How is universe created ?'
   (2.5ms)  SELECT sqlite_version(*)
   (0.2ms)  begin transaction
  Question Create (1.4ms)  INSERT INTO "questions" ("email", "body", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["email", "samer@on-site.com"], ["body", "How is universe created ?"], ["created_at", "2020-11-15 07:50:19.100704"], ["updated_at", "2020-11-15 07:50:19.100704"]]
   (2.8ms)  commit transaction
=> #<Question id: 3, email: "samer@on-site.com", body: "How is universe created ?", created_at: "2020-11-15 07:50:19", updated_at: "2020-11-15 07:50:19">


Question.create email: 'samer@on-site.com', body: 'How did the moon got formed ?'

# Count Number of records we have in our table.

irb(main):005:0> Question.count
   (0.2ms)  SELECT COUNT(*) FROM "questions"
=> 2

```
Make the changes in `home_controller.rb` file to assign `Question.all` to a instance variable
All instance variable is accessible in views
```ruby
class HomeController < ApplicationController
  def index
    @questions = Question.all
  end

  def about

  end
end
```

Make the changes in the `index.html.erb` file:

```ruby
<div class="well">
  <h4>The Universe is totality of everything that exists, has existed, or will exist </h4>
  <p>This Q&amp;A site is dedicated to questions about the history of the Universe</p>
</div>
  <div class="media">
    <div class="media-left">
      <a href="#">
        <img class="media-object" src="<%= q.gravatar %>">
      </a>
    </div>
    <div class="media-body">
      <h4 class="media-heading"> user@email.com asked:</h4>
      Dolor pariatur voluptate irure esse officia ut elit in voluptate quis veniam culpa in ea pariatur dolore pariatur officia reprehenderit in veniam reprehenderit sint do veniam sit culpa ut id dolore id fugiat laborum ex nulla cupidatat.
      <a href="/questions/12" class="btn btn-success btn-xs">View Answers </a>
    </div>
  </div>

```
```ruby
<div class="well">
  <h4>The Universe is totality of everything that exists, has existed, or will exist </h4>
  <p>This Q&amp;A site is dedicated to questions about the history of the Universe</p>
</div>

<div class="container">
  <%= @questions.each do |q| %>
    <div class="media">
      <div class="media-left">
        <a href="#">
          <!-- <img class="media-object" src="http://www.gravatar.com/avatar/99b88146e2bd8306a9c61375f2fd30ec?s=48&d=identicon">  -->
        </a>
      </div>
      <div class="media-body">
        <h4 class="media-heading"> <%= q.email %> asked:</h4>
        <%= q.body %>
        <a href="/questions/12" class="btn btn-success btn-xs">View Answers </a>
      </div>
    </div>
  <% end %>
```

Go to `models/question.rb` and add a method to provide gravatar URL.

```ruby
class Question < ApplicationRecord
  def gravatar
    "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}"
  end
end
```


### Few improvements
1. List the questions displayed in recent order

```ruby
class HomeController < ApplicationController
  def index
    @questions = Question.order(created_at: :desc).all
  end

  def about

  end
end
```

2. Add created at next to the question body `views/home/index.html.erb` file

```ruby
      <div class="media-body">
        <h4 class="media-heading"> <%= q.email %> asked:</h4>
        <%= q.body %>
        <%= q.created_at %>
        <a href="/questions/12" class="btn btn-success btn-xs">View Answers </a>
      </div>
```

3. Add human readable format to the field created_at using ruby helpers

```ruby
      <div class="media-body">
        <h4 class="media-heading"> <%= q.email %> asked:</h4>
        <%= q.body %>
        <%= time_ago_in_words q.created_at %> ago <br />
        <a href="/questions/12" class="btn btn-success btn-xs">View Answers </a>
      </div>
```

##Asking Quetion:

### Remove temporary routes from `routes.rb` file

```ruby
# Remove these entries from there as `resources :questions` can handle it well as we connected to a database table.
  post '/questions' => 'home#temp'
  post '/answers' => 'home#temp'

  get 'questions/:id' => 'home#question'
  get 'answers/:id' => 'home#answer'

Rails.application.routes.draw do
  resources :questions
  root to: 'home#index'
  get 'home/index'

  # post '/questions' => 'home#temp'
  # post '/answers' => 'home#temp'

  # get 'questions/:id' => 'home#question'
  # get 'answers/:id' => 'home#answer'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
```

ActiveRecord Methods
Reading Data from the views
Instance variables
Gravatars

Working with Data
View Helpers

### Submitting Data in forms

```ruby

# Change the controllers/questions_controller.rb file
class QuestionsController < ApplicationController
  def create
    # Question.create(params[:question])
    Question.create(question_params)

    redirect_to root_path
  end

  private
    def question_params
      params.require(:question).permit(:email, :body)
    end
end
```

Create new question using the following:

Email: samer.buna+g@gmail.com
Question: Which formed first, star or galaxies ?

Check the browser Output after refreshing.

Move the file `question.html.erb` to its own folder `view/questions` and rename the file
`question.html.erb` to `show.html.erb`.



Change the `index.html.erb` to show the real questions

```html
<a href="/questions/12" class="btn btn-success btn-xs">View Answers </a>
```

to

```ruby
<a href="<%= question_path(q) %>" class="btn btn-success btn-xs">View Answers </a>
```

the full page appears as below:

```ruby
<div class="well">
  <h4>The Universe is totality of everything that exists, has existed, or will exist </h4>
  <p>This Q&amp;A site is dedicated to questions about the history of the Universe</p>
</div>


<div class="container">
  <%= @questions.each do |q| %>
    <div class="media">
      <div class="media-left">
        <a href="#">
          <img class="media-object" src="<%= q.gravatar %>">
        </a>
      </div>
      <div class="media-body">
        <h4 class="media-heading"> <%= q.email %> asked:</h4>
        <%= time_ago_in_words q.created_at %> ago<br />
        <%= q.body %>
        <a href="<%= question_path(q) %>" class="btn btn-success btn-xs">View Answers </a>
      </div>
    </div>
  <% end %>
</div>


<%= render 'home/new_question_form' %>
```
Add `show` method to the `QuestionsController` by editing the file `app/controllers/questions_controller.rb`

```ruby

  def show
    @question = Question.find(params[:id])
  end
# the file looks like this:

class QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
  end
  def create
    # Question.create(params[:question])
    Question.create(question_params)
  end

  private
    def question_params
      params.require(:question).permit(:email, :body)
    end
end
```
Change the `views/questions/show.html.erb` to show the real questions

```ruby
  <div class="lead well">
    <div class="media">
      <div class="media-left">
        <a href="#">
          <img class="media-object" src="<%= @question.gravatar %>">
        </a>
      </div>
      <div class="media-body">
        <h4 class="media-heading"><%= @question.email %> asked:</h4>
        <%= @question.body %>
      </div>

    </div>
  </div>
```

Let us generate answers resource so that when you create an answer for a question it gets saved:

```ruby
rails g resource answer question_id:integer email:string body:text
```
Result should look like:

```bash
rails g resource answer question_id:integer email:string body:text
Running via Spring preloader in process 49166
      invoke  active_record
      create    db/migrate/20201115142317_create_answers.rb
      create    app/models/answer.rb
      invoke    test_unit
      create      test/models/answer_test.rb
      create      test/fixtures/answers.yml
      invoke  controller
      create    app/controllers/answers_controller.rb
      invoke    erb
      create      app/views/answers
      invoke    test_unit
      create      test/controllers/answers_controller_test.rb
      invoke    helper
      create      app/helpers/answers_helper.rb
      invoke      test_unit
      invoke    assets
      invoke      scss
      create        app/assets/stylesheets/answers.scss
      invoke  resource_route
       route    resources :answers
```
```bash
rake routes
               Prefix   Verb     URI Pattern                    Controller#Action
              answers   GET       /answers(.:format)             answers#index
                        POST      /answers(.:format)             answers#create
           new_answer   GET       /answers/new(.:format)         answers#new
          edit_answer   GET       /answers/:id/edit(.:format)    answers#edit
               answer   GET       /answers/:id(.:format)         answers#show
                        PATCH     /answers/:id(.:format)         answers#update
                        PUT       /answers/:id(.:format)         answers#update
                        DELETE    /answers/:id(.:format)         answers#destroy
            questions   GET       /questions(.:format)           questionsindex
                        POST      /questions(.:format)           questions#create
         new_question   GET       /questions/new(.:format)       questions#new
        edit_question   GET       /questions/:id/edit(.:format)  questions#edit
             question   GET       /questions/:id(.:format)       questions#show
                        PATCH     /questions/:id(.:format)       questions#update
                        PUT       /questions/:id(.:format)       questions#update
                        DELETE    /questions/:id(.:format)       questions#destroy
                 root   GET       /                              home#index
           home_index   GET       /home/index(.:format)          home#index
```
Migrate answers model using `rake db:migrate`

```ruby
rake db:migrate
[Simple Form] Simple Form is not configured in the application and will use the default values. Use `rails generate simple_form:install` to generate the Simple Form configuration.
== 20201115142317 CreateAnswers: migrating ====================================
-- create_table(:answers)
   -> 0.0030s
== 20201115142317 CreateAnswers: migrated (0.0031s) ===========================
```
Add a method to handle strong parameters  and `create` method  for the `AnswerController` on the file `controllers/answer_controller.rb`

```ruby
class AnswersController < ApplicationController
  def create
    Answer.create(answer_params)
  end
  private

  def answer_params
    params.require(:answer).permit(:question_id, :email, :body)
  end
end
```
Change the `name` of the `input` and `textarea` for the answer form in the file `views/home/_new_answer.html.erb`

`<input name="answer[email]" type="email" class="form-control" id="inputEmail" placeholder="Email" required>`

`<textarea name="answer[body]" class ="form-control" id="inputAnswer" placeholder="Write your answer here.." required></textarea>`

Also add a hidden value to be sent which is the `question_id` of the answer we are sending to save in the table just below the `<% form_for %>` line.

`<input type="hidden" name="answer[question_id]" value="<%= @question.id %>">`

The snippet of the changed file is shown below:

```ruby
<%= form_for :answer, url: '/answers', html: { class: 'form-horizontal' } do %>
<input type="hidden" name="answer[question_id]" value="<%= @question.id %>">
<div class="modal-body">

  <div class="form-group">
    <label for="inputEmail" class="col-sm-2 control-label">Email:</label>
    <div class="col-sm-10">
      <input name="answer[email]" type="email" class="form-control" id="inputEmail" placeholder="Email" required>
    </div>
  </div>

  <div class="form-group">
    <label for="inputAnswer" class="col-sm2 control-label" >Answer:</label>
    <div class="col-sm-10">
      <textarea name="answer[body]" class ="form-control" id="inputAnswer" placeholder="What is your answer?" required></textarea>
    </div>
  </div>

</div>

<div class="modal-footer">
  <button class="btn btn-alert" data-dismiss="modal" aria-hidden="true">Cancel</button>
  <button class="btn btn-primary" type="submit">Submit</button>
</div>

<% end %>
```



Reading the logs
Strong Parameters
URL Helpers

### Relationships:

Improvements:

1. We actually need to redirect the user to the question page upon successfully saving an answer

2. We also need to verify whether we have a question in the database to which we are adding an answer.

In order to do that we need to establish relationship between question and answer.

A Question has many Answers.
An answer has a Question.

### has_many / belongs_to Relationships:

On the Answer ActiveRecord (`app/models/question.rb`), add the relationship `has_many :answer`

Each Question has many answers
```ruby
class Question < ApplicationRecord

  has_many :answers

  def gravatar
      "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}"
  end
end
```

On the Answer ActiveRecord (`app/models/answer.rb`), add the relationship `belongs_to :question`
```ruby
class Answer < ApplicationRecord
  belongs_to :quetion

  def gravatar
      "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}"
  end
end
```
On the AnswersController, let us add a local variable `question` to find a question from the DB.

```ruby
class AnswersController < ApplicationController
  def create
    question = Question.find(params[:answer][:question_id])
    Answer.create(answer_params)
```
Once we have a question, we can redirect the user to the question page upon creating answer.

```ruby
class AnswersController < ApplicationController
  def create
    question = Question.find(params[:answer][:question_id])
    Answer.create(answer_params)
    redirect question_path
    # or simply
    # redirect question
```
We can also simplify the create method to save the answer to the question.

```ruby
class AnswersController < ApplicationController
  def create
    question = Question.find(params[:answer][:question_id])
      # Answer.create(answer_params)
      # instead of the above
      question.answers.create(answer_params)
      #redirect question_path
      # or simply
      redirect question
  end
  private

  def answer_params
    params.require(:answer).permit(:question_id, :email, :body)
  end
end
```
Test on the browser and the logs if it is creating answer for the question and redirecting to the question page afterwards.


samer@codinghouse.cc


Ordering (Sorting)


DRY - Don't Repeat Yourself:
```ruby
def gravatar
    "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}"
end
```

This method `gravatar` is defined both on Answer and Question ActiveRecord Classes.
Let us move that method to its own module under `app/models/concerns/has_gravatar.rb`.

```ruby
#app/models/concerns/has_gravatar.rb
module HasGravatar
  def gravatar
      "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}"
  end
end
```

On `question.rb` and `answer.rb` files under `models` just add a line to include HasGravatar method.


```ruby
class Answer < ApplicationRecord
  include HasGravatar

  belongs_to :quetion
end
```



Shared methods


## 3.ActionMailer and ActiveJob

Informative UI

```ruby
rails console

Answer.count
Question.count
Answer.delete_all
Question.delete_all
```

Improving the pages by showing a message to say that be the first one to ask or answer if the question or answer list is empty

```ruby
# on questions/show.html.erb where we listed our individual questions along with answers
<% if @answers.empty? %>
  <div class="alert alert-info">No Answers yet, Wanna be the first to answer?</div>
<% end %>
```


```ruby
# on home/index.html.erb where we listed all questions
<% if @questions.empty? %>
  <div class="alert alert-info">No Questions yet, Wanna be the first to ask?</div>
<% end %>
```

Sessions:


Whenever user asks a question or answers to a question, based on the email address, we can create a session (cookie) to identify the user.

```ruby
# controllers/question_controller.rb
class QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
    # preparing the view ordered by when it is created.
    @answers = @question.answers.order(created_at: :desc)
  end
  def create
    # Question.create(params[:question])
    Question.create(question_params)
    ## Add this line here.
    session[:current_user_email] = question_params[:email]

    redirect_to root_path
  end

  private
    def question_params
      params.require(:question).permit(:email, :body)
    end
end
# controllers/question_controller.rb

class AnswersController < ApplicationController
  def create
    question = Question.find(params[:answer][:question_id])
      # Answer.create(answer_params)
      # instead of the above
      question.answers.create(answer_params)

      ## Add this line here.
      session[:current_user_email] = answer_params[:email]

      #redirect question_path
      # or simply
      redirect_to question
  end
  private

  def answer_params
    params.require(:answer).permit(:question_id, :email, :body)
  end
end

```

```ruby
# To display / mention the current user on every page: `layouts/application.html.erb`

<%= render 'home/navbar' %>

<div class="well"><%= session[:current_user_email] || 'No email is saved' %> </div>

<%= yield %>
```

Let us try to add a question [Ask Question] to see if that user is remembered or not?

It is not a good practice to read emails directly on the view.

```ruby
# To display / mention the current user on every page: `layouts/application.html.erb`

<%= render 'home/navbar' %>
<!-- <div class="well"><%= session[:current_user_email] || 'No email is saved.' %> </div> -->
<div class="well"><%= current_user_email %> </div>

<%= yield %>
```
Put the implementation in a helper method.

```ruby
#app/helpers/application_helper.rb
module ApplicationHelper
  def current_user_email
    session[:current_user_email] || 'No email is saved.'
  end
end
```

Let us search for input which has email in it using `git grep` command

```bash
$ git grep input.*email
app/views/home/_new_answer_form.html.erb: <input name="answer[email]" type="email" class="form-control" id="inputEmail" placeholder="Email" required>
app/views/home/_new_question_form.html.erb: <input name="question[email]" type="email" class="form-control" id="inputEmail" placeholder="Email" required>

```

Add value (`value="<%= current_user_email %>"`) to those input `email` fields:

```ruby
# app/views/home/_new_answer_form.html.erb:
<input name="answer[email]" value="<%= current_user_email %>" type="email" class="form-control" id="inputEmail" placeholder="Email" required>
# app/views/home/_new_question_form.html.erb:
<input name="question[email]" value="<%= current_user_email %>" type="email" class="form-control" id="inputEmail" placeholder="Email" required>
```

Place this user information in the navbar

```ruby
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">

      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle Navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>

      <a class="navbar-brand" href="/">History of the Universe</a>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav navbar-right">
        <li> <div class="navbar-text"><%= current_user_email %></div> </li>
        <li><form><button type="button" class="btn btn-success navbar-btn bt-sm" data-toggle="modal" data-target="#new-question-modal">
          Ask a quetion</button></form></li>
      </ul>
    </div>
  </div>
</nav>
```

### Test Driven Development:

Send an email to the author of the question when an answer to the question is posted.

We use ActiveMailer to send email.

Let us generate a mailer

```bash
rails g mailer main_mailer notify_question_author
Running via Spring preloader in process 68406
      create  app/mailers/main_mailer.rb
      invoke  erb
      create    app/views/main_mailer
      create    app/views/main_mailer/notify_question_author.text.erb
      create    app/views/main_mailer/notify_question_author.html.erb
      invoke  test_unit
      create    test/mailers/main_mailer_test.rb
      create    test/mailers/previews/main_mailer_preview.rb
```

Let us look at the files needed for testing:

```ruby
#app/mailers/main_mailer.rb

class MainMailer < ApplicationMailer
  #define a method to notify author
  def notify_question_author(answer)

    @greeting = "Hi"
    @answer = answer
    mail to: answer.question.email, from: answer.email

  end
end
```

Let us create a test case for this `def notify_question_author(answer)` method

```ruby
#test/mailers/main_mailer_test.rb

require 'test_helper'

class MainMailerTest < ActionMailer::TestCase
  test "notify_question_author" do
    # create sample question and answer to test
    question = Question.create email: 'author@question.com', body: 'a test question'
    answer = Answer.create email: 'author@answer.com', body: 'a test answer'
    # add the answer to the question
    question.answers << answer
    # call the method and assign it to the variable mail
    mail = MainMailer.notify_question_author(answer)
    # we need to define the following answer text somewhere (config/locales/en.yml), so it doesn\'t fail
    assert_equal "New answer to your question", mail.subject
    # assign mail.to, mail.from and mail.body
    assert_equal [question.email], mail.to
    assert_equal [answer.email], mail.from
    assert_match answer.body, mail.body.encoded
  end

end

```
Let us define the subject in the `config/locales/en.yml` file

```yaml
#config/locales/en.yml
en:
  hello: "Hello world"

  main_mailer:
    notify_question_author:
      subject: "New answer to your question"
```
Let us change the body we sent on the file `app/views/main_mailer/notify_question_author.text.erb`

```html
<!--#app/views/main_mailer/notify_question_author.text.erb -->

<%= @greeting %>

My answer:

<%= @answer.body %>

```

On the `app/views/main_mailer/notify_question_author.html.erb`

```html
<!--#app/views/main_mailer/notify_question_author.html.erb -->
<%= @greeting %>

<h3>My answer: </h3>
<p>
<%= @answer.body %>
</p>

```

Let us run the test:
$ rake test

#### Implement to send emails upon creating an answer:

In the AnswerController add this code:

```ruby
class AnswersController < ApplicationController
	def create
		question = Question.find(params[:answer][:question_id])
	    answer = question.answers.create(answer_params)
			MainMailer.notify_question_author(answer).deliver_now
```


### Email Previews:
Under `test/mail/previews/main_mailer_preview.rb`

```ruby
# test/mail/previews/main_mailer_preview.rb

class MainMailerPreview < ActionMailer::Preview
  def notify_question_author
    question = Question.create email: 'author@question.com', body: 'a test question'
    answer = Answer.create email: 'author@answer.com', body: 'a test answer'

    question.answers << answer
    mail = MainMailer.notify_question_author(answer)
  end
end
```
Preview the emails at http://localhost:3000/rails/mailers/main_mailer/notify_question_author

Everytime it tests, it creates an answer. Instead of creating the Answer on the main_mailer_test, we can use the first answer in the database to test.

```ruby
require 'test_helper'

class MainMailerTest < ActionMailer::TestCase
  test "notify_question_author" do
    MainMailer.notify_question_author(Answer.first)
    assert_equal "New answer to your question", mail.subject
    assert_equal [question.email], mail.to
    assert_equal [answer.email], mail.from
    assert_match answer.body, mail.body.encoded
  end

end
```
Let us delete all questions and answers:

```ruby
irb(main):006:0> Question.delete_all
  Question Destroy (2.7ms)  DELETE FROM "questions"
=> 16
irb(main):008:0> Answer.delete_all
  Answer Destroy (3.5ms)  DELETE FROM "answers"
=> 12
```

### ActiveJob and Sucker Punch:

In order to set up a job in the background

deliver_now
deliver_later

ActiveJob needs a backend to do the active Jobs.

We shall use Sucker Punch adapter

Sucker Punch is a single-process Ruby asynchronous processing library.

Under config/initializers/sucker_punch.rb

Rails.application.configure do
  config.active_job.queue_adapter = :sucker_punch
end

Add the following file in the Gemfile:


`gem 'sucker_punch', '~> 2.0'`


bundle


```ruby
#app/mailers/main_mailer.rb

class MainMailer < ApplicationMailer
  #define a method to notify author
  def notify_question_author(answer)

    # to simulate the delay; sucker_punch handles this as background job after 5 seconds so no delay in further process and response to user will be swift.
    sleep 5

    @greeting = "Hi"
    @answer = answer
    mail to: answer.question.email, from: answer.email

  end
end
```

Look at the logs as ActiveJob will deliver the email after 5 seconds.



## 4.Basics of the AssetPipeline

CSS / Sass

Select the media object of the questions
each question is a media object
let us add some media style.

```scss
.media {
  border: thin solid #ddd;
  padding: 1em;
  border-radius: 10px;
  background-color: #eee;
}

```

Click in inspector stylesheet on the Chrome developer tools, then copy the scss

under assets/stylesheets/home.scss, add these lines

```scss
.media {
  border: thin solid #ddd;
  padding: 1em;
  border-radius: 10px;
  background-color: #eee;
}

```
under app/views/home.html.erb, let us wrap these questions in to another <div> call it as `box`.

```ruby
<div class="container">
  <div class="boxes"> ## add this
    <%= @questions.each do |q| %>
      <div class="media">
        <div class="media-left">
          <a href="#">
            <img class="media-object" src="<%= q.gravatar %>">
          </a>
        </div>
        <div class="media-body">
          <h4 class="media-heading"> <%= q.email %> asked:</h4>
          <div> <%= time_ago_in_words q.created_at %> ago</div>
          <%= q.body %>
          <a href="<%= question_path(q) %>" class="btn btn-success btn-xs">View Answers </a>
        </div>
      </div>
    <% end %>
  </div> ## add this
</div>
```
After nesting the media in to boxes, our scss looks like this:

```scss
.boxes {
  .media {
    border: thin solid #ddd;
    padding: 1em;
    border-radius: 10px;
    background-color: #eee;
  }
}
```

```scss
.boxes {
  .media {
    border: thin solid #ddd;
    ....
  }
  ... # you can also nest more stuff here
}
```
Let us move the time in to the corner:

Add a class name to the div which contains the time. `class="time"`
```ruby
  <div class="media-body">
    <h4 class="media-heading"> <%= q.email %> asked:</h4>
    <div class="time"> <%= time_ago_in_words q.created_at %> ago</div>
    <%= q.body %>
    <a href="<%= question_path(q) %>" class="btn btn-success btn-xs">View Answers </a>
  </div>
```

Add a style to it:

.time {
  position: absolute;
  top: 8;
  right: 8;
  color: #666;
}

Then make the parent element position to be relative

.media {

}

Now our new css looks like this:

```scss
.boxes {
  .media {
    border: thin solid #ddd;
    padding: 1em;
    border-radius: 10px;
    background-color: #eee;
    position: relative;
    .time {
      position: absolute;
      top: 8;
      right: 8;
      color: #666;
    }
  }
}
```

Let us place the `View answers` to bottom right.


```scss
.boxes {
  .media {
    border: thin solid #ddd;
    padding: 1em;
    border-radius: 10px;
    background-color: #eee;
    position: relative;
    .time {
      position: absolute;
      top: 8;
      right: 8;
      color: #666;
    }
    .a.btn {
      position: absolute;
      bottom: 8;
      right: 8;
      color: #666;
    }
  }
}
```
We can only click View answers to see answers. now we can add the whole question div media object is clickable using JavaScript.

We need to make the section hover on the element changes the color and mouse pointer so that it appears as a link.

```scss
.media:hover {
  cursor: pointer;
  background-color: #ddd ;

}

```

```scss
.boxes {
  .media {
    border: thin solid #ddd;
    padding: 1em;
    border-radius: 10px;
    background-color: #eee;
    position: relative;
    .time {
      position: absolute;
      top: 8;
      right: 8;
      color: #666;
    }
    .a.btn {
      position: absolute;
      bottom: 8;
      right: 8;
      color: #666;
    }
    &hover: {
      cursor: pointer;
      background-color: #ddd ;
    }
  }
}
```

If you view under assets in the Chrome dev tools, you can see sass is complied in to normal css.


###CoffeeScript

Just make this link (View Answers) available to the div media section.

`<div class="media" data-taget="<%= question_path(q) %>">`


```ruby
<div class="container">
  <div class="boxes"> ## add this
    <%= @questions.each do |q| %>
      <div class="media" data-taget="<%= question_path(q) %>">
        <div class="media-left">
          <a href="#">
            <img class="media-object" src="<%= q.gravatar %>">
          </a>
        </div>
        <div class="media-body">
          <h4 class="media-heading"> <%= q.email %> asked:</h4>
          <div> <%= time_ago_in_words q.created_at %> ago</div>
          <%= q.body %>
          <a href="<%= question_path(q) %>" class="btn btn-success btn-xs">View Answers </a>
        </div>
      </div>
    <% end %>
  </div> ## add this
</div>
```

Add the script

app/javascripts/home.coffee

```coffee
# coffee function ready

ready = ->
  console.log(ready)

# loading the coffee script on document ready.

$(document).ready(ready)

# load it on page:load
# if you are using turbolinks.

$(document).on "page:load", ready
```

Improvements:

```coffeescript
ready = ->
  $(".media").on "click", ->
  document.location = $(this).data("target")
  return false

$(document).ready(ready)

$(document).on "page:load", ready
```


On new question form, to focus the cursor on the text field, we shall write a CoffeeScript.

//Grab the model and listen to shown event of the model

```coffeescript
ready = ->
  $(".media").on "click", ->
  document.location = $(this).data("target")
  return false

  $(".modal").on "shown.bs.modal", ->
    $(this).find("textarea").focus() 

$(document).ready(ready)

$(document).on "page:load", ready
```

###Production Mode

config/secrets.yml

In order to create secrets, just run `rails secret` and copy the content to `config/secrets.yml`.

```bash
echo "export SECRET_KEY_BASE=30a0df90351e68b6367f2264c51758710b2f6fe84744946a072ebf473ee70f5f4c21cce0d3900294ad5626b96fb2440209ceb46aff32644440d03636a4b91c48" >> ~/.bashrc
```

```yml
#config/secrets.yml
development:
  secret_key_base: 26261945d78a62842c2ee50328247146c02e553b445db3d623ab83d6701b9a5dd19f8bef9cb35b6f0bf35288b5e37e8dba7432b3463f3c20f3b7be6fe2274a0b
test:
  secret_key_base: ce74341dd7b78b8491af145e992cad3d098752a389587e7ca340f2a4781434ac477a60bb6cf6e5e11e98f87d3008deed0bb593911ea5914bd69f9d6816639369 
# Do not keep production secrets in the repository,
# instead read values from the environment.
production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
```

###Compile, combine and minify

```bash
export RAILS_SERVE_STATIC_FILES=true

rake assets:precompile

# To minify the assets in production, 
RAILS_ENV=production rake assets:precompile

# Copy the database file from `db/development.sqlite3` to `db/production.sqlite3`
cp db/development.sqlite3 db/production.sqlite3


# To run the server in production mode
rails server -e production
```

-- RESUME FROM HERE ---



Small screen

Truncate the body length to 300 characters to fit small screens:

```ruby
<%= truncate q.body, length: 300 %>
```

To remove the time and view answers button on the small screen but it appears on bigger screen:

```ruby
<div class="time hidden-xs"> <%= time_ago_in_words q.created_at %> ago</div>
  <%= truncate q.body, length: 300 %>
<div class="hidden-xs">
  <a href="<%= question_path(q) %>" class="btn btn-success btn-xs">View Answers </a>
</div>
...
```

<head>

<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

</head>

## 5.Deployment

[5.1 Heroku Tools](#1-heroku-tools)

Heroku toolbelt installation

heroku create

The above heroku create will create a new remote called `heroku` . You need to push your code to this remote to get your code working on heroku environment.

```
git remote -v
heroku https://git.heroku.com/secure-tantra-2349.git(fetch)
heroku https://git.heroku.com/secure-tantra-2349.git(push)
```

You need to push to heroku's git remote to push your changes.

[5.2 Gemfile](#2-gemfile)

Move `sqlite3` gem to developement group and add `pg` and `rails_12factor` gems in to production group.

`rails_12factor` gem is heroku specific.

```ruby
group :development, :test do
  ...
  gem 'sqlite3'
end 

group :production do
  gem 'pg'
  gem 'rails_12factor'
end 
```

[5.3 PostGresSQL](#3-postgressql)

If you see errors, first run:
bundle --without-production

[5.4 Quick deployment](#4-quick-deployment)

```bash
# Push your changes to heroku
git push heroku master
# Migrate the local db on heroku
heroku run rake db:migrate
# To view the deployed app on a browser:

heroku open

heroku logs --tail

heroku config 

heroku config:set TEST=1

# to view the console
heroku run rails console

# this is equivalent to rake db:console
heroku pg:psql

# \dt 
#\d questions
# select * from questions 

heroku pg:info
```

### 1 Heroku Tools
### 2 Gemfile

```ruby
# install rails which is compatible with 5.0. e.g., 5.1 would be OK but 6.0 is not OK.
gem 'saas-rails', '~> 5.0'

# run bundle update to update gems
bundle update

# run git diff to see the changes

git diff

# the below will update to 4.2.1 , if available but not 4.3
gem 'rails', '~> 4.2.0'

gem 'rails', :github 'rails/rails'

gem 'arel', :github 'rails/arel'

#once you updated gems, try to run tests

bundle update

rake test

rvm install '2.2.1'

rbenv install '2.2.1'
```

### 3 PostGresSQL
### 4 Quick deployment

Summary:


Mockup / BootStrap
MVC (Models / Views / Controllers)
Migrations and PostGreSQL
Conventions / DRY
	- Conventions over Configuration
	- Don't Repeat Yourself
Rail generators, routes and helpers
ActiveMailer & ActiveJob
Test Driven Development & Continuous Integration
SaSS & CoffeeScript
Asset Pipeline
Gemfile /Bundler
Heroku

```bash
$ heroku <TAB><TAB>                 # Command completion
$ heroku apps:info --<TAB><TAB>     # Flag completion
$ heroku apps:info --app=<TAB><TAB> # Flag option completion

printf "$(heroku autocomplete:script bash)" >> ~/.bashrc; source ~/.bashrc

```
--------------

# Configure cronus

rails generate scaffold email
rails generate scaffold email_template

rake db:migrate RAILS_ENV=development


Passenger Installation with Nginx:

gem install passenger

passenger-install-nginx-module

https://www.phusionpassenger.com/library/deploy/nginx/deploy/

http://ruby-journal.com/how-to-setup-rails-app-with-puma-and-nginx/

puma port 3000 opening on ubuntu:

sudo apt install net-tools
sudo netstat -tunlp

sudo netstat -tnlp | grep :3000

sudo ufw allow from any to any port 3000 proto tcp

lsof -iTCP -P -n


sudo -i -u postgres

sudo -u postgres psql

---------

Make your own Gem:

```ruby
#create a new gem
bundle gem coolgem

# copy your source code to coolgem/lib/coolgem

# add your files in your 
cd coolgem/lib/coolgem

bundle exec irb
irb> require_relative lib/coolgem
=> true

cd coolgem
ls
rake build

# other commands
rake install
build and deploy on rubygems.org
rake release 

#code_a.rb
puts "Code A"

#code_b.rb
require_relative 'code_a.rb'
puts "Code B"



```



------
Get header information from request

```ruby
logger.warn "*** BEGIN RAW REQUEST HEADERS ***"
self.request.env.each do |header|
  logger.warn "HEADER KEY: #{header[0]}"
  logger.warn "HEADER VAL: #{header[1]}"
end
logger.warn "*** END RAW REQUEST HEADERS ***"
```


-----------------------------------------------

# Using CoffeeScript in your app

On your Gemfile, include `gem 'coffee-rails'`

rails webpacker:install:coffee


layouts/application.html.erb
<%= javascript_pack_tag 'hello_coffee' %>

```bash


# Uncaught Error: Module build failed (from ./node_modules/coffee-loader/dist/cjs.js):
# TypeError: this.getOptions is not a function

# To solve it, I had to change the line in package.json (in root) from:

"coffee-loader": "^2.0.0",
to
"coffee-loader": "0.9.0",

npm cache clean

yarn install --check-files
```


# Remove precompiled assets from local directory

```ruby
rake assets:clean 

Removed ${HOME}/emailapp/public/packs/js/server_rendering-8ef97c52da7104b15550.js
Removed ${HOME}/emailapp/public/packs/js/server_rendering-8ef97c52da7104b15550.js.map
Removed ${HOME}/emailapp/public/packs/js/application-8d1e811b937f54311349.js
Removed ${HOME}/emailapp/public/packs/js/application-8d1e811b937f54311349.js.map
Removed ${HOME}/emailapp/public/packs/js/application-9afcbb5693aa87623e69.js
Removed ${HOME}/emailapp/public/packs/js/application-9afcbb5693aa87623e69.js.map
```
rake assets:precompile



gem 'barista'
gem 'therubyracer', :require => nil
gem 'jquery-rails'
bundle install
rails g barista:install
rails g jquery:install


gem install libv8 -v '3.16.14.19' --source 'https://rubygems.org/'


brew tap homebrew/versions
brew install v8-315
gem install libv8 -v '3.16.14.19' -- --with-system-v8

brew install v8@3.15
gem install therubyracer -- --with-v8-dir=/usr/local/opt/v8@3.15

# To fix "unmet peer dependency" warnings,
yarn upgrade 


# Install webpacker from scratch:
rails new myapp --webpack

gem 'webpacker', git: 'https://github.com/rails/webpacker.git'
yarn add https://github.com/rails/webpacker.git

bundle
bundle exec rails webpacker:install

# OR (on rails version < 5.0)
bundle exec rake webpacker:install
yarn upgrade
yarn install

app/packs folder

```bash
app/packs:
  ├── entrypoints:
  │   # Only Webpack entry files here
  │   └── application.js
  │   └── application.css
  └── src:
  │   └── my_component.js
  └── stylesheets:
  │   └── my_styles.css
  └── images:
      └── logo.svg
```

Use these tags: 

```
<%= javascript_pack_tag 'application' %>
<%= stylesheet_pack_tag 'application' %>
```

Or use the dedicated helper:
```
<%= image_pack_tag 'application.png', size: '16x10', alt: 'Edit Entry' %>
<%= image_pack_tag 'picture.png', srcset: { 'picture-2x.png' => '2x' } %>
```

If you want to create a favicon:

```
<%= favicon_pack_tag 'mb-icon.png', rel: 'apple-touch-icon', type: 'image/png' %>
```

If you want to preload a static asset in your <head>, you can use the preload_pack_asset helper:

```
<%= preload_pack_asset 'fonts/fa-regular-400.woff2' %>
```

If you want to use images in your stylesheets:

```
.foo {
  background-image: url('../images/logo.svg')
}
```

Use this for React-On-Rails https://github.com/shakacode/react_on_rails

========================================================================================================
========================================================================================================

# Rails Engine

# Rails Engines or formerly known as Plugins

Patrick Peak
Example plugins:
devise
Dummy Admin 

Building an Engine:

`rails plugin new rubypress --mountable`

Two kind of Engines
1. Mountable
2. ?


rails g resource Page name path content
(name path content) are strings


```ruby
# lib/rubypress/engine.rb
module Rubypress
  class Engine < ::Rails::Engine
    isolate_namespace Rubypress
  end
end
```

## Routing:

Multiple bucket of controllers

```ruby
#test/dummy/config/routes.rb
#main application routes
Rails.application.routes.draw do 
  mount Rubypress::Engine => '/rubypress'
  root to: 'welcome#index'
end
#config/routes.rb
#Engines routes
Rubypress::Engine.routes.draw  do 
  resources :pages
  root to: 'pages#index'
end
```

```ruby
# Route helpers
<%= main_app.root_url %>
# => /
<%= rubypress.root_url %>
# => /rubypress
<%= rubypress.page_path(@page) %>
# => /rubypress/pages/1

```

### A View from inside Engine
If you are inside the file in the Engine, then explicit mention is not required
```ruby
<%# app/views/layouts/rubypress/application.html.erb %>
<!DOCTYPE html>
<html>
<head>=
<body>
<%= link_to "Home Page", main_app.root_url %> |
<%= link_to "Add New Page", new_page_path %> |
<%= link_to "List Pages", pages_path %>
<%= yield %>
</body>
</html>
```

### A View from inside Engine
```ruby
<%# test/dummy/app/views/welcome/index.html.erb %>
<h1>Welcome to Ruby Press </h1>
<div>Things you can do:
<%= link_to "Home Page", root_url %><br/>
<%= link_to "Add New Page", rubypress.new_page_path %><br/>
<%= link_to "List Pages", rubypress.pages_path %><br/>
</div>
```

An Engine by any other name

```ruby
#test/dummy/config/routes.rb
#main application routes
Rails.application.routes.draw do 
  mount Rubypress::Engine => '/rubypress', as: 'admin'
  root to: 'welcome#index'
end

#or change it here
# lib/rubypress/engine.rb
module Rubypress
  class Engine < ::Rails::Engine
    isolate_namespace Rubypress
    engine_name: "admin"
  end
end

```

### Migrations:

Sharing structure across projects

Namespaced Tables

```ruby 
#db/migrate/2020090909_create_rubypress_pages.rb
class CreateRubypressPages < ActiveRecord::Migration
  def change
    create_table :rubypress_pages do |t|
      t.string :name
      t.string :path
      t.string :content
      t.timestamps
    end
  end
end

```

```ruby
rake rubypress:install:migrations
```

####_create_rubypress_pages.rubypress.rb
####-TimeStamp

### Install Migration for all Engines:

```ruby
rake railties:install:migrations
```

### Initializers:

```ruby
# lib/rubypress/engine.rb
require 'rubypress.ruby_extensions'
module Rubypress
  class Engine < ::Rails::Engine
    isolate_namespace Rubypress
    initializer 'rubypress.new_routes', :after => 'action_dispatch.prepare_dispatcher' do |app|
      ActionDispatch::Routing::Mapper.send :include, Rubypress::RouteExtensions
    end
  end
end
```
### Extending Rails behaviour

```ruby
# lib/rubypress/ruby_extensions.rb
require 'rubypress.ruby_extensions'
module Rubypress
  module RouteExtensions
    def use_rubypress
      mount Rubypress::Engine => "/rubypress"
      get "help" => "rubypress/help#index"
    end
  end
end
```
### Using the new DSL:

```ruby
#test/dummy/config/routes.rb
#main application routes
Rails.application.routes.draw do 
  use_rubypress
  root to: 'welcome#index'
end
```

### Middleware stack
Requests are get passed through the middleware
```ruby
# lib/rubypress/engine.rb
module Rubypress
  class Engine < ::Rails::Engine
    isolate_namespace Rubypress
    middleware.use Rack::Cache,
    :verbose => true,
    :metatstore => 'file:tmp/cache/meta',
    :entitystore => 'file:tmp/cache/entity'
  end
end
```

### Suggested generators

```ruby
# lib/rubypress/engine.rb
module Rubypress
  class Engine < ::Rails::Engine
    isolate_namespace Rubypress
    # for starting religious arguments with coworkers
    config.app_generators.test_framework :rspec
    config.app_generators.template_engine :haml
  end
end
```

### Make your Engine configurable

```ruby
# lib/rubypress/engine.rb
module Rubypress
  class Engine < ::Rails::Engine
    isolate_namespace Rubypress
    
    config.rubypress = ActiveSupport::OrderedOptions.new
    config.before_configuration do |app|
      app.config.rubypress.site_name = 'A Rubypress Site'
    end

  end
end
```
Overriding the defaults:

```ruby
# test/dummy/config/envirpnments/production.rb
Dummy::Application.configure do 
  # Override the default site_name specified by Rubypress 
  config.rubypress.site_name = "Sam Corporation"
  # code is not reloaded between requests
  config.cache_classes = true

end
```

## Make others, who are using your engine, life easier
Write README / documentation:

```ruby
gem 'rubypress'

$ bundle install
$ rake rubypress:install:migrations
$ rake db:migrate

mount Rubypress::Engine => '/rubypress'

```


Improve Installation by simplifying it:
```ruby
gem 'rubypress'

$ rails g rubypress:install

```
### Generators
```ruby
#lib/generators/rubypress/install_generator.rb
module rubypress
  class InstallGenerator  < Rails::Generators::Base
    def install
      run 'bundle install'
      route "mount Rubypress::Engine => '/rubypress'"
      rake "rake rubypress:install:migrations"
      rake "rake db:migrate"
    end
  end
end

```

## Asset Pipeline:
Packaging the view


## Working together:
Ups and downs of multiple Engines

### A common installer:
```ruby
#lib/generators/rubypress/install_generator.rb
module rubypress
  class InstallGenerator  < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    def add_and_install_module
      gem name
      generate("#{name}:install")
    end
  end
end

```


## Authentication:

Examples:

Devise
Omniauth
AuthLogic
Restful-Authentication
Sorcery
Clearance
Doorkeeper

## Authorization:

CanCan
Declarativeauthorization
Rollify
Acl19
Rolerequirement
Authority
Cantago

## UI:

ActiveAdmin & RailsAdmin


# Rails Engine Guide:

Example Engines:

https://github.com/plataformatec/devise
https://github.com/spree/spree
https://github.com/thredded/thredded
https://github.com/refinery/refinerycms



rails plugin new blorgh --mountable


========================================================================================================
