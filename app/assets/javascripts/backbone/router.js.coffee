class TrackerDashboard.Router extends Backbone.Router
  initialize: (options = {}) ->
    @app = new TrackerDashboard.App()
    window.app = @app
    @appView = new TrackerDashboard.Views.AppView(app: @app, el: $("#root"))

  routes:
    "projects"  : "index",
    ".*"        : "index"

  index: ->
    @app.fetch().then =>
      @app.trigger('change')
    @view = new TrackerDashboard.Views.Projects.IndexView(app: @app)
    $("#dashboard").html(@view.render().el)
