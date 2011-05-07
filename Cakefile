fs = require('fs')
sys = require('sys')
exec = require('child_process').exec
spawn = require('child_process').spawn

option '-l', '--lint', 'Run the coffee scripts through jslint after compilation to javascript'

tar_cmd = "tar -cvjf ggnome.tar.bz2 server/"

###
Script File Data
###

c_file = (name, desc, input, output, serverside) ->
    { name: name, desc: desc, input: input, output: output, server: serverside }

scripts = [
    c_file( 'site',
        'site.js - the main entrypoint for the website',
        'src/',
        'server/',
        true
    )
]


###
Helper Functions
###

compile = (lint, input, output) ->
    lint = if lint? then 'l' else ''
    exec "coffee -cb#{lint} -o #{output} #{input}", (err, stdout, stderr) -> throw err if err

watch = (lint, input, output) ->
    lint = if lint? then 'l' else ''
    sys.print "Spawning a watcher...\n"
    coffee = spawn 'coffee', ["-w#{lint}", '-o', output, input]
    coffee.stdout.on 'data', (data) -> sys.print data
    coffee.stderr.on 'data', (data) -> sys.print data
    coffee.on 'exit', (code, signal) ->
        console.log('child process terminated due to receipt of signal ' + code);
    coffee

print_script = (script) ->
    sys.print "#{script.name}#{if script.server then '[S]'} - #{script.desc}\n"


###
Build Tasks
###

task 'build', (options) ->
    lint = if options.lint? then '-l' else ''
    scripts.forEach (script) ->
        print_script script
        exec "cake #{lint} build:#{script.name}", (err, stdout, stderr) -> throw err if err


scripts.forEach (script) ->
    task "build:#{script.name}", "Build #{script.desc}", (options) ->
        compile options.lint, script.input, script.output

task "build:docs", "Build the source documentation and the server", () ->
    folders = ("#{s.input}*.coffee" for s in scripts)
    exec "docco #{folders.join ' '}", (err, stdout, stderr) ->
        throw err if err
        sys.print "#{stdout}"
###
Watcher Tasks
###

task 'watch', (options) ->
    lint = if options.lint? then '-l' else ''
    scripts.forEach (script) ->
        args = if lint isnt '' then [lint, "watch:#{script.name}"] else ["watch:#{script.name}"]
        cakew = spawn 'cake', args
        cakew.stdout.on 'data', (data) -> sys.print data
        cakew.stderr.on 'data', (data) -> sys.print data

scripts.forEach (script) ->
    task "watch:#{script.name}", "Watch #{script.desc} for changes", (options) ->
        print_script script
        watch options.lint, script.input, script.output


###
Server Tasks
###

task 'server:start', 'Start an instance of the development server', () ->
    node = spawn 'node', ['server/site.js']
    node.stdout.on 'data', (data) -> sys.print data
    node.stderr.on 'data', (data) -> sys.print data
    process.on 'SIGINT', () -> node.kill 'SIGINT'


task 'server:dev', 'Start the coffee watcher and the dev server', (options) ->
    lint = if options.lint? then '-l' else ''
    exec "cake build #{lint}", (err, stdout, stderr) ->
        node = spawn 'cake', ['server:start']
        node.stdout.on 'data', (data) -> sys.print data
        node.stderr.on 'data', (data) -> sys.print data
        node.on 'exit', (code, signal) -> "Killing server: #{signal}[#{code}]...\n"
        coffees = []
        scripts.forEach (script) ->
            coffee = watch options.lint, script.input, script.output
            coffees.push coffee
            if script.server
                coffee.stdout.on 'data', (data) ->
                    sys.print data
                    sys.print "Restarting Web Server...\n"
                    node.kill 'SIGINT'
                    node = spawn 'cake', ['server:start']
                    node.stdout.on 'data', (data) -> sys.print data
                    node.stderr.on 'data', (data) -> sys.print data
            else
                coffee.stdout.on 'data', (data) -> sys.print data
            coffee.stderr.on 'data', (data) -> sys.print data


###
Misc. (cant spell miscellaneous, lol) Tasks
###

task 'clean', 'Clean out the compiled javascripts from server/ folder', () ->
    scripts.forEach (script) -> exec "rm #{script.output}/#{script.name}.js"
    exec 'rm ggnome.tar.bz2'
    exec 'rm docs/*'

task 'list:scripts', 'List the defined scripts in the Cakefile', () ->
    scripts.forEach (script) -> print_script script

task 'package', 'Build server and make a downloadable package from it', () ->
    build_proc = exec "cake build", (err, stdout, stderr) ->
        throw err if err
        sys.print "[BUILD]\n#{stdout}\n"
        sys.print "[ERROR] #{stderr}\n" if stderr
        tar_proc = exec tar_cmd, (err, stdout, stderr) ->
            throw err if err
            sys.print "exec: #{tar_cmd}\n#{stdout}\n"
            sys.print "[ERROR] #{stderr}\n" if stderr
