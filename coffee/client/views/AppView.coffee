$ = require 'jquery'
_ = require 'underscore'
Backbone = require 'backbone'

class AppView extends Backbone.View
	el: '#container'
	initialize: (options) ->
		@render()
	render: ->
		@$el.html 'Hello world, LOL'

module.exports = AppView
