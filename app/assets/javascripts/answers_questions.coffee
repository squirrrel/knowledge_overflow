# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(() ->
  $('.increase').click((event) =>
    id = $(event.target).closest('td').attr('id')
    user_vote = localStorage.getItem(id)

    if user_vote is null or user_vote is 'decreased'
      localStorage.setItem id, 'increased'
    else
      false
  )

  $('.decrease').click((event) =>
    id = $(event.target).closest('td').attr('id')
    user_vote = localStorage.getItem(id)

    if user_vote is null or user_vote is 'increased'
      localStorage.setItem id, 'decreased'
    else
      false
  )
)
