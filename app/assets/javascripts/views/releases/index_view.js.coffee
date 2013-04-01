skyline.Views.Releases ||= {}

class skyline.Views.Releases.IndexView extends Backbone.View
  template: HandlebarsTemplates["releases/index"]
  tagName: 'tr'

  initialize: (options) ->
    @app = options.app
    self = this
    _.extend this,
      render: =>
        json = {releases: self.app.releases().toJSON()}
        json.cellWidth = 100.0 / json.releases.length
        self.$el.html self.template(json)
        return this

    @listenTo(@app, 'change', @render)
