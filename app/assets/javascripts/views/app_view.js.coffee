class skyline.AppView extends Backbone.View
  initialize: (options) ->
    @app = options.app
    _.extend this,
      metricChanged: (e) =>
        @app.set 'metric', $(e.target).val()
        $.cookie('metric', @app.get('metric'))
      tinyChanged: (e) =>
        @app.set 'filter_tiny_items', $(e.target).is(':checked')
        if @app.get('filter_tiny_items')
          $.cookie('filter_tiny_items', "true")
        else
          $.cookie('filter_tiny_items', null)
    $('select.metric').val(@app.get('metric'))
    $('input.filter_tiny_items').attr('checked', @app.get('filter_tiny_items'))
    @delegateEvents
      'change .metric': @metricChanged
      'change .filter_tiny_items': @tinyChanged


