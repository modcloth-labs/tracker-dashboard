var trackerDashboard = {
  
  init: function() {
    $( '#dashboard' ).html( '<tbody><tr></tr></tbody>' );
    
    $.ajax({
      url: "data/projects.json", 
      dataType: 'json',
      async: false,
      success: function(data) {
        trackerDashboard.renderProjects( data.projects );
      }
    });
    
  },
  
  renderProjects: function( projects ) {
    var width = 100 / projects.length;
    
    _.each( projects, function( project ) {
      
      $( '#dashboard tr:first' ).append( '<td id="project-' + project.id  + '" width="' + width + '%" nowrap></td>' );
      
      $( '#project-' + project.id ).html(
        trackerDashboard.renderProjectHeader( project ) +
        trackerDashboard.renderProjectProgress( project ) +
        trackerDashboard.renderProjectEpics( project )
      );
    });
  },
  
  renderProjectHeader: function( project ) {
    var finishDate = new Date( project.iteration.finish );
    
    return '\
      <div class="navbar navbar-header">\
        <div class="navbar-inner">\
          <div>\
            <p class="lead">' + project.name + '</p>\
          </div>\
          <div class="project-stats">\
            Sprint ends: ' + ( finishDate.getMonth() + 1 ) + '/' + finishDate.getDate() + '/' + finishDate.getFullYear() + '\
          </div>\
        </div>\
      </div>';
  },
  
  renderProjectProgress: function( project ) {
    var totals = _.map( project.progress, function( value, state ) { return value } );
    var total = _.reduce( totals, function( memo, num ) { return memo + num; }, 0 );
    
    return '\
      <div class="progress progress-striped active">\
        <div class="bar bar-started" style="width: ' + ( project.progress.started / total ) * 100 + '%;"></div>\
        <div class="bar bar-finished" style="width: ' + ( project.progress.finished / total ) * 100 + '%;"></div>\
        <div class="bar bar-delivered" style="width: ' + ( project.progress.delivered / total ) * 100 + '%;"></div>\
        <div class="bar bar-accepted" style="width: ' + ( project.progress.accepted / total ) * 100 + '%;"></div>\
        <div class="bar bar-rejected" style="width: ' + ( project.progress.rejected / total ) * 100 + '%;"></div>\
      </div>\
    ';
  },
  
  renderProjectEpics: function( project ) {
    var html = '';
    
    _.each( project.epics, function( epic, index ) {
      
      epic_id = '' + project.id + '-' + index + '';
      
      html += '\
        <div class="accordion" id="epic-' + epic_id + '">\
          <div class="accordion-group">\
            <div class="accordion-heading">\
              <a class="accordion-toggle" data-toggle="collapse" data-parent="epic-' + epic_id + '" href="#stories-' + epic_id + '">\
                <p class="lead">' + epic.name + '</p>\
              </a>\
            </div>\
            <div class="stats-inner" id="stats-' + epic_id + '">\
              ' + trackerDashboard.renderEpicStats( epic ) + '\
            </div>\
            <div id="stories-' + epic_id + '" class="accordion-body collapse">\
              <div class="accordion-inner">\
                ' + trackerDashboard.renderEpicStories( epic ) + '\
              </div>\
            </div>\
          </div>\
        </div>';
    });
    
    return html;
  },
  
  renderEpicStories: function( epic ) {
    var html = '<table class="table wrap">';
    
    _.each( epic.stories, function( story ) {
      html += '\
        <tr>\
          <td width="10%">\
            ' + story.story_type.charAt( 0 ).toUpperCase() + '\
          </td>\
          <td width="90%">\
            ' + story.name + '\
          </td>\
        </tr>';
    });
    
    html += '</table>';
    return html;
  },
  
  renderEpicStats: function( epic ) {
    var html = '';
    
    _.each( epic.progress, function( value, story_state ) {
      html += '<span class="badge badge-' + story_state + '">' + value + '</span>';
    });
    
    return html;
  }

}

$(document).ready(function() {
  trackerDashboard.init();
});