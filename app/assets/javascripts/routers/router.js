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
      this.view = new skyline.ProjectsView.IndexView({ app: skyline.app });
      $("#dashboard").html( this.view.render().el );
    },

    epics: function() {
      this.view = new skyline.EpicsView.IndexView({ app: skyline.app });
      $("#dashboard").html( this.view.render().el );
    },

    releases: function() {
      this.view = new skyline.ReleasesView.IndexView({ app: skyline.app });
      $("#dashboard").html( this.view.render().el );
    }
  });
  
  skyline.router = new skyline.Router();
  Backbone.history.start({ pushState: true });

});