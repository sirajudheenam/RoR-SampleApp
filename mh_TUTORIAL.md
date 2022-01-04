
# Ruby on Rails - Michael Hartl

============================================================
Michael Hartl - Rail Tutorial Second Edition with Book
============================================================
rails new sample_app

bundle install

## Generate User scaffold:

cd sample_app

rails generate scaffold User name:string, email:string

bundle exec rake db:migrate

rails server

localhost:3000/users
localhost:3000/users/new

localhost:3000/users/1
localhost:3000/users/1/edit


## Generate Micropost scaffold:
rails generate scaffold Micropost content:string, user_id:integer

`content:text` can be used as well for longer texts.

bundle exec rake db:migrate

rails db:migrate

rails server

Look at routes.rb

resources :users
resource :microposts

## Add validation to the micropost:

app/model/micropost.rb

class Micropost < ActiveRecord::Base
	attr_accessible :content, :user_id
	validates :content, :length => { :maximum => 140 }
end

Get Lorum ipsum plugin for your editor

Now create a long string and try to save it as its content.

## Create association between User and Micropost

`User` has one-to-many relationship with `Micropost`
`Micrpost` has one-to-one relationship with `User`

class Micropost < ActiveRecord::Base
	attr_accessible :content, :user_id
	validates :content, :length => { :maximum => 140 }
	belongs_to :user
end

class User < ActiveRecord::Base
	attr_accessible :name, :email
	has_many :microposts
end

Create a Record of Micropost

Go to Rails Console:

```
>> first_user = User.first
>> all_users = User.all

>> first_user.microposts

>> first_user.name
>> first_user.email
```

Exit out.

```
git add .
git commit -m ""
git push
git push heroku master

# go to heroku url 

navigate to url/users

heroku logs

# Do db migration on heroku 

heroku run rake db:migrate

# Now go to heroku URL 
url/users

# It should work now.

```



## Create an App

rails new sample_app --skip-test-unit


Add this to Gemfile:

```ruby 
# bit.ly/rails_tutorial_gemfile 
# OR
# https://raw.githubusercontent.com/railstutorial/sample_app_2nd_ed/master/Gemfile
source 'https://rubygems.org'

gem 'rails', '3.2.16'
gem 'bootstrap-sass', '2.1'
gem 'bcrypt-ruby', '3.0.1'
gem 'faker', '1.0.1'
gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'
gem 'jquery-rails', '2.0.2'

group :development, :test do
  gem 'sqlite3', '1.3.5'
  gem 'rspec-rails', '2.11.0'
  gem 'guard-rspec', '1.2.1'
  gem 'guard-spork', '1.2.0'
  gem 'childprocess', '0.3.6'
  gem 'spork', '0.9.2'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'factory_girl_rails', '4.1.0'
  gem 'cucumber-rails', '1.2.1', :require => false
  gem 'database_cleaner', '0.7.0'
  # gem 'launchy', '2.1.0'
  # gem 'rb-fsevent', '0.9.1', :require => false
  # gem 'growl', '1.0.3'
end

group :production do
  gem 'pg', '0.12.2'
end

```

```bash
bundle --without production
```

Testing with RSpec:
===============

$ rails generate rspec:install

# Do git stuff such as adding it to git by init and add , commit, push commands

# Deploy it to heroku 

$ heroku create --stack cedar 

$ git push heroku master

$ less .git/config # to find out the URL

$ heroku open

$ git mv README.rdoc README.md

$ git checkout -b static-pages

To learn more about git: progit.org/book

git mv README.rdoc README.md
Edit the file 
git checkout master
git merge static-pages
git branch -d static-pages
git push -u origin master


# to generate a controller with two pages (home, help) without default test framework
$ rails generate controller StaticPages home help --no-test-framework

If you wish to destroy the controller at later stage:

rails destroy controller StaticPages home help

Behaviour Driven Development (BDD)
Test Driven Development (TDD) with RSpec

Spike - 

$ rails generate integration_test static_pages

spec/requests/static_pages_spec.rb

in DSL format


static_pages_spec.rb
```ruby
require 'spec_helper'
describe "Static pages" do
  describe "Static pages" do
    it "should have content 'Sample App'" do 
      visit '/static_pages/home'
      page.should have_content('Sample App')
    end
  end
end

# Run the test:
bundle exec rspec spec/request/static_pages_spec.rb

# Go and fix the error by editing app/views/static_pages/home.html.erb

# Run the test in all files in the dir `spec`:
bundle exec rspec spec/


# Failure/Error: visit '/static_pages/home'
# NoMethodError:
# undefined method `visit'
# Add this here. rails_helper.rb or spec_helper.rb file
config.include Capybara::DSL



