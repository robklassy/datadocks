# README
Table assignment take home assignment from Rob Kalsi

# Install
Follow these steps to get the project up and running on your local

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

# Table Assignment Strategy
- First come first serve just finds an empty table at the time slot and assigns, as long as it fits the party size
-- This method does not take into account matching party size to exact table seating size
- Added a concept of Servers (waitstaff) that can be assigned to Tables, used this as a basis for optimizing Table assignment, eg only assign to tables where a Server is available, restaurants can then only allow enough reservations where there is staff to actually serve them, no one likes waiting 45 mins for an appetizer or a drink because they are short staffed
-- This method also only finds tables that are the exact size of the party, thus avoiding assigning a table that has 8 seats to 2 people, avoiding wasting restaurant seating space, unocupied seats are not generating any revenue

# Test Approach
I used `rswag` to write tests, it inludes easy scaffolding and can then be used to generate the API docs
- `spec/requests/reserverations_spec.rb` has the most tests, making sure tables get assigned correctly

# Future Considerations
Some things I thought of after making this
- Wait list - how can current Reservation model accommodate when you show up to the Restaurant and you are put into a queue, added a `state` column to indicate when a Reservation is `assigned` to a Table.  I imagine this `state` can also be used to put the Reservation into a queue
- Children seating - this does not take into account high chairs, eg a Restaurant may have 100 seats, but only 10 high chairs, if a family wants to bring their child, we need to have a way to allocate high chairs (or any other special equipment diners need.)  Parents of don't want to show up with no high chair available for their child
- Chefs - sometimes you can tell there is one person in the kitchen making the food, incorporating this concept of Kitchen Capacity would be useful, eg if the kitchen is shortstaffed, only allow a certain number of Reservations

