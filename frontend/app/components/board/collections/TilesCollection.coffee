`define([
    'jquery',
    'backbone',
    'app/components/board/models/TileModel'
],
function(jQuery, Backbone, TileModel){`

class TilesCollection extends Backbone.Collection

    url: 'json/tiles.json'

    set: (models, options) ->
        models = JSON.parse(models).tiles
        super models, options

    model: (attrs, options) ->
        console.log attrs
        new TileModel attrs, options

return TilesCollection

`})`
