skyline.App = skyline.Model.extend(
  paramRoot: 'app'
  url: '/projects'
  defaults:
    metric: 'points'
    filter_tiny_items: false
  relations: [
    {
    type: Backbone.HasMany,
    key: 'labels',
    relatedModel: 'skyline.Label',
    collectionType: 'skyline.Labels',
    reverseRelation: {
      key: 'project'
    }
    },
    {
    type: Backbone.HasMany,
    key: 'projects',
    relatedModel: 'skyline.Project',
    collectionType: 'skyline.Projects',
    reverseRelation: {
      key: 'app'
    }
    }
  ]
  projects: ->
    @get('projects')
  labels: ->
    @get('labels')
  epics: ->
    epics = new skyline.Epics([], app: this)
    _.map @enabledLabels(), (label) =>
      epics.add(new skyline.Epic({label: label, app: this}), silent: true);
    epics
  releases: ->
    releases = new skyline.Releases([], app: this)
    _.each @stories(), (story) =>
      if story.get('story_type') == 'release' && story.get('current_state') == 'unstarted'
        releases.add({id: story.get('name'), app: this}, silent: true);
        releases.get(story.get('name')).get('stories').add(story)
    releases

  enabledLabels: ->
    @projects().chain().invoke('enabledLabels').flatten().uniq().value()
  stories: ->
    @projects().chain().invoke('stories').pluck('models').flatten().value()
  toJSON: ->
    projects: @projects().toJSON()
)
