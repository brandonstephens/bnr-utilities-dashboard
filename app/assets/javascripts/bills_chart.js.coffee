class BillsChart
  MARGIN = {top: 10, bottom: 20, left: 40, right: 0}

  constructor: (data, selector) ->
    @width  = $(selector).width() - MARGIN.left - MARGIN.right
    @height = 400

    @x     = d3.time.scale().range([0, @width])
    @y     = d3.scale.linear().range([@height, 0])
    @color = d3.scale.category10()
    @xAxis = d3.svg.axis().scale(@x).orient('bottom')
    @yAxis = d3.svg.axis().scale(@y).orient('left')
    @line  = d3.svg.line().x((d) -> @x(d.due_on)).y((d) -> @y(d.amount))

    @node = d3.select(selector).append('svg')
      .attr('width', @width + MARGIN.left + MARGIN.right)
      .attr('height', @height + MARGIN.top + MARGIN.bottom)
      .append('g')

    @addAll(data)

  addAll: (data) ->
    @data = []
    data.forEach((d) => @addOne(d))

  addOne: (datum) ->
    datum.due_on = @parseDate(datum.due_on)
    datum.amount = +datum.amount
    @data.push datum

  parseDate: d3.time.format('%Y-%m-%d').parse

  utilities: ->
    d3.nest()
      .key((d) -> d.utility_id)
      .sortValues((a, b) ->
        d3.ascending(a.due_on, b.due_on))
      .entries(@data)

  update: ->
    @updateAxes()
    @updateLines()

  updateAxes: ->
    @color.domain d3.keys(@utilities())
    @x.domain d3.extent(@data, (d) -> d.due_on)
    @y.domain d3.extent(@data, (d) -> d.amount)

    d3.transition(@node).select('g.y.axis').call(@yAxis)
    d3.transition(@node).select('g.x.axis').call(@xAxis)

  updateLines: ->
    utility = @node.selectAll('.utility')
      .data(@utilities())

    utility_enter = utility.enter().append('g')
      .attr('class', 'utility')

    utility_enter.append('path')
      .attr('class', 'line')
      .attr('d', (d) => @line(d.values))
      .style('stroke', (d) => @color(d.key))

    utility_update = d3.transition(utility)

    utility_update.select('path')
      .transition().duration(600)
      .attr('d', (d) => @line(d.values))

    utility.exit().remove()

  render: ->
    @updateAxes()

    @node
      .attr('transform', "translate(#{ MARGIN.left }, #{ MARGIN.top })")

    @node.append('g')
      .attr('class', 'x axis')
      .attr('transform', "translate(0, #{ @height })")
      .call(@xAxis)

    @node.append('g')
      .attr('class', 'y axis')
      .call(@yAxis)
      .append('text')
      .attr('transform', 'rotate(-90)')
      .attr('y', 6)
      .attr('dy', '.71em')
      .style('text-anchor', 'end')
      .text('Amount ($)')

    @updateLines()

$(document).on 'ready page:load', ->
  if $('#bills-chart').length > 0
    data = $('#bills-chart').data('bills')
    chart = new BillsChart(data, '#bills-chart')
    chart.render()
