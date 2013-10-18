`define([
    'backbone'
],
function(Backbone){`

class TileModel extends Backbone.Model
    constructor: (attributes, @collection) ->
        super attributes
        @set('displayName', attributes.type)
        @set('colour', null)
        @set('group', null)

    playerLanded: (game, player) ->

class OwnedTileModel extends TileModel
    constructor: (attributes, collection) ->
        @owner = null
        super attributes, collection
        @set('displayName', attributes.name or attributes.type)

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
        @attributes.price

    group: ->
        @collection.where {'type': 'company'}

    groupAllOwned: ->
        for i in @group
            if i.owner != @owner
                return false
        return true

    numberOfGroupOwned: ->
        c = 0
        for i in @group()
            if i.owner == @owner
                c++
        return c

class StreetTileModel extends OwnedTileModel
    constructor: (attributes, collection) ->
        @houses = 0
        super attributes, collection
        @set('colour', attributes.group)

    rentalAmount: (game) ->
        rent = @attributes.rents[@houses]
        if @houses == 0 and @groupAllOwned
            rent *= 2
        rent

    group: ->
        @collection.where {
            'type': 'street',
            'group': @attributes.group
        }

class RailwayTileModel extends OwnedTileModel
    rentalAmount: (game) ->
        rents = [0, 25, 50, 100, 200]
        rents[@numberOfGroupOwned()]

class UtilityTileModel extends OwnedTileModel
    rentalAmount: (game) ->
        multiplier = @groupAllOwned() ? 4 : 10
        multiplier * game.dice.total

class CardModel extends TileModel

class CommunityChestCardModel extends CardModel

class ChanceCardModel extends CardModel

class TaxTileModel extends TileModel
    constructor: (attributes, collection) ->
        super attributes, collection
        @set('displayName', attributes.name)

    playerLanded: (game, player) ->
        player.updateBalance(-@attributes.amount)

TileModel.innerTileClasses = {
    'street': StreetTileModel,
    'communityChest': CommunityChestCardModel,
    'chance': ChanceCardModel,
    'company': RailwayTileModel,
    'utility': UtilityTileModel,
    'tax': TaxTileModel,
}

return TileModel

`})`
