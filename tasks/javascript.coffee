SingleTaskQueue = require './queue'

fs = require 'fs'
path = require 'path'
async = require 'async'
uglify = require 'uglify-js'
require 'colors'

task_compile_js = (cb) ->
	console.log 'Compile/Browserfying JS...'.rainbow
	{exec, spawn} = require 'child_process'
	compile = (root,name) ->
		return (next) ->
			console.log "Compiling #{root}.coffee.".cyan
			async.series [
				(cb) ->
					exec "node_modules/.bin/browserify --transform coffeeify --debug --extension='.coffee' coffee/#{root}/#{name}.coffee -o public/js/#{root}-coffee.js", (err, stdout, stderr) ->
						console.log stdout if stdout?.length > 0
						console.log stderr if stderr?.length > 0
						console.error err if err?
						cb()
				(cb) ->
					exec "node_modules/.bin/uglifyjs public/js/#{root}-coffee.js -m -o public/js/#{root}.js", (err, stdout, stderr) ->
						console.log stdout if stdout?.length > 0
						console.log stderr if stderr?.length > 0
						console.error err if err?
						cb()
			], (err, results) ->
				console.log "File - #{root}.js is done compiling.".cyan
				next err if next?

	async.parallel [
		compile 'client', 'main'
	], (err, results) ->
		cb err if cb?

task_watch_js = (cb) ->
	jsQueue = new SingleTaskQueue task_compile_js
	watcher = require('chokidar').watch ['coffee/client'],
		persistent: true
		ignoreInitial: true

	watcher.on 'add', (path) ->
		console.log "File #{path} has been added".yellow
		jsQueue.push()
	watcher.on 'change', (path) ->
		console.log "File #{path} has been changed".green
		jsQueue.push()
	watcher.on 'unlink', (path) ->
		console.log "File #{path} has been removed".red
		jsQueue.push()
	cb() if cb?

exports.compile = task_compile_js
exports.watch = task_watch_js
