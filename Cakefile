# cake
fs = require 'fs'
require 'coffee-script/register'

async = require 'async'

javascript = require './tasks/javascript'
nodemon = require './tasks/nodemon'

task 'compile:js', "Compiles all client coffee files into js files...", (opts) ->
	options = opts
	javascript.compile()

task 'nodemon', "Run and watch the server...", ->
	watch_files ->
		nodemon.startup()

watch_files = (next)->
	async.series [
		javascript.watch
	], ->
		console.log 'Watching client files...'
		next() if next?
