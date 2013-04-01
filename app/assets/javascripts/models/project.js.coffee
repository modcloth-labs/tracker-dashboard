Skyline.Project = Skyline.Model.extend(
  paramRoot: 'project'
  relations: [
    {
    type: Backbone.HasMany,
    key: 'stories',
    relatedModel: 'Skyline.Story',
    collectionType: 'Skyline.Stories',
    reverseRelation: {
      key: 'project'
    }
    },
    {
    type: Backbone.HasMany,
    key: 'iterations',
    relatedModel: 'Skyline.Iteration',
    collectionType: 'Skyline.Iterations',
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
    _.extend Skyline.Model.prototype.toJSON.apply(this, arguments),
      currentIteration:
        @iterations().first().toJSON()

)

Skyline.Projects = Backbone.Collection.extend(
  model: Skyline.Project
)
