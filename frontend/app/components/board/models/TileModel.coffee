`define([
    'backbone',
    'knockout'
],
function(Backbone, ko){`

class TileModel extends Backbone.Model
    constructor: (attributes, @collection) ->
        super attributes
        @set('playersPresent', [])
        @set('displayName', attributes.type)
        @set('colour', null)
        @set('group', null)

    playerLanded: (game, player) ->
        true

class OwnedTileModel extends TileModel
    constructor: (attributes, collection) ->
        @owner = null
        super attributes, collection
        @set('displayName', attributes.name or attributes.type)

    playerLanded: (game, player) ->
        if not @owner
            if player.wantsToBuy(@)
                game.log('bought ' + @.get('displayName') + ' for £' + @purchase_price())
                player.updateBalance(-@purchase_price())
                @owner = player
            else
                # Do nothing
        else if @owner == player
            # Do nothing
        else
            rent = @rentalAmount(game)
            player.updateBalance(-rent)
            @owner.updateBalance(rent)

        true

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
    playerLanded: (game, player) ->
        randomIndex = Math.floor(Math.random() * @cards.length)
        card = @cards[randomIndex]
        card_type = card[0]

        if card_type == 'balance'
            default_msg = 'you ' + (card[1] < 0 ? 'have to pay' : 'receive') + ' £' + Math.abs(card[1])
            game.log(card[2] or default_msg)
            player.updateBalance(card[1])
        else
            game.log('Unknown card type: ' + card_type)

class CommunityChestCardModel extends CardModel
    constructor: (attributes, collection) ->
        @cards = [
            ['balance', 25, 'Receive for services £25'],
            ['advance', 'go:', 'Advance to Go'],
            ['balance', 100, 'You inherit £100']
            ['balance', -50, 'Pay your insurance premium £50']
            ['jail_free', null, null],
            ['balance', 100, 'Xmas fund matures collect £100']
            ['jail', null, null],
            ['balance', 10, 'You have won second prize in a beauty contest collect £10']
            ['balance', 200, 'Bank error in your favour collect £100']
            ['balance', -50, 'Doctors fee pay £50']
            ['balance', 50, 'From sale of stock you get £50']
            ['balance', -100, 'Pay hospital £100']
            ['balance', -150, 'Pay school fees of £150']
            ['balance', 20, 'Income tax refund £20']
        ]
        super attributes, collection
        @set('displayName', 'Community Chest')

class ChanceCardModel extends CardModel
    constructor: (attributes, collection) ->
        @cards = [
            ['advance', 'street:Pall Mall', null],
            ['advance', 'street:Mayfair', null],
            ['balance', 150, null],
            ['jail_free', null, null],
            ['advance', 'company:', null],
            ['balance', -15, 'Pay poor tax of £15'],
            ['advance', 'street:Trafalgar Square', null],
            ['jail', null, null],
            ['advance', 'pos:-3', 'Go back three spaces'],
            ['balance', 50, 'Bank pays you dividend of £50'],
            ['advance', 'go:', 'Advance to Go'],
            ['advance', 'company:Marylebone Station', null],
        ]
        super attributes, collection
        @set('displayName', 'Chance')

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
