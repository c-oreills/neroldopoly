`define([
    'knockout',
    'backbone',
    'knockback',
<<<<<<< HEAD
=======
    '../models/PlayerModel',
    '../models/DiceModel'
>>>>>>> b9987ab4b967ba66c1e88939a77d1e3373c1a5bf
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
<<<<<<< HEAD
        @tiles = kb.collectionObservable(@tilesCollection)
=======
        @tiles = kb.collectionObservable @tilesCollection
        window.board = @ # DEBUG
        @doTurn()

    doTurn: ->
        numSpaces = @rollDice()
        tile = @movePlayerAhead(numSpaces)
        # result = tile.accept(@currentPlayer)

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


    movePlayerAhead: ->

    checkWinState: ->

    gameComplete: ->

>>>>>>> b9987ab4b967ba66c1e88939a77d1e3373c1a5bf

return BoardViewModel


`})`