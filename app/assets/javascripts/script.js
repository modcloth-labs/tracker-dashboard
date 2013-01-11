var trackerDashboard = {
  
  init: function() {
    $( '#dashboard' ).html( '<tbody><tr></tr></tbody>' );
    
    $.ajax({
      url: "data/projects.json", 
      dataType: 'json',
      async: false,
      success: function( data ) {
        trackerDashboard.renderProjects( data.projects );
      }
    });
    
  },
  
  renderProjects: function( projects ) {
    var cellWidth = 100 / projects.length;

    $( '#dashboard tr:first').html(HandlebarsTemplates["project/index"]({
      projects: projects,
      cellWidth: cellWidth
    }));
  }
}

$(document).ready(function() {
  trackerDashboard.init();
});
