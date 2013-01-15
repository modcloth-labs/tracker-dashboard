class TrackerDashboard.Router extends Backbone.Router
  initialize: (options = {}) ->
    @app = new TrackerDashboard.App()
    window.app = @app
    @appView = new TrackerDashboard.Views.AppView(app: @app, el: $("#root"))
    @app.fetch().then =>
      @app.trigger('change')

  routes:
    "projects"  : "projects"
    "epics"  : "epics"

  projects: ->
    @view = new TrackerDashboard.Views.Projects.IndexView(app: @app)
    $("#dashboard").html(@view.render().el)

  epics: ->
    @view = new TrackerDashboard.Views.Epics.IndexView(app: @app)
    $("#dashboard").html(@view.render().el)
