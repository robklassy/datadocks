# README
Table assignment take home assignment from Rob Kalsi

# Install
Follow steps to get the project up and running on your local

## GCC/G++
Install `gcc` and `g++` C/C++ compiler for your platform if not already installed

## Clone Repo
Clone this repo

## Ruby Version Manager (RVM) https://rvm.io/
Install RVM to be able to manage different ruby versions
- do not install rails at the same time

## Ruby
Use RVM to install ruby
- go into the repo directory
- `rvm install 3.1.0`
- note depending on your platform this might need to compile if it can't find pre-compiled binaries

## Postgres
Install Postgres for your platform if not already installed
- make the following databases: `dd_dev`, `dd_test`, `dd_prod`
- make the following user/pass: `test/blah` and `GRANT ALL PRIVILEGES` to the three databases created above
- make the user created in the above step a `SUPERUSER`

## Bundler
Bundler lets you install all of the rubygems as listed in `Gemfile`
- go into repo directory
- `gem install bundler`

## Gems
Use bundler to install all of the gems
- go into repo directory
- `bundle install`

## Database Init
The databases need to be migrated, this is accomplished by using rails migration files, and must be done for `dev` and `test`
- go into repo directory
- `rake db:migrate`
- `RAILS_ENV=test rake db:migrate`

## Seed Data
Run the seeding script to populate the dev environment with some data
- go into repo directory
- `rake db:seed`

## Rails Console
See if the project is mostly functional by going into the console
- go into repo directory
- `rails c`
- type `exit` to leave

## Tests
Can run tests to ensure project is functional
- go into repo directory
- `rspec spec`

## Rails Server / API Docs
Run the web server to load API docs
- go into repo directory
- `rails s`
- navigate to the site on your browser and go to `http://localhost:3000/api-docs`
- note that your port after `localhost` might be different, use the port that `rails s` is listening on
- note that the "Try It Out" button likely will not work
- you should be able to make simple `GET` calls in your browser at this point as well