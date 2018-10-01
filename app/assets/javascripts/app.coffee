$(document).on 'turbolinks:load', ->
  $('.disabled').click (e)->
     e.preventDefault()
  $('#datePickerInput').datepicker(
      todayHighlight: true
      format: "yyyy-mm-dd"
      autoClose: true
    )
  $('#datePicker').click(->
    $('#datePickerInput').datepicker('show').on('changeDate', (e)->
      if $(@).data('reload-path')
        Turbolinks.visit("/dates/#{e.format()}?\
          reload_path=#{$(@).data('reload-path')}/#{e.format()}")
      else
        Turbolinks.visit("/dates/#{e.format()}")
      )
    )