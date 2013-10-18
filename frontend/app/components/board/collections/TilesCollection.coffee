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

    model: (attrs, options) =>
        cls = TileModel
        if attrs.type of TileModel.innerTileClasses
            cls = TileModel.innerTileClasses[attrs.type]
        ret = new cls attrs, @
        console.log ret
        ret

return TilesCollection

`})`
