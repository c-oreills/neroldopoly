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

    wantsToBuy: ->
        # TODO: DO SOMETIHNG.
        false

    updateBalance: (amount) ->
        @balance += amount

return PlayerModel

`})`
