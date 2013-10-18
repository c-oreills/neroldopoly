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
            rent = @rentalAmount game
            player.updateBalance(-rent)
            @owner.updateBalance(rent)

    purchase_price: ->
        @options.price

    group: ->
        @collection.where {'type': 'company'}

    groupAllOwned: ->
        for i in @group
            if i.owner != @owner
                return false
        return true

    numberOfGroupOwned: ->
        c = 0
        for i in @group
            if i.owner == @owner
                c++
        return c

class StreetTileModel extends OwnedTileModel
    constructor: (options) ->
        @houses = 0
        super options

    rentalAmount: (game) ->
        rent = @options.rents[@houses]
        if @houses == 0 and @groupAllOwned
            rent *= 2
        rent

    group: ->
        @collection.where {
            'type': 'street',
            'color': @options.color
        }

class RailwayTileModel extends OwnedTileModel
    rentalAmount: (game) ->
        rents = [0, 25, 50, 100, 200]
        rents[@numberOfGroupOwned]

class UtilityTileModel extends OwnedTileModel
    rentalAmount: (game) ->
        multiplier = @groupAllOwned ? 4 : 10
        multiplier * game.dice.total

class CardModel extends TileModel

class CommunityChestCardModel extends CardModel

class ChanceCardModel extends CardModel

TileModel.innerTileClasses = {
    'street': StreetTileModel,
    'communityChest': CommunityChestCardModel,
    'chance': ChanceCardModel,
    'company': RailwayTileModel,
    'utility': UtilityTileModel,
}

return TileModel

`})`
