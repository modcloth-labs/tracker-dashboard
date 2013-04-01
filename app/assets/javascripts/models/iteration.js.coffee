Skyline.Iteration = Skyline.Model.extend(
  paramRoot: 'iteration'
  project: ->
    @get('project')
  stories: ->
    new Skyline.Stories(_.map @get('story_ids'), (storyId) =>
      @project().stories().get(storyId)
    )
  labelStories: ->
    groups = {}
    @stories().each (story) =>
      _.each story.labels(), (label) =>
        groups[label.id] ||= new Skyline.Stories()
        groups[label.id].push story, silent: true
    groups

  enabledLabelStories: ->
    groups = {}
    @stories().each (story) =>
      _.each story.labels(), (label) =>
        if _.include @project().enabledLabels(), label
          groups[label.id] ||= new Skyline.Stories()
          groups[label.id].push story, silent: true
        else
          groups[-1] ||= new Skyline.Stories()
          groups[-1].push story
    groups

  toJSON: ->
    epicsJSON = _.map @enabledLabelStories(), (stories,labelId) =>
      label: (@project().labels().get(labelId) || {toJSON: => {name: 'uncategorized', id: 'uncat-'+@project().id}}).toJSON(),
      stories: stories.toJSON()

    _.extend Skyline.Model.prototype.toJSON.apply(this, arguments),
      stories: @stories().toJSON({velocity: @project().get('current_velocity')})
      enabledEpics: epicsJSON


)

Skyline.Iterations = Backbone.Collection.extend(
  model: Skyline.Iteration
  url: '/iterations'
)
