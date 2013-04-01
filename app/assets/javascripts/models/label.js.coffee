Skyline.Label = Skyline.Model.extend(
  paramRoot: 'label'
  app: ->
    @get 'app'
  stories: ->
    new Backbone.Collection(
      _.select @app().stories(), (s) =>
        s.labels().include(this)
    )
)

Skyline.Labels = Backbone.Collection.extend(
  model: Skyline.Label
)
