`define([
    'jquery',
    'backbone',
    'app/components/board/models/TileModel'
],
function(jQuery, Backbone, TileModel){`

class TilesCollection extends Backbone.Collection

    url: 'json/tiles.json'

    model: TileModel

    set: (key, val, options) ->
        temp = JSON.parse key
        super temp.tiles, val, options

return TilesCollection

`})`
