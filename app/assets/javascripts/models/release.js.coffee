Skyline.Release = Skyline.Model.extend(
  initialize: ->
    @set('stories', new Skyline.Stories())
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

Skyline.Releases = Backbone.Collection.extend(
  initialize: (models, options) ->
    @app = options.app
  projects: ->
    @app.projects()

  model: Skyline.Release
  stories: ->
    groups = {}
    @each (r) =>
      r.stories().each (releaseStory) =>
        p = releaseStory.project()
        r.storiesAbove(releaseStory).each (s) =>
          groups[r.id] ||= {projects: {}, total: new Skyline.Stories()}
          groups[r.id].projects[p.id] ||= new Skyline.Stories()
          groups[r.id].projects[p.id].add(s, silent: true)
          groups[r.id].total.add(s, silent: true)
    groups
  toJSON: ->
    _.map @stories(), (v, releaseId) =>
      r = @get(releaseId)
      latest = v.total.latest()
      release: r.toJSON()
      total: v.total.toJSON()
      finish: latest && latest.iteration().get('finish')
      filtered: @app.get('filter_tiny_items') && _.size(v.projects) <= 1
      projects: _.map(v.projects, (stories,projectId) =>
        l = stories.latest()
        project: @projects().get(projectId).toJSON()
        stories: stories.toJSON()
        finish: l && l.iteration().get('finish')
        release_cid: r.cid
      )
)
