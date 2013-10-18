`define([
    'backbone'
],
function(Backbone){`

class PlayerModel extends Backbone.Model

    defaults:
        playerId: null
        name: 'Playah'
        balance: 1500 # See rules
        position: 0 # Tile index the player is on

    initialize: ->

    wantsToBuy: (tile) ->
        return true
        # return confirm(@.get('name') + ', do you want to buy ' + tile.get('name') + ' for £' + tile.get('price') + '?');

    updateBalance: (amount) ->
        @balance += amount

return PlayerModel

`})`
