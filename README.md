# Nail Appointments
Purpose:
* This is an application designed to create nail salon appointments. Using ruby on rails, this application allows users to register for appointments on specific dates and fill in details. The admin can create specific times users can sign up for appointments, see all users, and see all appointments.


Versions:

* Ruby 3.3.1 
* Rails 7.1.3.4

## Development pre-requisites
* In order to run locally, you must have Lando installed for your system - see https://docs.lando.dev/getting-started/installation.html.

## Run the development environment locally
  1. Clone this repo
  2. Make sure [Lando](https://docs.lando.dev/getting-started/installation.html.) is installed
  3. Install dependencies using the command:
     ```
     bundle install
     ```
  4. Start lando:
     ```
     lando start
     ```
  5. Create the database:
     ```
     rake db:create
     ```
     ```
     rake db:migrate
     ```
  6. Start the server:
     ```
     bundle exec rails s
     ```
     


## Testing

### Run Tests
  1. Run the test:
     ```
     bundle exec rspec
     ```
