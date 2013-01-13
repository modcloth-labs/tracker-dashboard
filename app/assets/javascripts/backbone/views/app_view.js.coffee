class TrackerDashboard.Views.AppView extends Backbone.View
  initialize: (options) ->
    @app = options.app
    _.extend this,
      metricChanged: (e) =>
        debugger;
        @app.set 'metric', $(e.target).val()
    @delegateEvents
      'change .metric': @metricChanged


