TrackerDashboard.Views.Epics ||= {}

class TrackerDashboard.Views.Epics.IndexView extends Backbone.View
  template: HandlebarsTemplates["epics/index"]
  tagName: 'tr'

  initialize: (options) ->
    @app = options.app
    self = this
    _.extend this,
      render: =>
        json = {epics: self.app.epics().toJSON()}
        json.cellWidth = 100.0 / json.epics.length
        self.$el.html self.template(json)
        return this

    @listenTo(@app, 'change', @render)
