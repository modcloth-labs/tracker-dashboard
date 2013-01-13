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
  toJSON: ->
    projects: @projects().toJSON()
)
