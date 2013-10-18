`(function(curl){`

cjsLoader = moduleLoader: 'curl/loader/cjsm11'

config =
    paths:
        'jquery': 'lib/jquery/jquery'
    packages: [
        { name: 'curl', location: 'lib/curl/src/curl' }
        { name: 'underscore', location: 'lib/lodash/dist', main: 'lodash.compat'}
        { name: 'lodash', location: 'lib/lodash/dist', main: 'lodash.compat'}
        { name: 'backbone', location: 'lib/backbone', main: 'backbone', config: cjsLoader }
        { name: 'knockout', location: 'lib/knockout/build/output', main: 'knockout-latest' }
        { name: 'knockback', location: 'lib/knockback', main: 'knockback', config: cjsLoader}
        { name: 'wire', location: 'lib/wire', main: 'wire' }
        { name: 'meld', location: 'lib/meld', main: 'meld' }
        { name: 'when', location: 'lib/when', main: 'when' }
        { name: 'poly', location: 'lib/poly' }
    ]
    # preloads: ['app/utils/jquery-setup']

success = (context) ->
    window.context = context
    console.log 'Spec loading OK! Context available as \'context\''

fail = (error) ->
    console.log 'Error loading spec'
    if error.stack
        console.error error.stack

curl(config, ['wire!app/spec']).then success, fail

`})(curl)`
