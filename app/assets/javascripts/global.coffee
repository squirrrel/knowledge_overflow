$(document).on 'page:load', () ->

  $(document).on 'click', '.edit', (event) ->
    target = $(event.currentTarget)
    target.text('Save').addClass('save')

    parent = target.closest('tr.answer')
    parent.off('mouseout').off('mouseover')

    body_description = parent.find('.description div')
    text = body_description.text()
    body_description.replaceWith("<textarea>#{text}</textarea>")

  $(document).on 'click', '.save', (event) ->
    target = $(event.currentTarget)
    container = target.closest('tr')

    id = container.data('id')
    textarea = container.find('.description textarea')
    updated_description = textarea.val()

    request = 
      $.ajax({
        url: "/answers/#{id}",
        method: 'PATCH',
        data: { answer: { post: { body: updated_description } } },
        dataType: 'script'
    })

    request.done((msg) ->
      textarea.replaceWith("<div>#{updated_description}</div>")
      target.text('Edit').removeClass('save') 
    )

    request.fail((jqXHR, textStatus) ->
      $('p.alert').text(textStatus)
    )

  $('.increase').on 'click', (event) ->
    container = $(event.target).closest('td')
    id = "#{container.data('user')}_#{container.attr('id')}"
    user_vote = localStorage.getItem(id)

    if user_vote is null or user_vote is 'decreased'
      localStorage.setItem id, 'increased'
    else
      false

  $('.decrease').on 'click', (event) ->
    container = $(event.target).closest('td')
    id = "#{container.data('user')}_#{container.attr('id')}"
    user_vote = localStorage.getItem(id)

    if user_vote is null or user_vote is 'increased'
      localStorage.setItem id, 'decreased'
    else
      false

  $('.answer').on 'mouseover', (event) ->
    $(event.currentTarget).find('.edit').show()

  $('.answer').on 'mouseout', (event) ->
    $(event.currentTarget).find('.edit').hide()
