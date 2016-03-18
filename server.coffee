#!/usr/bin/env node

###
	Module dependencies.
###
http = require 'http'
debug = require('debug')('local-express-app')
app = require './coffee/app'

###
	Normalize a port into a number, string, or false.
###
normalizePort = (val) ->
	port = parseInt val, 10

	return val if isNaN port

	return port if port >= 0

	return false

###
	Get port from environment and store in Express.
###
port = normalizePort process.env.PORT || '3000'
app.set 'port', port

###
	Create HTTP server.
###
server = http.createServer app

###
	Listen on provided port, on all network interfaces.
###
server.listen port

###
	Event listener for HTTP server "error" event.
###
server.on 'error', (error) ->
	throw error if error.syscall isnt 'listen'

	bind = if port? then 'Pipe ' + port else 'Port ' + port

	# handle specific listen errors with friendly messages
	switch error.code
		when 'EACCES'
			console.error bind + ' requires elevated privileges'
			process.exit(1)
		when 'EADDRINUSE'
			console.error bind + ' is already in use'
			process.exit(1)
		else throw error

###
	Event listener for HTTP server "listening" event.
###
server.on 'listening', ->
	addr = server.address()
	bind = if addr? then 'pipe ' + addr else 'port ' + addr.port
	debug 'Listening on ' + bind
