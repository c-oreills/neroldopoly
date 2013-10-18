`define(['knockout'], function(ko){`

# Provides a knockout facet which handles the binding of a viewmodel
# to an element, as well as cleaning on context destruction
#
# Usage:
#
#   myComponent:
#     create:
#       module: 'my/module'
#     knockout
#       bind: 'elementReference'
#
return (options) ->

    boundElement = null

    readyFacet = (resolver, proxy, wire) ->
        wire.resolveRef(proxy.options.bind).then (bindElement) ->
            ko.applyBindings proxy.target, bindElement
            boundElement = bindElement
            resolver.resolve()

    context:
        destroy: (resolver) ->
            ko.cleanNode boundElement
            resolver.resolve()

    facets:
        knockout:
            'ready:after': readyFacet

`})`
