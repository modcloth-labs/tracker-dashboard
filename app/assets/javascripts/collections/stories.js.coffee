skyline.Stories = Backbone.Collection.extend(
  model: skyline.Story
  url: '/stories',
  byState: ->
    groups = {}
    @each (story) =>
      groups[story.get('current_state')] ||= new skyline.Stories()
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

  latest: ->
    _.last(
      @sortBy (story) =>
        story.iteration().get('finish')
    )

  toJSON: (options) ->
    options ||= {}
    byState = {total: {points: 0, pseudoPoints: 0, length: 0, velocity: options.velocity}}
    _.each @byState(), (stories, state) =>
      byState[state] =
        points: stories.points()
        pseudoPoints: stories.pseudoPoints()
        length: stories.length
      byState.total.points += byState[state].points
      byState.total.pseudoPoints += byState[state].pseudoPoints
      byState.total.length += byState[state].length
    stories: Backbone.Collection.prototype.toJSON.apply(this, arguments),
    metrics:
      points: @points(),
      pseudoPoints: @pseudoPoints(),
      byState: byState
)
