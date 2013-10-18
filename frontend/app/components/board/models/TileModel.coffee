`define([
    'backbone'
],
function(Backbone){`

class TileModel extends Backbone.Model
    constructor: (@options) ->
        types = {
            'street': 'StreetTileModel'
        }
        super options
    playerLanded: (player) ->
        throw "IMPLEMENT ME MOFO"

class OwnedTileModel extends TileModel
    constructor: (options) ->
        @owner = null
        super options

    playerLanded: (player) ->
        if not @owner
            if player.wantsToBuy(@)
                player.updateBalance(-@purchase_price)
                @owner = player
            else
                # Do nothing
        else if @owner == player
            # Do nothing
        else
            rent = @rental_amount
            player.updateBalance(-rent)
            @owner.updateBalance(rent)

    purchase_price: ->
        @options.price

class StreetTileModel extends OwnedTileModel
    constructor: (options) ->
        @houses = 0
        super options

    rental_amount: ->
        @options.rents[0]

class GoTileModel extends TileModel

return TileModel

`})`
