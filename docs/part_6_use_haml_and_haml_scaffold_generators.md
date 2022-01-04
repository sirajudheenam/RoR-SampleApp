# Part 6 - Use HAML & SimpleForm with Rails 6

Stay Calm & Use HAML 

Add these gems to your `Gemfile`.

```
gem 'haml', '~> 5.2.1'

group :development do 
	#...
	gem 'haml-rails', '~> 2.0'
end

```

'haml' gem is the for the language itself. 'haml-rails' is for rails scaffolding to use haml.

## Add the following content to `config/application.rb`.

```ruby
config.generators do |g|
  g.template_engine :haml
end 
```

## To convert existing erb files to haml

Let us look at the 'sharks' resource. Its views were created with default `erb`.

```
ls app/views/sharks

find app/views/sharks -name '*erb' | \
      xargs ruby -e 'ARGV.each { |i| puts "html2haml -r #{i} #{i.sub(/erb$/,"haml")}"}'


# This just shows what are the files are to be converted.
# If you are OK with that output, just back up your files and run

tar -zcvf sharks-erb-files.tar.gz app/views/sharks
ls sharks-erb-files.tar.gz

find app/views/sharks -name '*erb' | \
      xargs ruby -e 'ARGV.each { |i| puts "html2haml -r #{i} #{i.sub(/erb$/,"haml")}"}' | \
      bash
# Remove all erb files.
rm -f app/views/sharks/*.erb

```      


# Install SimpleForm

Add the line to `Gemfile`.

```ruby
gem 'simple_form'
```

Run bundle install:

```ruby
bundle install
```

Run `rails generate` to use `simple_form`:

```ruby
rails generate simple_form:install --bootstrap
```

Test if scaffold is working with `haml` and `simple_form`.

```
rails generate scaffold User name:string, email:string, login:string

Running via Spring preloader in process 16441
      invoke  active_record
      create    db/migrate/20210501142552_create_users.rb
      create    app/models/user.rb
      invoke    test_unit
      create      test/models/user_test.rb
      create      test/fixtures/users.yml
      invoke  resource_route
       route    resources :users
      invoke  scaffold_controller
      create    app/controllers/users_controller.rb
      invoke    haml
      create      app/views/users
      create      app/views/users/index.html.haml
      create      app/views/users/edit.html.haml
      create      app/views/users/show.html.haml
      create      app/views/users/new.html.haml
      create      app/views/users/_form.html.haml
      invoke    resource_route
      invoke    test_unit
      create      test/controllers/users_controller_test.rb
      create      test/system/users_test.rb
      invoke    helper
      create      app/helpers/users_helper.rb
      invoke      test_unit
      invoke    jbuilder
      create      app/views/users/index.json.jbuilder
      create      app/views/users/show.json.jbuilder
      create      app/views/users/_user.json.jbuilder
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/users.coffee
      invoke    scss
      create      app/assets/stylesheets/users.scss
      invoke  scss
      create    app/assets/stylesheets/scaffolds.scss
```
Run DB Migration:

rake db:migrate

Troubleshooting:

$ rake db:migrate

```
rake aborted!
SyntaxError: /Users/i072278/Dev/ruby/rails/sample_app/db/migrate/20210501142552_create_users.rb:4: syntax error, unexpected '\n', expecting '.' or &. or :: or '['
${HOME}/Dev/ruby/rails/sample_app/db/migrate/20210501142552_create_users.rb:5: syntax error, unexpected '\n', expecting '.' or &. or :: or '['
/Users/i072278/.rvm/gems/ruby-2.7.2/gems/bootsnap-1.7.4/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:23:in `require'
```

Look at the migration file `db/migrate/20210501142552_create_users`

```
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string, :name
      t.string, :email
      t.string :login

      t.timestamps
    end
  end
end
```

      t.string, :name
      t.string, :email

Remove the comma (,) after t.string for both fields
So it looks like

```
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :login

      t.timestamps
    end
  end
end
```

Let us run the migration again.

```
rake db:migrate
== 20210501142552 CreateUsers: migrating ======================================
-- create_table(:users)
   -> 0.1512s
== 20210501142552 CreateUsers: migrated (0.1514s) =============================
```

rails s


References:

- [ERB to HAML](https://shifteleven.com/articles/2008/06/08/converting-erb-to-haml-snippet/)

