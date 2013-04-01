skyline.Model = Backbone.RelationalModel.extend({
  
  parse: function( attrs ) {
    _.each( attrs, function( v, k ) {
      if( v && _.isFunction( v.match ) && v.match( /^20\d\d.*T.*Z$/ ) ) {
        attrs[k] = new Date( v );
      }
    });
    return attrs;
  },
  
  toJSON: function() {
    var hash = {}
    _.each( this.attributes, function( v,k ) {
      if( !( v instanceof skyline.Model || v instanceof Backbone.Collection ) ) {
        hash[k] = v;
      }
    });
    return hash;
  }
  
});

_.extend( skyline.Model, Backbone.extensions.include );