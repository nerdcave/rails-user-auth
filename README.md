# Bare bones user auth in Rails 3.2
No styling, just a fully functional user login system.

### Installing

	git clone git://github.com/nerdcave/rails-user-auth.git
	cd rails3-user-auth
	bundle install
	rake db:migrate
	rake test:prepare

### Run the tests

	bundle exec rspec spec/

### Run the app

	rails s

## Features
* Full RSpec tests with capybara (including request specs)
* Register, sign in, and sign out user
* Password authentication with has_secure_password
* Demonstrates custom modal field names in the view (see **config/locales/en.yml**)
* 'Remember me' option to persist session
* Reset password implementation

##Configuration
To get the app to send password reset emails properly, configure the **action_mailer** options at the bottom of **config/environments/development.rb**.