`define([
    'knockout',
    'backbone',
    'knockback',
],
function(ko, Backbone, kb, PlayerModel, DiceModel){`

class BoardViewModel extends kb.ViewModel


    currentPlayerI: 0
    currentPlayer: null
    players: [
        new PlayerModel({ name: "James" }),
        new PlayerModel({ name: "Christy" }),
        new PlayerModel({ name: "Guy" }),
        new PlayerModel({ name: "Luke" }),
    ]
    dice: new DiceModel()

    init: ->
        @tiles = kb.collectionObservable @tilesCollection
        window.board = @ # DEBUG
        @currentPlayer = @players[@currentPlayerI]
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

        if tile.playerLanded(player)
            player.set('position', pos)
        else
            # Game over??

        return tile

    checkWinState: ->

    gameComplete: ->


`})`