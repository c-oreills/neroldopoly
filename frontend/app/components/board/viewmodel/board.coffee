`define([
    'jquery',
    'knockout',
    'backbone',
    'knockback',
    '../models/PlayerModel',
    '../models/DiceModel'
],
function(jQuery, ko, Backbone, kb, PlayerModel, DiceModel){`

class BoardViewModel extends kb.ViewModel


    init: ->
        @currentPlayerI = 0
        @players = [
            new PlayerModel({ name: "James" }),
            new PlayerModel({ name: "Christy" }),
            new PlayerModel({ name: "Guy" }),
            new PlayerModel({ name: "Luke" })
        ]
        @currentPlayer = @players[@currentPlayerI]
        @dice = new DiceModel()

        @tiles = kb.collectionObservable @tilesCollection

        @gameLog = ko.observable('Game log\n========\n\n')
        @gameInfo = ko.observable()
        @gameOver = ko.observable(false)
        window.board = @ # DEBUG

        @log('Starting!', true)

        @doTurn()

    log: (msg, noPlayer) ->
        prefix = ''

        if not noPlayer
            prefix = @currentPlayer.get('name') + ', '

         @gameLog(@gameLog() + ' * ' + prefix + msg + '\n')
         # TODO: Broken :-(
         jQuery('#game-log').css('scrollTop', jQuery('#game-log').height())

    updateInfo: ->
        @gameInfo([
            'Game info',
            '========',
            '',
            'Players:',
            ' * ' + @players[0].get('name') + ' (£' + @players[0].get('balance') + ')',
            ' * ' + @players[1].get('name') + ' (£' + @players[1].get('balance') + ')',
            ' * ' + @players[2].get('name') + ' (£' + @players[2].get('balance') + ')',
            ' * ' + @players[3].get('name') + ' (£' + @players[3].get('balance') + ')',
        ].join('\n'))

    doTurn: ->
        @updateInfo()
        @log("It's now " + @currentPlayer.get('name') + "'s turn", true)

        numSpaces = @rollDice()
        result = @movePlayerAhead(@currentPlayer, numSpaces)

        @advancePlayerTurn()

        @doTurn() if not @gameOver()

    advancePlayerTurn: ->
        @currentPlayerI = (@currentPlayerI + 1) % @players.length
        @currentPlayer = @players[@currentPlayerI]

    rollDice: ->
        @log('rolls the dice')
        return @dice.roll()

    movePlayerAhead: (player, spaces) ->
        pos = (player.get('position') + spaces) % @tilesCollection.length

        @log('moves ahead ' + pos + ' spaces')

        # Pass GO, collect £200
        if player.position > pos
            @log('has passed GO and collects £200!')
            player.updateBalance(200)

        tile = @tilesCollection.models[pos]

        @log('has landed on ' + tile.get('displayName'))
        tile.playerLanded(@, player)

        player.set('position', pos)

        if @checkWinState()
            @doGameOver()

    checkWinState: ->
        numInTheGame = 0

        for player in @players
            numInTheGame++ if player.get('balance') > 0

        return numInTheGame <= 1

    doGameOver: ->
        # TODO: This is probably wrong
        @gameOver(@currentPlayer.get('name'))


return BoardViewModel


`})`
