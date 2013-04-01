$(function() {
  $('form .project .project-name').click(function() {
    var $this = $(this);
    _(function() {
      $this.closest('.project').find("section.labels").toggle($this.is(':checked'));
    }).defer();
  });

  // Project form UI enhancements
  //
  // Add "selected" class to project label for styling
  $('.project-label').on('change', function(e) {
    if (e.target.checked) {
      $(this).parent().addClass('selected');
    } else {
      $(this).parent().removeClass('selected');
    }
  });

  // Fixed position submit button
  var $projectForm = $('form'); // TODO - be more exact with selector
  var $projectFormSubmitButton = $projectForm.find('button[type="submit"]');
  var $fixedButtonHolder = $('#update-button-holder');

  var projectFormSubmitFn = function() {
    $projectFormSubmitButton.click();
  };

  var showFixedSubmitButton = function() {
    $fixedButtonHolder.show();
    // hide original button in form
    $projectFormSubmitButton.hide();
    $projectForm.css('padding-bottom', $fixedButtonHolder.outerHeight() / 2);
    // bind click to form submit
    $fixedButtonHolder.find('button[type="submit"]').on('click', projectFormSubmitFn);
  };

  var hideFixedSubmitButton = function() {
    $fixedButtonHolder.hide(); 
    // unbind click
    $fixedButtonHolder.find('button[type="submit"]').off('click', projectFormSubmitFn);
    // show button in form
    $projectFormSubmitButton.show();
    $projectForm.css('padding-bottom', 0);
  };

  var toggleFixedSubmitButton = function() {
    var selectedProjects = $('.project-name:checked').length;

    if (selectedProjects > 0) {
      showFixedSubmitButton();
    } else {
      hideFixedSubmitButton();
    }
  };

  toggleFixedSubmitButton(); // Trigger on page load too

  $('.project-name').on('change', function () {
    toggleFixedSubmitButton();
  });

});
