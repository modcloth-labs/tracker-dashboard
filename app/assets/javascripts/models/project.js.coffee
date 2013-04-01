skyline.Project = skyline.Model.extend(
  paramRoot: 'project'
  relations: [
    {
    type: Backbone.HasMany,
    key: 'stories',
    relatedModel: 'skyline.Story',
    collectionType: 'skyline.Stories',
    reverseRelation: {
      key: 'project'
    }
    },
    {
    type: Backbone.HasMany,
    key: 'iterations',
    relatedModel: 'skyline.Iteration',
    collectionType: 'skyline.Iterations',
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
    _.extend skyline.Model.prototype.toJSON.apply(this, arguments),
      currentIteration:
        @iterations().first().toJSON()

)