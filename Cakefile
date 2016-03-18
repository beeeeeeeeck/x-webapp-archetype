# cake
fs = require 'fs'
require 'coffee-script/register'

async = require 'async'

javascript = require './tasks/javascript'
nodemon = require './tasks/nodemon'
unittest = require('./tasks/unittest')

task 'compile:js', "Compiles all client coffee files into js files...", ->
	javascript.compile()

task 'nodemon', "Run and watch the server...after test and compile", ->
	unittest.test {}, ->
		javascript.compile ->
			watch_files ->
				nodemon.startup()

option '-t','--test [testName]', 'Test a specific unit test'
task 'test', "Run Mocha unit tests...", (opt) ->
	unittest.test opt

watch_files = (next)->
	async.series [
		javascript.watch
	], ->
		console.log 'Watching client files...'
		next() if next?
