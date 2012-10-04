class App.consistency extends Backbone.View
  HEIGHT: 75
  WIDTH: 260

  FILL_COLOR: '#E2EDF7'
  PRIMARY_LINE_COLOR: '#333'
  COMPARISON_LINE_COLOR: '#C57E00'
  GOAL_LINE_COLOR: '#46A546'
  SPOT_COLOR: '#000'

  initialize: (options) ->
    super options

    @counts = @$el.data 'counts'
    @comparison_counts = @$el.data 'comparison-counts'
    @goal = @$el.data 'goal'

    @$el.sparkline @counts, @_primary_sparkline_options()

    if @comparison_counts
      @$el.sparkline @comparison_counts, @_comparison_sparkline_options()

  _primary_sparkline_options: ->
    _.extend @_default_sparkline_options(),
      fillColor: @FILL_COLOR
      lineColor: @PRIMARY_LINE_COLOR
      width: @WIDTH
      height: @HEIGHT
      normalRangeMin: 10
      normalRangeMax: 10.2
      normalRangeColor: @GOAL_LINE_COLOR
      drawNormalOnTop: true

  _comparison_sparkline_options: ->
    _.extend @_default_sparkline_options(),
      composite: true
      fillColor: false
      lineColor: @COMPARISON_LINE_COLOR

  _default_sparkline_options: ->
    spotColor: false
    minSpotColor: false
    maxSpotColor: false
    valueSpots:
      ':100': @SPOT_COLOR
    spotRadius: 1
    lineWidth: 1
    chartRangeMin: 0
    chartRangeMax: @_range_max()
    highlightLineColor: false

  _range_max: ->
    _.max(@_all_values()) + 1

  _all_values: ->
    values = @counts
    values.concat(@comparison_counts) if @comparison_counts
    values.concat([@goal]) if @goal