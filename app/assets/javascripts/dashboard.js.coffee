# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->

  max_num = 0
  $('.ago').each ->
    self = $(this)
    num = parseInt(self.text())
    max_num = num if num > max_num

  bad_from = Math.ceil(max_num / 3)
  urgent_from = Math.floor((max_num / 3) * 2)

  $('.ago').each ->
    self = $(this)
    cell = self.parents('td')
    num = parseInt(self.text()) || max_num
    if num > urgent_from
      cell.addClass('urgent')
    else if num > bad_from
      cell.addClass('bad')
    else
      cell.addClass('ok')
