TrackerDashboard.Story = TrackerDashboard.Model.extend(
  paramRoot: 'story'
  project: ->
    @get('project')
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
