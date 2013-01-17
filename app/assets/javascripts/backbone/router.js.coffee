class TrackerDashboard.Router extends Backbone.Router
  initialize: (options = {}) ->
    @app = new TrackerDashboard.App()
    @app.set('metric', $.cookie('metric')) if $.cookie('metric')
    @app.set('filter_tiny_items', true) if $.cookie('filter_tiny_items')

    window.app = @app
    @appView = new TrackerDashboard.Views.AppView(app: @app, el: $("#root"))
    @app.fetch().then =>
      @app.trigger('change')

  routes:
    "projects": "projects"
    "epics": "epics"
    "releases": "releases"

  projects: ->
    @view = new TrackerDashboard.Views.Projects.IndexView(app: @app)
    $("#dashboard").html(@view.render().el)

  epics: ->
    @view = new TrackerDashboard.Views.Epics.IndexView(app: @app)
    $("#dashboard").html(@view.render().el)

  releases: ->
    @view = new TrackerDashboard.Views.Releases.IndexView(app: @app)
    $("#dashboard").html(@view.render().el)
