var skyline = skyline || {};

$(function() {
  'use strict';
  
  skyline.Router = Backbone.Router.extend({

    routes: {
      "projects": "projects",
      "epics": "epics",
      "releases": "releases"
    },

    initialize: function() {
      this.app = new skyline.App();

      if( $.cookie('metric') ) {
        this.app.set( 'metric', $.cookie('metric') );
      }
      if( $.cookie('filter_tiny_items') ) {
        this.app.set( 'filter_tiny_items', true );
      }

      window.app = this.app;
      this.appView = new skyline.Views.AppView({ app: this.app, el: $("#root") });

      var _this = this;
      this.app.fetch().then( function() {
        _this.app.trigger('change');
      });
    },

    projects: function() {
      this.view = new skyline.Views.Projects.IndexView({ app: this.app });
      $("#dashboard").html( this.view.render().el );
    },

    epics: function() {
      this.view = new skyline.Views.Epics.IndexView({ app: this.app });
      $("#dashboard").html( this.view.render().el );
    },

    releases: function() {
      this.view = new skyline.Views.Releases.IndexView({ app: this.app });
      $("#dashboard").html( this.view.render().el );
    }
  });
  
  skyline.router = new skyline.Router();
  Backbone.history.start({ pushState: true });

});