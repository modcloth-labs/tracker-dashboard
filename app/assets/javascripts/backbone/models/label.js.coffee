TrackerDashboard.Label = TrackerDashboard.Model.extend(
  paramRoot: 'label'
  app: ->
    @get 'app'
  stories: ->
    new Backbone.Collection(
      _.select @app().stories(), (s) =>
        s.labels().include(this)
    )
)

TrackerDashboard.Labels = Backbone.Collection.extend(
  model: TrackerDashboard.Label
)
