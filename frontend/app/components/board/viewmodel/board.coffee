`define([
    'knockout',
    'backbone',
    'knockback',
    '../models/PlayerModel',
    '../models/DiceModel'
],
function(ko, Backbone, kb, PlayerModel, DiceModel){`

class BoardViewModel extends kb.ViewModel


    init: ->
        @currentPlayerI = 0
        @players = [
            new PlayerModel({ name: "James" }),
            new PlayerModel({ name: "Christy" }),
            new PlayerModel({ name: "Guy" }),
            new PlayerModel({ name: "Luke" }),
        ]
        @currentPlayer = @players[@currentPlayerI]
        @dice = new DiceModel()

        @tiles = kb.collectionObservable @tilesCollection

        window.board = @ # DEBUG

        @doTurn()

    doTurn: ->
        numSpaces = @rollDice()
        result = @movePlayerAhead(@currentPlayer, numSpaces)

        # if not result
        #     if @checkWinState()
        #         return @gameComplete()

        @advancePlayerTurn()
        # @doTurn()

    advancePlayerTurn: ->
        @currentPlayerI = (@currentPlayerI + 1) % @players.length
        @currentPlayer = @players[@currentPlayerI]

    rollDice: ->
        return @dice.roll()


    movePlayerAhead: (player, spaces) ->
        pos = (player.get('position') + spaces) % @tilesCollection.length

        # if player.position > pos
        #     # TODO: Passed GO.

        tile = @tilesCollection.models[pos]

        if tile.playerLanded(game, player)
            player.set('position', pos)
        else
            # Game over??

        return tile

    checkWinState: ->

    gameComplete: ->


return BoardViewModel


`})`