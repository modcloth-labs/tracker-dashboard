TrackerDashboard.Story = TrackerDashboard.Model.extend(
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

TrackerDashboard.Stories = Backbone.Collection.extend(
  model: TrackerDashboard.Story
  url: '/stories',
  byState: ->
    groups = {}
    @each (story) =>
      groups[story.get('current_state')] ||= new TrackerDashboard.Stories()
      groups[story.get('current_state')].push(story)
    groups

  points: ->
    @reduce( (total, story) =>
      total += if story.get('estimate') == -1 then 0 else story.get('estimate')
    , 0)

  pseudoPoints: ->
    @reduce( (total, story) =>
      total += if story.get('estimate') < 1 then 0.25 else story.get('estimate')
    , 0)

  latest: ->
    _.last(
      @sortBy (story) =>
        story.get('finish')
    )

  toJSON: ->
    byState = {}
    _.each @byState(), (stories, state) =>
      byState[state] =
        points: stories.points()
        pseudoPoints: stories.pseudoPoints()
        length: stories.length
    stories: Backbone.Collection.prototype.toJSON.apply(this, arguments),
    metrics:
      points: @points(),
      pseudoPoints: @pseudoPoints(),
      byState: byState
)
