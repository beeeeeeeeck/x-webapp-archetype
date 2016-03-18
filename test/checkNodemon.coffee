fs = require "fs"
path = require 'path'

_ = require 'underscore'
require "should"

describe "Nodemon is checking configuration that", ->

	readNodemonConfigPromise = new Promise (resolve, reject) ->
		nodemonConfig = path.join __dirname, '..', 'nodemon.json'
		fs.readFile nodemonConfig, "utf8", (err, data) ->
			reject err if err?
			resolve JSON.parse(data)

	it 'config target should exist', (done) ->
		readNodemonConfigPromise.then (data) ->
			data.should.exist
			done()
		, (err) ->
			err.should.not.exist
			done()

	it 'restartable should be rs', (done) ->
		readNodemonConfigPromise.then (data) ->
			data['restartable'].should.exist
			data['restartable'].should.be.equal 'rs'
			done()
		, (err) ->
			err.should.not.exist
			done()

	it 'ignored list should have \'tasks\', \'public/js/*-coffee.js\' and \'coffee/client/*.coffee\'', (done) ->
		readNodemonConfigPromise.then (data) ->
			data['ignore'].should.exist
			data['ignore'].length.should.above 0
			expect = [
				'tasks'
				'public/js/*-coffee.js'
				'coffee/client/*.coffee'
			]
			result = _.every expect, (el) -> _.contains data['ignore'], el
			result.should.be.true()

			done()
		, (err) ->
			err.should.not.exist
			done()
