Handlebars.registerHelper('progressWidth', function(progress) {
  var total = _.reduce( _(this).values(), function( memo, num ) { return memo + num; }, 0 );
  return 100.0 * progress / total;
});

Handlebars.registerHelper('sprintEnd', function() {
  var finishDate = new Date( this.iteration.finish );
  return ( finishDate.getMonth() + 1 ) + '/' + finishDate.getDate() + '/' + finishDate.getFullYear();
});

Handlebars.registerHelper('iconClassFor', function(storyType) {
  var storyChar = storyType.charAt( 0 ).toUpperCase();
  return {
    'B' : 'icon-fire',
    'C' : 'icon-wrench',
    'F' : 'icon-star'
  }[storyChar];
});

Handlebars.registerHelper('stateBadge', function(stateName) {
  return new Handlebars.SafeString(
          this[stateName]
                  ? '<span class="badge badge-' + stateName + '">' + this[stateName] + '</span>'
                  :""
  );
});
