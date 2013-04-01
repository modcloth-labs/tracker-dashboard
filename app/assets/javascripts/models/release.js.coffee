skyline.Release = skyline.Model.extend(
  initialize: ->
    @set('stories', new skyline.Stories())
  app: ->
    @get 'app'
  stories: ->
    @get 'stories'
  storiesAbove: (story) ->
    storyIndex = story.collection.indexOf(story)
    new Backbone.Collection(
      story.project().stories().chain().select (otherStory, index) =>
        index <= storyIndex
      .value()
    )
  toJSON: ->
    id: @id
    cid: @cid
)