`define([
    'backbone'
],
function(Backbone){`

class TileModel extends Backbone.Model
    constructor(@options): ->
        types = {
            'street': 'StreetTileModel'
        }
        console.log @
        super options

class OwnedTileModel extends TileModel
    constructor(options): ->
        @owner = null
        console.log 'ownedtile'
        super options

    accept(player): ->
        if not @owner:
            if player.wants_to_buy:
                player.update_balance -@purchase_price
                @owner - player 
            else:
                # Do nothing
        else if @owner == player:
            # Do nothing
        else:
            rent = @rental_amount
            player.update_balance -rent
            @owner.update_balance rent

    purchase_price: ->
        @options.price

class StreetTileModel extends OwnedTileModel
    constructor(options): ->
        @houses = 0
        console.log 'street'
        super options

    rental_amount: ->
        @options.rents[0]

return TileModel

`})`
