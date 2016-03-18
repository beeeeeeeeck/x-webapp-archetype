###
    A special type queue with a no concurrency that will only execute one of the tasks if multiple are added to the queue at once
###

async = require 'async'

module.exports = class SingleTaskQueue
	@compile = false

	constructor: (@task) ->
		@queue = async.queue (t, cb) =>
			if @compile
				@task cb
			else
				cb()
		, 1

		@queue.empty = =>
			@compile = true
		@queue.saturated = =>
			@compile = false

	push: ->
		@queue.push {}
