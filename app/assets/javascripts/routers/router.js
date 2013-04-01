var skyline = skyline || {};

$(function() {
  'use strict';
  
  skyline.Router = Backbone.Router.extend({

    routes: {
      "projects": "projects",
      "epics": "epics",
      "releases": "releases"
    },

    projects: function() {
      this.view = new skyline.Views.Projects.IndexView({ app: skyline.app });
      $("#dashboard").html( this.view.render().el );
    },

    epics: function() {
      this.view = new skyline.Views.Epics.IndexView({ app: skyline.app });
      $("#dashboard").html( this.view.render().el );
    },

    releases: function() {
      this.view = new skyline.Views.Releases.IndexView({ app: skyline.app });
      $("#dashboard").html( this.view.render().el );
    }
  });
  
  skyline.router = new skyline.Router();
  Backbone.history.start({ pushState: true });

});