//= require_self
//= require_tree ./helpers
//= require ./models/model
//= require_tree ./models
//= require_tree ./collections
//= require_tree ./routers
//= require_tree ./templates
//= require_tree ./views

var skyline = skyline || {
  Models: {},
  Collections: {},
  Views: {}
};

$(function() {
  'use strict';
  
  skyline.app = new skyline.App();
  skyline.appView = new skyline.Views.AppView({ app: skyline.app, el: $("#root") });
  
  if( $.cookie('metric') ) {
    this.app.set( 'metric', $.cookie('metric') );
  }
  
  if( $.cookie('filter_tiny_items') ) {
    this.app.set( 'filter_tiny_items', true );
  }
  
  skyline.app.fetch().then( function() {
    skyline.app.trigger('change');
  });
  
});