$(function() {
  $('form .project .project_enabled').click(function() {
    var $this = $(this);
    _(function() {
      $this.closest('.project').find("section.labels").toggle($this.is(':checked'));
    }).defer();
  });
});
