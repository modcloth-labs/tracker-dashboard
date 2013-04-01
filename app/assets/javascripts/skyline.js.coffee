#= require_self
#= require_tree ./helpers
#= require_tree ./models
#= require_tree ./routers
#= require_tree ./templates
#= require_tree ./views

window.Skyline =
  Models: {}
  Collections: {}
  Views: {}

Skyline.Model = Backbone.RelationalModel.extend
  parse: (attrs) ->
    _.each attrs, (v, k) =>
      attrs[k] = new Date(v) if v && _.isFunction(v.match) && v.match /^20\d\d.*T.*Z$/
    attrs
  toJSON: ->
    hash = {}
    _.each @attributes, (v,k) =>
      hash[k] = v unless v instanceof Skyline.Model || v instanceof Backbone.Collection
    hash

_.extend Skyline.Model, Backbone.extensions.include

$ ->
  window.router = new Skyline.Router()
  Backbone.history.start
    pushState: true

