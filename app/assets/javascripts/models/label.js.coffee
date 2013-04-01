skyline.Label = skyline.Model.extend(
  paramRoot: 'label'
  app: ->
    @get 'app'
  stories: ->
    new Backbone.Collection(
      _.select @app().stories(), (s) =>
        s.labels().include(this)
    )
)