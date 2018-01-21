//= require jquery3
//= require jquery_ujs
//= require popper
//= require bootstrap-sprockets
//= require_tree .

$('#otherAction').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget)
  var recipient = button.data('order')
  var modal = $(this)
  modal.find('input#token').val(recipient)
})
