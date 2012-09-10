# Bare bones user auth in Rails 3
No styling at all, but fully functional user login system.

## Installing

	git clone git://github.com/nerdcave/rails3-user-auth.git
	cd rails3-user-auth
	bundle install
	rake db:migrate
	rake test:prepare

###Run the tests:

	bundle exec rspec spec/

###Run the app

	rails s

##Configuration
To get the app to send password reset emails properly, configure the **action_mailer** options at the bottom of **config/environments/development.rb**.

## Features:
* Register user
* Sign in/out user
* 'Remember me' option for when the user closes the browser
* Reset password

## Contact me
Shoot me an email if you have any questions: <jay@nerdcave.com>