# For Mailer and related test to work add these lines on each 
# config/environment/test.rb / development.rb / production.rb

Rails.application.routes.default_url_options[:host] = 'domain.com'

```



# Advanced Setup on local machine / Setting up sublime Text
============================================================
https://github.com/mhartl/rails_tutorial_sublime_text

http://bit.ly/rails_tutorial_advanced_setup 
OR
https://www.youtube.com/watch?v=FZ-b9oZpCZY

railstutorial.org || michal hartl
railstutorial.org/book

rails new sample_app --skip-bundle

# to get rid of the requirement to do bundle exec everytime
rvm get head --auto-dotfiles && rvm reload


chmod +x $rvm_path/hooks/after_cd_bundler
bundle binstubs --all

Add to .gitignore file:
bundler_stubs/

From now on you can type rake directly without `bundle exec`

# Run test in an automated fashion using guard

$ bundle exec guard init rspec

$ rails generate rspec:install

Go to rails tutorial book Chapter 3 and copy the correct content of Guardfile

# Install spork 
Guard and Spork work nicely together

Add these to Gemfile under test:

gem 'rb-fsevent'
gem 'growl' # works only on osx
gem 'guard-spork'

Bootstap spork
spork --bootstrap

Look at the spec/spec_helper.rb file

Whatever content is generated by `rails generate rspec:install` which may start with 
`ENV['RAILS_ENV] ||=  'test'` should be moved to the block

```ruby
  Spork.prefork do
    # HERE 
  end

```



```bash
# If you get this error:
https://github.com/sporkrb/spork/issues/223

uninitialized constant ActiveModel::Observing (NameError)
$HOME/.rvm/gems/ruby-2.7.2/gems/spork-0.9.2/lib/spork/app_framework/rails.rb:56:in `preload_rails'

# Do the following
gem install gemedit
gem edit spork

# comment the following line number 56 of ` lib/spork/app_framework/rails.rb`
Spork.trap_method(::ActiveModel::Observing::ClassMethods, :instantiate_observers)
# save and exit.
# Run spork again.
```

On the Rails root dir, inspect the `.rspec` file
--colour
--drb


On the sample_app

$ time rspec spec/

Run the spork server now on the root of the app:

spork 

Now run the test with rspec

$ time rspec spec/

You can see the difference.

Run the guard with spork now

bundle exec guard init spork 

Look at the Guardfile:
Move the content starts with `guard 'spork' ` as the first block before `guard 'rspec'` block.

Now run
$ bundle exec guard

============================================================
 Ruby on Rails Tutorial:

 updates only:

 test/test_helper.rb

```ruby
cat test/test_helper.rb
ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"
# Add these two lines
require "minitest/reporters"
Minitest::Reporters.use!
```

Make sure you have these in your `Gemfile` for the above to work.

under test:
```bash
  gem "minitest-reporters"
  gem "mini_backtrace"
  gem "guard-minitest"

# add a silencer for rvm so it does not show the backtrace.
# edit the file: `config/initializers/backtrace_silencers.rb` and remove any other silencer removals if needed.
Rails.backtrace_cleaner.add_silencer { |line| line =~ /rvm/ }

$ bundle exec guard init


# Add these content to the Guardfile

require 'active_support/core_ext/string'
# Defines the matching rules for Guard.
guard :minitest, spring: "bin/rails test", all_on_start: false do
  watch(%r{^test/(.*)/?(.*)_test\.rb$})
  watch('test/test_helper.rb') { 'test' }
  watch('config/routes.rb') { interface_tests }
  watch(%r{app/views/layouts/*}) { interface_tests }
  watch(%r{^app/models/(.*?)\.rb$}) do |matches|
    ["test/models/#{matches[1]}_test.rb",
     "test/integration/microposts_interface_test.rb"]
  end
  watch(%r{^test/fixtures/(.*?)\.yml$}) do |matches|
    "test/models/#{matches[1].singularize}_test.rb"
  end
  watch(%r{^app/mailers/(.*?)\.rb$}) do |matches|
    "test/mailers/#{matches[1]}_test.rb"
  end
  watch(%r{^app/views/(.*)_mailer/.*$}) do |matches|
    "test/mailers/#{matches[1]}_mailer_test.rb"
  end
  watch(%r{^app/controllers/(.*?)_controller\.rb$}) do |matches|
    resource_tests(matches[1])
  end
  watch(%r{^app/views/([^/]*?)/.*\.html\.erb$}) do |matches|
    ["test/controllers/#{matches[1]}_controller_test.rb"] +
    integration_tests(matches[1])
  end
  watch(%r{^app/helpers/(.*?)_helper\.rb$}) do |matches|
    integration_tests(matches[1])
  end
  watch('app/views/layouts/application.html.erb') do
    'test/integration/site_layout_test.rb'
  end
  watch('app/helpers/sessions_helper.rb') do
    integration_tests << 'test/helpers/sessions_helper_test.rb'
  end
  watch('app/controllers/sessions_controller.rb') do
    ['test/controllers/sessions_controller_test.rb',
     'test/integration/users_login_test.rb']
  end
  watch('app/controllers/account_activations_controller.rb') do
    'test/integration/users_signup_test.rb'
  end
  watch(%r{app/views/users/*}) do
    resource_tests('users') +
    ['test/integration/microposts_interface_test.rb']
  end
end

# Returns the integration tests corresponding to the given resource.
def integration_tests(resource = :all)
  if resource == :all
    Dir["test/integration/*"]
  else
    Dir["test/integration/#{resource}_*.rb"]
  end
end

# Returns all tests that hit the interface.
def interface_tests
  integration_tests << "test/controllers"
end

# Returns the controller tests corresponding to the given resource.
def controller_test(resource)
  "test/controllers/#{resource}_controller_test.rb"
end

# Returns all tests for the given resource.
def resource_tests(resource)
  integration_tests(resource) << controller_test(resource)
end
## -------- End of Guardfile

# now execute 

bundle exec guard


```



Killing a process:

ps aux | grep spring
pkill -9 -f spring


# IRB Config: ~/.irbrc
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT_MODE] = false

```ruby
IRB:
>> nil.to_s.empty?
true

>> nil.nil?
true

>> !!false
false

>> !!nil
false

>> false
false


"foo bar     baz".split
["foo", "bar", "baz"]
"foo bar    \t baz".split
["foo", "bar", "baz"]
"fooxbarxbaz".split('x')
["foo", "bar", "baz"]

a = [23, 44, 33]
>> a[2]
=> 33
>> a.first
=> 23
>> a.last
=> 23
# equal to a.last
>> a[-1] 
=> 33
>> a.last == a[-1]
=> true

x = a.length
3
x == 3
true
x == 1
false

a.empty?
false
[].empty?
true
>> a.reverse
=> [33, 44, 23]
>> a.sort
=> [23, 33, 44]
>> a.include?(44)
=> true

>> a.shuffle
=> [44, 33, 23]
>> a
=> [23, 44, 33]
>> a.sort
=> [23, 33, 44]
# sort doesn't mutate the array
>> a
=> [23, 44, 33]
>> a.sort!
=> [23, 33, 44]
# sort! mutates the array
>> a
=> [23, 33, 44]
>>

>> a.push(5)
=> [23, 33, 44, 5]
>> a << 8
=> [23, 33, 44, 5, 8]
>> a << "foo" << "bar"
=> [23, 33, 44, 5, 8, "foo", "bar"]


>> a.join
=> "23334458foobar"
>> a.join(', ')
=> "23, 33, 44, 5, 8, foo, bar"


>> 0..9.to_a
Traceback (most recent call last):
        4: from /Users/i072278/.rvm/rubies/ruby-2.7.2/bin/irb:23:in `<main>'
        3: from /Users/i072278/.rvm/rubies/ruby-2.7.2/bin/irb:23:in `load'
        2: from /Users/i072278/.rvm/rubies/ruby-2.7.2/lib/ruby/gems/2.7.0/gems/irb-1.2.6/exe/irb:11:in `<top (required)>'
        1: from (irb):22
NoMethodError (undefined method `to_a' for 9:Integer)
Did you mean?  to_c
               to_r
               to_f
               to_i
               to_s

>> (0..9).to_a
=> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]


>> a = %w[aadu maadu koli kunju]
=> ["aadu", "maadu", "koli", "kunju"]
>> a = %w{aadu maadu koli kunju}
=> ["aadu", "maadu", "koli", "kunju"]
>> a = %w(aadu maadu koli kunju)
=> ["aadu", "maadu", "koli", "kunju"]

>> a[0..2]
=> ["aadu", "maadu", "koli"]

>> a = (0..9).to_a
=> [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

>> a[2..(a.length - 1)]
=> [2, 3, 4, 5, 6, 7, 8, 9]

>> a[2..-1]
=> [2, 3, 4, 5, 6, 7, 8, 9]

>> b = ('a'..'f').to_a
=> ["a", "b", "c", "d", "e", "f"]

# Blocks:

(1..5).to_a

>> (1..5).each { |i| puts 2 * i }
2
4
6
8
10
=> 1..5

?> (1..5).each do |i|
?>   puts 2 * i
>> end

2
4
6
8
10
=> 1..5
?> (1..5).each do |i|
?>   puts 3 * i
?>   puts "--"
>> end
3
--
6
--
9
--
12
--
15
--
=> 1..5

>> (1..5).each { |i| puts 3 * i; puts "---" }

3
---
6
---
9
---
12
---
15
---
=> 1..5

>> 3.times { puts "Duck at Kanniyakurichi" }
Duck at Kanniyakurichi
Duck at Kanniyakurichi
Duck at Kanniyakurichi


>> squares = (1..4).each { |i| puts i**2 }
1
4
9
16
=> 1..4
>> squares = []
=> []
>> (1..4).each { |i| squares << i**2 }
=> 1..4
>> squares
=> [1, 4, 9, 16]

# map method is far efficient
>> squares = (1..4).map { |i| i**2 }
=> [1, 4, 9, 16]



>> %w[a b c ].map { |i| i.upcase }
=> ["A", "B", "C"]
>> %w[D E F].map { |i| i.downcase }
=> ["d", "e", "f"]

>> %w{G H I}.map(&:downcase)
=> ["g", "h", "i"]
# &:downcase is part of `rails` and it is incorporated in to `ruby`.


# HASHES in Ruby
user = {}
user["first_name"] = "Sam"
user["last_name"] = "Miller"

>> user = {}
=> {}
>> user["first_name"] = "Sam"
=> "Sam"
>> user["last_name"] = "Miller"
=> "Miller"
>> user
=> {"first_name"=>"Sam", "last_name"=>"Miller"}
user = { "first_name"=>"Sam", "last_name"=>"Miller" }

# Symbols:

user = { :first_name => "Sam", :last_name => "Miller" }


>> h1 = { first_name: "Sam", last_name: "Miller" }
=> {:first_name=>"Sam", :last_name=>"Miller"}
>> h2 = { :first_name => "Sam", :last_name => "Miller" }
=> {:first_name=>"Sam", :last_name=>"Miller"}
>> h1 == h2
=> true


>> params = {}
=> {}
>> params[:person] = { name: "Sam Miller", email: "sammiller@example.com" }
=> {:name=>"Sam Miller", :email=>"sammiller@example.com"}
>> params[:person]
=> {:name=>"Sam Miller", :email=>"sammiller@example.com"}
>> params[:person][:name]
=> "Sam Miller"
>> params[:person][:email]
=> "sammiller@example.com"

>> flash = {}
=> {}
>> flash = { success: "It rocks", danger: "It failed" }
=> {:success=>"It rocks", :danger=>"It failed"}

?> flash.each do |key, value|
?>   puts"#{key} has a value of #{value}"
>> end
success has a value of It rocks
danger has a value of It failed
=> {:success=>"It rocks", :danger=>"It failed"}

?> flash.each do |key, value|
?>   puts"#{key.inspect} has a value of #{value.inspect}"
>> end
:success has a value of "It rocks"
:danger has a value of "It failed"
=> {:success=>"It rocks", :danger=>"It failed"}


>> puts flash
{:success=>"It rocks", :danger=>"It failed"}
=> nil
>> p flash
{:success=>"It rocks", :danger=>"It failed"}
=> {:success=>"It rocks", :danger=>"It failed"}
>> puts flash.keys
success
danger
=> nil
>> p flash.keys
[:success, :danger]
=> [:success, :danger]


>> flash.keys
=> [:success, :danger]
>> flash.values
=> ["It rocks", "It failed"]

# Classes objects methods

?> class Word
?>   def palindrome?(str)
?>     str == str.reverse
?>   end
>> end
=> :palindrome?
>> w = Word.new
=> #<Word:0x00007fb945afe3c0>
>> w.palindrome?("Mannargudi")
=> false
>> w.palindrome?("dad")
=> true

# Inherited class

?> class Word < String
?>   def palindrome?
?>     self == self.reverse
?>   end
>> end
=> :palindrome?
>> w = Word.new("Yahoo")
=> "Yahoo"
>> w.palindrome?
=> false
>> k = Word.new("foof")
=> "foof"
>> k.palindrome?
=> true

# Add function to the existing build-in class String

class String
  def palindrome?
    self == reverse
  end
end

?> class String
?>   def palindrome?
?>     self == reverse
?>   end
>> end
=> :palindrome?
>> "madam".palindrome?
=> true
>> "Telegram".palindrome?
=> false


>> require 'rails'
=> true
>> "".blank?
=> true
>> "     ".blank?
=> true
>> nil.blank?
=> true



# On rails application:
>> controller = StaticPagesController.new
=> #<StaticPagesController:0x00000000009a38>
>> controller.class
=> StaticPagesController
>> controller.class.superclass
=> ApplicationController
>> controller.class.superclass.superclass
=> ActionController::Base
>> controller.class.superclass.superclass.superclass
=> ActionController::Metal
>> controller.class.superclass.superclass.superclass.superclass
=> AbstractController::Base
>> controller.class.superclass.superclass.superclass.superclass.superclass
=> Object
>> controller.class.superclass.superclass.superclass.superclass.superclass.superclass
=> BasicObject
>> controller.class.superclass.superclass.superclass.superclass.superclass.superclass.superclass
=> nil

>> controller.help
=> nil
>> controller.contact
=> nil

example_user.rb

class User

  attr_accessor :name, :email

  def initialize(attributes = {})
    @name = attributes[:nmae]
    @email = attributes[:email]
  end

  def format_email
    "#{@name} <#{@email}>"
  end
end



>> require './example_user.rb'
=> true
>> example = User.new
=> #<User:0x00007fa14413fe88 @name=nil, @email=nil>
>> example.name = "Example User"
=> "Example User"
>> example.email = "abc@example.com"
=> "abc@example.com"

>> example.format_email
=> "Example User <abc@example.com>"

>> require './example_user.rb'
=> true
>> user = User.new(name: "Sam Miller", email: "sammiller@domain.org")
=> #<User:0x00007fdaba1f0c10 @name="Sam Miller", @email="sammiller@domain.org">
>> user.format_email
=> "Sam Miller <sammiller@domain.org>"


# Rails Console with Sandbox:

rails console --sandbox
Running via Spring preloader in process 46937
Loading development environment in sandbox (Rails 6.1.3.1)
Any modifications you make will be rolled back on exit

rails generate model Users name:string, email:string

user = User.new(name: "Sam Miller", email:"sam@example.biz")
user.valid?
user.save

user.id
user.name
user.email
user.created_at
user.updated_at

foo = User.create(name: "Foof", email: "foof@example.org")

foo.id
foo.name
foo.email
foo.created_at
foo.updated_at

foo.destroy

User.find(1)

User.find(100)
foo.id
3
User.find(3)
# expect an error as we have already deleted foo record from DB.

User.find(foo.id)
# expect an error as we have already deleted foo record from DB.

User.find_by(id: 3)

User.find_by(id: foo.id)

User.find_by(id: 1)

User.first

User.reload

user = User.find_by(id: 1)

# this does not save in to the DB but in the memory
user.email = "sammiller@mydomain.net"

#this actually saves it in to the DB.
user.save

# Update multiple attributes.
user.update_attributes(name: "Men in Black", email: "meninblack@abc.xyz")

# Update single attribute.
user.update_attribute(:name, "Men in White")


user

user.reload.email

# If you have updated a file and in irb / console, do a reload to the console.

IRB>> reload!

#ActiveRecord related
user.valid
user.errors
user.error.full_messages


=============

# Regular Expression editor 
# Nice tool for regex.
# rubulur.com

Valid email Addresses:
/[\w+\-.]+@[a-z\-.]+\.[a-z]+/i

# To duplicate a record in DB.
duplicate_user = @user.dup


rails generate migration add_index_to_users_email 

# to delete all data in the database and create tables again. # VERIFY this.
bundle exec rake db:migrate:reset


include ActionView::Helpers::TextHelper

pluralize(2, "error")
"2 errors"
pluralize(1, "error")
"1 error"

pkill -9 -f spring

heroku maintenance:on


```
