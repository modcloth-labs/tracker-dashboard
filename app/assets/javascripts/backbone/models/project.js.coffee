TrackerDashboard.Project = TrackerDashboard.Model.extend(
  paramRoot: 'project'
  relations: [
    {
    type: Backbone.HasMany,
    key: 'stories',
    relatedModel: 'TrackerDashboard.Story',
    collectionType: 'TrackerDashboard.Stories',
    reverseRelation: {
      key: 'project'
    }
    },
    {
    type: Backbone.HasMany,
    key: 'iterations',
    relatedModel: 'TrackerDashboard.Iteration',
    collectionType: 'TrackerDashboard.Iterations',
    reverseRelation: {
      key: 'project'
    }
    }
  ]
  app: ->
    @get('app')
  stories: ->
    @get('stories')
  iterations: ->
    @get('iterations')
  labels: ->
    @app().get('labels')
  enabledLabels: ->
    self = this
    _.map @get('enabled_label_ids'), (labelId) =>
      @labels().get(labelId)
  toJSON: ->
    _.extend TrackerDashboard.Model.prototype.toJSON.apply(this, arguments),
      currentIteration:
        @iterations().first().toJSON()

)

TrackerDashboard.Projects = Backbone.Collection.extend(
  model: TrackerDashboard.Project
)
