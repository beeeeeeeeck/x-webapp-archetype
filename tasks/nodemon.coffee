###

    nodemon tasks

###

# startup server by nodemon
startup = ->
	{exec, spawn} = require 'child_process'
	env = process.env
	env.DEBUG = 'express:router'
	nodemon = spawn "nodemon", ['server.coffee'], {env:env}
	nodemon.stdout.pipe(process.stdout, end: false)
	nodemon.stderr.pipe(process.stderr, end: false)

exports.startup = startup
