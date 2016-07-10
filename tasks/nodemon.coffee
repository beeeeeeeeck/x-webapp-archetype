# startup server by nodemon
_ = require 'underscore'

startup = (opt)->
	{exec, spawn} = require 'child_process'
	env = process.env
	env.DEBUG = 'express:router'
	target = ['server.coffee', '--ignore', 'coffee/client']
	target.unshift '--debug' if opt?.debug
	target.unshift '--debug-brk' if opt?.debugBRK
	nodemon = spawn "node_modules/.bin/nodemon", target, {env:env}
	nodemon.stdout.pipe(process.stdout, end: false)
	nodemon.stderr.pipe(process.stderr, end: false)

exports.startup = startup
