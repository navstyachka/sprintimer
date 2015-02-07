# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

App = {}

$ ->
  $('[timer-app]').each -> new App.TimerApp(@)

class App.TimerApp
  constructor: (el)->
    @el = $(el)
    new App.TimersController($('[data-interval-sections]', @el))

class App.TimersController
  constructor: (el)->
    @el = el
    @addButton = $('[data-add-interval]')
    @timer = $('[data-timer]', @el)
    @index = @timer.size() + 1

    # init first timers
    @timer.each -> new App.Timer(@)

    @addButton.on 'click', =>
      console.log 'added'
      @addInterval()

    deleteInterval = =>
      $('[data-timer]', @el).on 'click', '[data-delete-interval]', (e)=>
        @removeInterval $(e.target)

    deleteInterval()

    $(document).on 'action:addedInterval', =>
      deleteInterval()


  createTimerView: =>
    return $ "
      <div class='timer-section' data-timer='#{@index}'>
          <input class='minutes' data-timer-input value='10'>
          <span>minutes interval</span>
          <i class='delete' data-delete-interval>[X]</i>
      </div>
    "

  addInterval: =>
    @el.append @createTimerView()
    @index += 1
    $(document).trigger 'action:addedInterval'

  removeInterval: (el)=>
    el.parents('[data-timer]').remove()


class App.Timer
  constructor: (el)->
    @el = $(el)
    console.info 'inited Timer class'

  startTimer: =>
    console.info 'start timer'

  stopTimer: =>
    console.info 'stop timer'

