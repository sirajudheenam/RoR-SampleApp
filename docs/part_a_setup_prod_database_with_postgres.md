# Set up production database with postgres

# Rails new command will create a sqlite DB by default.


# If you haven't created your rails app already, you can create one with `--database=postgresql`

```bash
rails new myapp --database=postgresql

Gemfile:

group :production do 
	gem 'pg'
end

bundle install


```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update
brew install postgresql

postgres --version # or
postgres -V

createuser -P -d sampleapp
# -P is to prompt password, skip it if you wish to set up separately.

# you will be prompted for password (Password)

# Enter the postgres console 
psql postgres

# Set up password if you have skipped the -P option above.
postgres=# \password sampleapp
Enter new password:
Enter it again:

psql sampleapp_test
GRANT ALL PRIVILEGES ON DATABASE sampleapp_test TO sampleapp;
ALTER USER sampleapp WITH SUPERUSER;

# quit 
postgres=# \q 

echo 'export SAMPLEAPP_DATABASE_PASSWORD="YOURSECrETPASSW0RD"' >> ~/.bashrc
source ~/.bashrc

cat <<'EOF' >>config/database.yml
default: &default
  adapter: postgresql
  encoding: unicode
  # For details on connection pooling, see Rails configuration guide
  # http://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: sampleapp
  password: <%= ENV['SAMPLEAPP_DATABASE_PASSWORD'] %>

development:
  <<: *default
  database: sampleapp_dev

test:
  <<: *default
  database: sampleapp_test

production:
  <<: *default
  database: sampleapp_prod
EOF


rails db:create
rails db:migrate

RAILS_ENV=production rails db:create
RAILS_ENV=production rails db:migrate
```