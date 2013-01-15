TrackerDashboard.Epic = TrackerDashboard.Model.extend(
  paramRoot: 'epic'
  app: ->
    @get 'app'
  label: ->
    @get 'label'
)

TrackerDashboard.Epics = Backbone.Collection.extend(
  initialize: (models, options) ->
    @app = options.app
  projects: ->
    @app.projects()
  labels: ->
    @app.labels()
  model: TrackerDashboard.Label
  stories: ->
    groups = {}
    labels = @invoke('label')
    @projects().each (p) =>
      p.stories().each (s) =>
        _.each(_.intersection(labels, s.labels()), (l) =>
          groups[l.id] ||= {projects: {}, total: new TrackerDashboard.Stories()}
          groups[l.id].projects[p.id] ||= new TrackerDashboard.Stories()
          groups[l.id].projects[p.id].add(s, silent: true)
          groups[l.id].total.add(s, silent: true)
        )
    groups
  toJSON: ->
    _.map @stories(), (v, labelId) =>
      latest = v.total.latest()
      label: @labels().get(labelId).toJSON()
      total: v.total.toJSON()
      finish: latest && latest.iteration().get('finish')
      projects: _.map(v.projects, (stories,projectId) =>
        l = stories.latest()
        project: @projects().get(projectId).toJSON()
        stories: stories.toJSON()
        finish: l && l.iteration().get('finish')
        epic_id: labelId
      )
)
