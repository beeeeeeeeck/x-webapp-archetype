{exec, spawn} = require 'child_process'

js_unit_test = (opt, cb) ->
	console.log 'Running Mocha unit tests... '

	target = if opt?.test? then "test/#{opt.test}" else 'test'

	exec "node_modules/.bin/mocha --colors --reporter spec --ignore-leaks --compilers \'coffee:coffee-script/register\' -t 5000 #{target}", (err, stdout, stderr) ->
		console.log stdout if stdout?.length > 0
		console.log stderr if stderr?.length > 0
		process.exit 0 if err?
		cb() if cb?

exports.test = js_unit_test
