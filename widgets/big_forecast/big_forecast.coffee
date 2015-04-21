class Dashing.BigForecast extends Dashing.PivotalLifeWidget

  constructor: ->
    super
    @forecast_icons = new Skycons({"color": "white"})
    @forecast_icons.play()

  ready: ->
    # This is fired when the widget is done being rendered
    @setIcons()

  onData: (data) ->
    # Handle incoming data
    # We want to make sure the first time they're set is after ready()
    # has been called, or the Skycons code will complain.
    if @forecast_icons.list.length
      @setIcons()

  setIcons: ->
    @setIcon('current_icon')
    @setIcon('next_icon')
    @setIcon('later_icon')

  setIcon: (name) ->
    skycon = @toSkycon(name)
    @forecast_icons.set(name, eval(skycon)) if skycon

  toSkycon: (data) ->
    if @get(data)
      'Skycons.' + @get(data).replace(/-/g, "_").toUpperCase()
