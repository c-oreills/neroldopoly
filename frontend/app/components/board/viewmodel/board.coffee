`define([
    'knockout',
    'backbone',
    'knockback',
],
function(ko, Backbone, kb){`

class BoardViewModel extends kb.ViewModel

    init: ->
        @tiles = kb.collectionObservable(@tilesCollection)

return BoardViewModel


`})`