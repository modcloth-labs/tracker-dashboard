//= require_self
//= require_tree ./helpers
//= require ./models/model
//= require_tree ./models
//= require_tree ./collections
//= require_tree ./routers
//= require_tree ./templates
//= require_tree ./views

var skyline = skyline || {};

$(function() {
  'use strict';
  
  skyline.app = new skyline.App();
  if( $.cookie('metric') ) {
    skyline.app.set( 'metric', $.cookie('metric') );
  }

  if( $.cookie('filter_tiny_items') ) {
    skyline.app.set( 'filter_tiny_items', true );
  }


  skyline.appView = new skyline.AppView({ app: skyline.app, el: $("#root") });
  
  skyline.app.fetch().then( function() {
    skyline.app.trigger('change');

    skyline.router = new skyline.Router();
    Backbone.history.start({ pushState: true });
  });
  
});