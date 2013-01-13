TrackerDashboard.Iteration = TrackerDashboard.Model.extend(
  paramRoot: 'iteration'
  project: ->
    @get('project')
  stories: ->
    new TrackerDashboard.Stories(_.map @get('story_ids'), (storyId) =>
      @project().stories().get(storyId)
    )
  labelStories: ->
    groups = {}
    @stories().each (story) =>
      _.each story.labels(), (label) =>
        groups[label.id] ||= new TrackerDashboard.Stories()
        groups[label.id].push story, silent: true
    groups

  enabledLabelStories: ->
    groups = {}
    @stories().each (story) =>
      _.each story.labels(), (label) =>
        if _.include @project().enabledLabels(), label
          groups[label.id] ||= new TrackerDashboard.Stories()
          groups[label.id].push story, silent: true
        else
          groups[-1] ||= new TrackerDashboard.Stories()
          groups[-1].push story
    groups

  toJSON: ->
    epicsJSON = _.map @enabledLabelStories(), (stories,labelId) =>
      label: (@project().labels().get(labelId) || {toJSON: -> {name: 'uncategorized'}}).toJSON(),
      stories: stories.toJSON()

    _.extend TrackerDashboard.Model.prototype.toJSON.apply(this, arguments),
      stories: @stories().toJSON()
      enabledEpics: epicsJSON


)

TrackerDashboard.Iterations = Backbone.Collection.extend(
  model: TrackerDashboard.Iteration
  url: '/iterations'
)
