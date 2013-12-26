jQuery ->
  $('#articles').sortable
    axis: 'y'
    handle: '.handle'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize') + "&" + "guide=" + $(this).data('guide'))