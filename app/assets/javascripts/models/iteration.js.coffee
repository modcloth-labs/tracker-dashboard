skyline.Iteration = skyline.Model.extend(
  paramRoot: 'iteration'
  project: ->
    @get('project')
  stories: ->
    new skyline.Stories(_.map @get('story_ids'), (storyId) =>
      @project().stories().get(storyId)
    )
  labelStories: ->
    groups = {}
    @stories().each (story) =>
      _.each story.labels(), (label) =>
        groups[label.id] ||= new skyline.Stories()
        groups[label.id].push story, silent: true
    groups

  enabledLabelStories: ->
    groups = {}
    @stories().each (story) =>
      _.each story.labels(), (label) =>
        if _.include @project().enabledLabels(), label
          groups[label.id] ||= new skyline.Stories()
          groups[label.id].push story, silent: true
        else
          groups[-1] ||= new skyline.Stories()
          groups[-1].push story
    groups

  toJSON: ->
    epicsJSON = _.map @enabledLabelStories(), (stories,labelId) =>
      label: (@project().labels().get(labelId) || {toJSON: => {name: 'uncategorized', id: 'uncat-'+@project().id}}).toJSON(),
      stories: stories.toJSON()

    _.extend skyline.Model.prototype.toJSON.apply(this, arguments),
      stories: @stories().toJSON({velocity: @project().get('current_velocity')})
      enabledEpics: epicsJSON

)