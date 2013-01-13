TrackerDashboard.Label = TrackerDashboard.Model.extend(
  paramRoot: 'label'
)

TrackerDashboard.Labels = Backbone.Collection.extend(
  model: TrackerDashboard.Label
)
