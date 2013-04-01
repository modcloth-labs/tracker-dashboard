skyline.Epic = skyline.Model.extend(
  paramRoot: 'epic'
  app: ->
    @get 'app'
  label: ->
    @get 'label'
)