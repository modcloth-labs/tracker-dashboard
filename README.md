TrackerDashboard
================

This application is designed to give you more visibility into metrics that matter to
larger companies using Pivotal Tracker for project management.  It's also designed visually
to be an "information radiator" in the center of your office.

Features
--------
* See the progress of the current iteration in all your projects on one page.
* Look at the status of cross-project epics (correlated by label name)
* Look at the status of cross-project releases (correlated by name)
* Easy setup page that helps you set up your tracker credentials and basic authentication

Installing and running locally
------------------------------
	rvm install 1.9.3   # or install ruby 1.9.x some other way
	git clone
	bundle install
	rake db:create db:migrate
	rails server
	open http://localhost:3000

Deploying
---------

This app is designed to be deployed easily with [CloudFoundry](http://www.cloudfoundry.com>) and [Heroku](http://heroku.com>).
You can also run it yourself using a standard ruby application system like Passenger or Unicorn.
A database is required, but all the standard rails ones (sqlite3 mysql and postgres) are supported.

### CloudFoundry deployment

	git clone
	cf push

### Heroku deployment

	git clone
	heroku apps:create <name_here>
	git push heroku master

Automatically Updating
----------------------

For automatic updating, you can enable auto updating in the web UI (which occasionally blocks web threads to do updates before returning),
or figure out how to schedule running the following task as often as you want:

	bundle exec rake load

This will fetch new data from the tracker API and put it in the relational database. If you
deploy on heroku, you can use the following addon to schedule tasks:

	heroku addons:add scheduler
	heroku addons:open scheduler

### Credits
Written by Luis Flores, David Stevenson, Ben Marini, and Sanford Redlich.
Please fork this application and enhance it to fit your needs.