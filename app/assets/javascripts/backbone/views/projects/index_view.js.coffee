TrackerDashboard.Views.Projects ||= {}

class TrackerDashboard.Views.Projects.IndexView extends Backbone.View
  template: HandlebarsTemplates["projects/index"]
  tagName: 'tr'

  initialize: (options) ->
    @app = options.app
    self = this
    _.extend this,
      render: =>
        json = self.app.toJSON()
        json.cellWidth = 100.0 / json.projects.length
        self.$el.html self.template(json)
        return this

    @listenTo(@app, 'change', @render)
