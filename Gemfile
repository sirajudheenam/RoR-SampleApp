source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem "bootstrap-sass", "~> 3.4.1"
gem 'bootsnap', '>= 1.4.4', require: false
gem 'coffee-rails', '~> 5.0.0'
gem 'uglifier', '~> 4.2.0'
gem 'font-awesome-rails', '~> 4.7.0'
gem 'haml', '~> 5.2.1'
gem 'simple_form', '~> 5.1.0'
gem 'react-rails', '~> 2.6.1'
gem 'rack-cors', '~> 1.1.1'
gem 'image_processing',           '~> 1.12.1' # '1.9.3'
gem 'mini_magick',                '~> 4.11.0' # '4.9.5'
gem 'faker',                      '~> 2.17.0' # 2.11.0
gem 'will_paginate',              '~> 3.3.0'
gem 'bootstrap-will_paginate',    '~> 1.0.0'
gem 'active_storage_validations', '~> 0.9.3' # 0.8.9
gem 'bcrypt',                     '~> 3.1.16' # 3.1.13

gem 'country_select', require: 'country_select_without_sort_alphabetical'

group :development, :test do
  gem 'puma', '~> 5.3.0'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.0.1'
  gem 'spork', github: 'sporkrb/spork', branch: 'master'
  gem 'guard-rspec', '~> 4.7.3'
  gem 'guard-spork', '~> 2.1.0'
  gem 'rb-fsevent'
  gem 'growl' 
end

group :development do
  gem 'sqlite3', '~> 1.4'
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'haml-rails', '~> 2.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem "minitest-reporters"
  gem "mini_backtrace"
  gem "guard-minitest"

end

group :production do
  gem 'pg'
  gem 'rails_12factor' #, group: :production
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]






