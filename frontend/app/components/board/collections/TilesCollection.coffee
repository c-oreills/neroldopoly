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
        if attrs.type of TileModel.innerTileClasses
            ret = new TileModel.innerTileClasses[attrs.type] attrs, options
        else
            ret = new TileModel attrs, options
        console.log ret
        ret

return TilesCollection

`})`
