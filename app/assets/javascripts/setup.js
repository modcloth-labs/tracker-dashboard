$(function() {
  $('form .project .project_enabled').click(function() {
    $(this).closest('.project').find("section.labels").toggle($(this).is('checked'));
  });
});
