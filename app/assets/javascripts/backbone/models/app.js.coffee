TrackerDashboard.App = TrackerDashboard.Model.extend(
  paramRoot: 'app'
  url: '/projects'
  defaults:
    metric: 'points'
  relations: [
    {
    type: Backbone.HasMany,
    key: 'labels',
    relatedModel: 'TrackerDashboard.Label',
    collectionType: 'TrackerDashboard.Labels',
    reverseRelation: {
      key: 'project'
    }
    },
    {
    type: Backbone.HasMany,
    key: 'projects',
    relatedModel: 'TrackerDashboard.Project',
    collectionType: 'TrackerDashboard.Projects',
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
    epics = new TrackerDashboard.Epics([], app: this)
    _.map @enabledLabels(), (label) =>
      epics.add(new TrackerDashboard.Epic({label: label, app: this}), silent: true);
    epics
  enabledLabels: ->
    @projects().chain().invoke('enabledLabels').flatten().uniq().value()
  stories: ->
    _.flatten(
      @projects().map (proj) => proj.stories()
    )
  toJSON: ->
    projects: @projects().toJSON()
)
