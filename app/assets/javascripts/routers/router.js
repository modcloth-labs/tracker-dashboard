var skyline = skyline || {};

$(function() {
  'use strict';

  function render(element) {
    $("#dashboard").html( element );
  }
  
  skyline.Router = Backbone.Router.extend({

    routes: {
      "projects": "projects",
      "epics": "epics",
      "releases": "releases"
    },

    projects: function() {
      this.view = new skyline.ProjectsView.IndexView({ app: skyline.app });
      render(this.view.render().el);
    },

    epics: function() {
      this.view = new skyline.EpicsView.IndexView({ app: skyline.app });
      render(this.view.render().el);
    },

    releases: function() {
      this.view = new skyline.ReleasesView.IndexView({ app: skyline.app });
      render(this.view.render().el);
    }
  });
});