`define([
    'knockout',
    'backbone',
    'knockback'
],
function(ko, Backbone, kb){`

class TileViewModel extends kb.ViewModel

    createTileNow: (tile) ->
        console.log tile
        
return TileViewModel


`})`