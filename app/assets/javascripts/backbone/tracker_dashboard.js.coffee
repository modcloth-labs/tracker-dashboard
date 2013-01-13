#= require_self
#= require ./router
#= require_tree ./models
#= require_tree ./views

window.TrackerDashboard =
  Models: {}
  Collections: {}
  Views: {}

TrackerDashboard.Model = Backbone.RelationalModel.extend
  parse: (attrs) ->
    _.each attrs, (v, k) =>
      attrs[k] = new Date(v) if v && _.isFunction(v.match) && v.match /^20\d\d.*T.*Z$/
    attrs
  toJSON: ->
    hash = {}
    _.each @attributes, (v,k) =>
      hash[k] = v unless v instanceof TrackerDashboard.Model || v instanceof Backbone.Collection
    hash

_.extend TrackerDashboard.Model, Backbone.extensions.include

$ ->
  window.router = new TrackerDashboard.Router()
  Backbone.history.start()

