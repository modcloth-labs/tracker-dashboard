Handlebars.registerHelper('progressWidth', function(metrics) {
  var metricName = app.get('metric');
  metrics = metrics || {};
  var total = _.reduce( _(this).chain().values().pluck(metricName).value(), function( memo, num ) { return memo + num; }, 0 );
  return 100.0 * (metrics[metricName] || 0) / total;
});

Handlebars.registerHelper('formatDate', function(finishDate) {
  return ( finishDate.getMonth() + 1 ) + '/' + finishDate.getDate() + '/' + finishDate.getFullYear();
});

Handlebars.registerHelper('estimateString', function(estimate) {
  return estimate == -1 ? "" : estimate;
});

Handlebars.registerHelper('consoleLog', function() {
  console.log(this, arguments);
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
  var metricName = app.get('metric');
  if(this[stateName] && this[stateName].length > 3)
  console.log(stateName, this[stateName][metricName]);
  return new Handlebars.SafeString(
          this[stateName]
                  ? '<span class="badge badge-' + stateName + '">' + this[stateName][metricName] + '</span>'
                  :""
  );
});
