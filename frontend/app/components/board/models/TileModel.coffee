`define([
    'backbone'
],
function(Backbone){`

class TileModel extends Backbone.Model
    playerLanded: (game, player) ->

class OwnedTileModel extends TileModel
    constructor: (options) ->
        @owner = null
        super options

    playerLanded: (game, player) ->
        if not @owner
            if player.wantsToBuy(@)
                player.updateBalance(-@purchase_price)
                @owner = player
            else
                # Do nothing
        else if @owner == player
            # Do nothing
        else
            rent = @rental_amount game
            player.updateBalance(-rent)
            @owner.updateBalance(rent)

    purchase_price: ->
        @options.price

class StreetTileModel extends OwnedTileModel
    constructor: (options) ->
        @houses = 0
        super options

    rental_amount: (game) ->
        @options.rents[0]

class RailwayTileModel extends OwnedTileModel
    rental_amount: (game) ->
        25

class UtilityTileModel extends OwnedTileModel
    rental_amount: (game) ->
        4 * game.dice.total

class CardModel extends TileModel
    playerLanded: (game, player) ->
        player.updateBalance 200

class CommunityChestCardModel extends CardModel

class ChanceCardModel extends CardModel

class CardModel extends TileModel

TileModel.innerTileClasses = {
    'street': StreetTileModel,
    'communityChest': CommunityChestCardModel,
    'chance': ChanceCardModel,
    'company': RailwayTileModel,
    'utility': UtilityTileModel,
}

return TileModel

`})`
