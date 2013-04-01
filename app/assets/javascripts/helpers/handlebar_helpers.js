Handlebars.registerHelper('progressWidth', function(metrics, total) {
  console.log(arguments);
  var metricName = skyline.app.get('metric');
  metrics = metrics || {};
  return 100.0 * (metrics[metricName] || 0) / total[metricName];
});

Handlebars.registerHelper("showVelocity", function(total, options) {
  return skyline.app.get('metric') == 'points' && total.velocity ? options.fn(total) : "";
});

Handlebars.registerHelper("extraVelocityWidth", function() {
  var total = this;
  if(total.velocity) {
    var val = total[skyline.app.get('metric')];
    console.log(val, total.velocity)
    return val < total.velocity ? 0 : 100.0 * (1.0 - total.velocity / val);
  } else {
    return "0";
  }
});

Handlebars.registerHelper('metricValue', function(metrics) {
  var metricName = skyline.app.get('metric');
  metrics = metrics || {};
  return Math.round(metrics[metricName] || 0);
});


Handlebars.registerHelper('metricName', function() {
  return skyline.app.get('metric');
});


Handlebars.registerHelper('formatDate', function(finishDate) {
  return ( finishDate.getUTCMonth() + 1 ) + '/' + finishDate.getUTCDate() + '/' + finishDate.getUTCFullYear();
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
    'B' : 'icon-bug',
    'C' : 'icon-chore',
    'F' : 'icon-feature'
  }[storyChar];
});

Handlebars.registerHelper('eachState', function(options) {
  var self = this;
  return _.map([ "accepted", "delivered", "finished", "started", "rejected" ], function(state) {
    return self[state] ? options.fn({name: state, value: self[state]}) : "";
  }).join("");
});

Handlebars.registerHelper('stateBadge', function(stateName) {
  var metricName = skyline.app.get('metric');
  return new Handlebars.SafeString(
          this[stateName]
                  ? '<span class="badge badge-' + stateName + '">' +
                    Math.round(this[stateName][metricName]) +
                    '</span>'
                  :""
  );
});
