# cake
fs = require 'fs'
require 'coffee-script/register'

async = require 'async'

javascript = require './tasks/javascript'
nodemon = require './tasks/nodemon'
unittest = require('./tasks/unittest')

task 'compile:js', "Compiles all client coffee files into js files...", ->
	javascript.compile()

startupAndWatchApp = (opt) ->
	unittest.test {}, ->
		javascript.compile ->
			watch_files ->
				nodemon.startup(opt)

task 'nodemon', "Run and watch the server...after test and compile", ->
	startupAndWatchApp()

task 'nodemon:debug', "Run and watch the server...after test and compile, with DEBUG mode", ->
	startupAndWatchApp({debug:true})

task 'nodemon:debug:brk', "Run and watch the server...after test and compile, with advanced DEBUG mode", ->
	startupAndWatchApp({debugBRK:true})

option '-t','--test [testName]', 'Test a specific unit test'
task 'test', "Run Mocha unit tests...", (opt) ->
	unittest.test opt

watch_files = (next)->
	async.series [
		javascript.watch
	], ->
		console.log 'Watching client files...'
		next() if next?
