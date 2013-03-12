$(function() {
  $('form .project .project_enabled').click(function() {
    var $this = $(this);
    _(function() {
      $this.closest('.project').find("section.labels").toggle($this.is(':checked'));
    }).defer();
  });

  $('.project-label').on('change', function(e) {
    if (e.target.checked) {
      $(this).parent().addClass('selected');
    } else {
      $(this).parent().removeClass('selected');
    }
  });
});
