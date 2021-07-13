# Set up production database with postgres

# Rails new command will create a sqlite DB by default.


# If you haven't created your rails app already, you can create one with `--database=postgresql`

```bash
rails new sampleapp --database=postgresql

Gemfile:

group :production do 
	gem 'pg'
end

bundle install


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

echo "export SAMPLEAPP_DATABASE_PASSWORD='YOURSECrETPASSW0RD'" >> ~/.bashrc
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

# Creating DB Manually Dev ENV:
# Rails Sample App
psql postgres
create database sampleapp_dev;
create database sampleapp_test;
CREATE ROLE sampleapp WITH LOGIN PASSWORD 'TamperedPassword';
ALTER ROLE sampleapp CREATEDB;
GRANT ALL PRIVILEGES ON DATABASE sampleapp_dev TO sampleapp;
GRANT ALL PRIVILEGES ON DATABASE sampleapp_test TO sampleapp;
rails db:migrate:up VERSION=20210501142553
bin/rails db:create RAILS_ENV=development
bin/rails db:migrate RAILS_ENV=development

# Sprockets::DoubleLinkError in StaticPages#home 
rm app/assets/stylesheets/*.css


# Use rails console to add some records on DB tables.
rails console


Data:
prepare seed data:
Publisher.new({name: "Tata McGrawHill", owner: "Ratan Tata"}) # id = 1
Publisher.new({name: "Hindu Group", owner: "G. Subramania Iyer"})
Publisher.new({name: "Indian Express Group", owner: "Raj Kamal Jha"})

ID = 2
www.thehindu.com
www.hindutamil.in


Id = 2
Indian Express, Dinamani and Andhra Prabha

Dinamalar
Monday VanigaMalar
Tuesday BakthiMalar
Friday SiruvarMalar
Sat VelaivaippuMalar
Sunday VaaraMalar

Data Array of Hashes:
"instruments":[
{"id":1,"title":"Piano","token":"piano","count":13},
{"id":6,"title":"Bass Guitar","token":"bass","count":12},
{"id":11,"title":"Viola","token":"viola","count":12},
{"id":4,"title":"Synth","token":"synth","count":11},
{"id":3,"title":"Keyboard","token":"keyboard","count":9},
{"id":7,"title":"Saxophone","token":"saxophone","count":8},
{"id":12,"title":"Flute","token":"flute","count":8},
{"id":5,"title":"Drums","token":"drums","count":6},
{"id":2,"title":"Guitar","token":"guitar","count":5},
{"id":8,"title":"Violin","token":"violin","count":5},
{"id":9,"title":"Vocals","token":"vocals","count":4},
{"id":10,"title":"Cello","token":"cello","count":4}
]
instruments.sort_by { |x| x["title"] }


%th= link_to "ID", sort: "ID"
%th= link_to "Title", sort: "Title"
%th= link_to "Token", sort: "Token"
%th= link_to "Count", sort: "Count"

# Sort them by a hash value
instruments.sort_by { |x| x["title"] }
instruments.sort_by{|instrument| instrument["title"]}
sort_by().reverse
sort_by(-1)
# Ascending & Descending.
# find details here: https://bugs.ruby-lang.org/issues/12648

# with model
rails generate scaffold Instruments title:string token:string, count:integer
instruments = [
    {"title":"Piano","token":"piano","count":13},
    {"title":"Bass Guitar","token":"bass","count":12},
    {"title":"Viola","token":"viola","count":12},
    {"title":"Synth","token":"synth","count":11},
    {"title":"Keyboard","token":"keyboard","count":9},
    {"title":"Saxophone","token":"saxophone","count":8},
    {"title":"Flute","token":"flute","count":8},
    {"title":"Drums","token":"drums","count":6},
    {"title":"Guitar","token":"guitar","count":5},
    {"title":"Violin","token":"violin","count":5},
    {"title":"Vocals","token":"vocals","count":4},
    {"title":"Cello","token":"cello","count":4}
  ]
Instrument.create(instruments)


# Paginatable Array 

@templates = get_all_templates
items_per_page = 10
@paginatable_array = Kaminari.paginate_array(@templates, total_count: @templates.count).page(params[:page]).per(items_per_page)

# page_size = 10
# one_page = get_page_of_data params[:page], page_size
# @paginatable_array = Kaminari.paginate_array(one_page.data, total_count: one_page.total_count).page(params[:page]).per(page_size)

# TODO
# Implement fetching more than 10 items

```