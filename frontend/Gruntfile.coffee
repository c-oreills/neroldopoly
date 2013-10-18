module.exports = (grunt) ->

    cjsLoader = moduleLoader: 'curl/loader/cjsm11'

    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'

        coffee:
            options:
                bare: true
            compile:
                expand: true
                cwd: 'app'
                src: ['**/*.coffee']
                dest: 'www/app'
                ext: '.js'
            specs:
                expand: true
                cwd: 'spec'
                src: ['**/*.coffee']
                dest: 'www/specs'
                ext: '.js'

        watch:
            coffee:
                files: ["app/**/*.coffee", "spec/**/*.coffee"]
                tasks: ["coffee"]

        connect:
            server:
                options:
                    port: 8000,    
                    hostname: '0.0.0.0'
                    base: 'www'

        copy:
            lib: 
                files: 
                    [
                        {expand: true, src: ['lib/**'], dest: 'www/'},
                        {expand: true, cwd:'app/json', src: ['*'], dest: 'www/json'}
                    ]
            static: 
                files: 
                    [
                        {src: 'index.html', dest: 'www/index.html'},
                        {expand: true, src: ['lib/**'], dest: 'www/'}
                    ]

    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-shell'
    grunt.loadNpmTasks('grunt-contrib-connect')

    grunt.registerTask 'default', ['coffee', 'copy', 'connect', 'watch']
