tracker-dashboard
=================

ModCloth Dashboard for Pivotal Tracker projects

* It is not necessarily an App, but it looks like one.
* It is composed by an HTML5 web interface and a Ruby library for data extraction.
* The Pivotal Tracker API provides the data through basic web requests.
* The lightweight Ruby library structures and stores the data in JSON files that are accessible to the interface.

Setup

1. Set the contents in a web server directory.
2. Set your Pivotal Tracker credentials in config/credentials.json
3. Set your Pivotal Tracker projects in config/projects
4. In order to refresh the data, go to the 'ruby' folder and run: bundle exec rake load
5. Visualize in a browser.
