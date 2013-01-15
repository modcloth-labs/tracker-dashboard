class TrackerDashboard.Views.AppView extends Backbone.View
  initialize: (options) ->
    @app = options.app
    _.extend this,
      metricChanged: (e) =>
        @app.set 'metric', $(e.target).val()
        $.cookie('metric', @app.get('metric'))
    $('select.metric').val(@app.get('metric'))
    @delegateEvents
      'change .metric': @metricChanged


