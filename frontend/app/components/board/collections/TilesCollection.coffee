`define([
    'jquery',
    'backbone'
],
function(jQuery, Backbone){`

class TilesCollection extends Backbone.Collection

    url: 'json/tiles.json'

    set: (key, val, options) ->
        temp = JSON.parse key
        super temp.tiles, val, options

return TilesCollection

`})`
