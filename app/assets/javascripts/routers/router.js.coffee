class Skyline.Router extends Backbone.Router
  initialize: (options = {}) ->
    @app = new Skyline.App()
    @app.set('metric', $.cookie('metric')) if $.cookie('metric')
    @app.set('filter_tiny_items', true) if $.cookie('filter_tiny_items')

    window.app = @app
    @appView = new Skyline.Views.AppView(app: @app, el: $("#root"))
    @app.fetch().then =>
      @app.trigger('change')

  routes:
    "projects": "projects"
    "epics": "epics"
    "releases": "releases"

  projects: ->
    @view = new Skyline.Views.Projects.IndexView(app: @app)
    $("#dashboard").html(@view.render().el)

  epics: ->
    @view = new Skyline.Views.Epics.IndexView(app: @app)
    $("#dashboard").html(@view.render().el)

  releases: ->
    @view = new Skyline.Views.Releases.IndexView(app: @app)
    $("#dashboard").html(@view.render().el)
