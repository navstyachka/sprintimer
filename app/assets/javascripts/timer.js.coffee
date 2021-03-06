App = {}

$ ->
  $('[timer-app]').each -> new App.TimerApp(@)

class App.TimerApp
  constructor: (el)->
    @el = $(el)
    new App.IntervalsController($('[data-interval-sections]', @el))
    @timer = new App.Timer(@el)

class App.IntervalsController
  INTERVAL_CHANGED: 'interval:changed'
  constructor: (el)->
    @el = el
    @addButton = $('[data-add-interval]')
    @timer = $('[data-interval]', @el)
    @index = @timer.size() + 1

    @addButton.on 'click', =>
      @addInterval()

    deleteInterval = =>
      @el.on 'click', '[data-delete-interval]', (e)=>
        @removeInterval $(e.target)

    deleteInterval()

    $(document).on @INTERVAL_CHANGED, =>
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
    $(document).trigger @INTERVAL_CHANGED

  removeInterval: (el)=>
    el.parents('[data-interval]').remove()
    $(document).trigger @INTERVAL_CHANGED


class App.Timer
  TIMER_ACTION_START: 'timer:started'
  TIMER_ACTION_CLEAR: 'timer:cleared'

  constructor: (el)->
    @el = $(el)
    @tickerView = $('[data-timer-ticker]', @el)
    @startTimerBtn = $('[data-start-timer]', @el)
    @pauseTimerBtn = $('[data-pause-timer]', @el)
    @clearTimerBtn = $('[data-clear-timer]', @el)

    @gatherIntervals()

    $(document).on App.IntervalsController.INTERVAL_CHANGED, =>
      @clearTimer()

    @clearTimerBtn.on 'click', =>
      @clearTimer()

    @startTimerBtn.on 'click', =>
      if @paused
        @startTimer()
      else
        @gatherIntervals()
        @startTimer()

    @pauseTimerBtn.on 'click', =>
      @pauseTimer()

  startTimer: =>
    @timer = setInterval((=>
      if @currentInterval == 0
        @changeInterval()

      @currentInterval--
      @viewTick()
    ), 1000)

  changeInterval: =>
    @intervals.push @intervals.shift()
    @currentInterval = @intervals[0]
    console.info "Next interval is #{@currentInterval}"

  viewTick: =>
    minutes = Math.round(@currentInterval / 60) - 1
    if !@seconds then @seconds = 60
    @seconds--
    @tickerView.html "#{minutes} : #{@seconds} (#{@currentInterval})"

  clearTimer: =>
    clearInterval @timer
    @tickerView.html "00:00 #{@currentInterval}"

  pauseTimer: =>
    @paused = true
    clearInterval @timer

  unpauseTimer: =>
    @paused = false

  gatherIntervals: =>
    @clearTimer()
    intervals = []
    $('[data-interval-input]', @el).each ->
      intervals.push parseInt($(@).val()) * 60
    @intervals = intervals
    @currentInterval = @intervals[0]


