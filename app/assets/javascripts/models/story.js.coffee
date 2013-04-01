skyline.Story = skyline.Model.extend(
  paramRoot: 'story'
  app: ->
    @get('project').app()
  project: ->
    @get('project')
  iteration: ->
    @_iteration ||= (app.projects().chain().map (project) =>
      project.iterations().detect (iter) =>
        _.contains iter.get('story_ids'), @id
    ).compact().first().value()
  labels: ->
    _.map @get('label_ids'), (labelId) =>
      @project().labels().get(labelId)
)