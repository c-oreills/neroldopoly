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
            new PlayerModel({ name: "James", playerId: 'player1' }),
            new PlayerModel({ name: "Christy", playerId: 'player2' }),
            new PlayerModel({ name: "Guy", playerId: 'player3' }),
            new PlayerModel({ name: "Luke", playerId: 'player4' }),
        ]
        @currentPlayer = @players[@currentPlayerI]
        @dice = new DiceModel()

        @tiles = kb.collectionObservable @tilesCollection
        @tiles()[0].playersPresent(@players)
        @gameLog = ko.observable('Game log\n========\n\n')
        @gameInfo = ko.observable()
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

        # if not result
        #     if @checkWinState()
        #         return @gameComplete()

        @advancePlayerTurn()
        # @doTurn()

    advancePlayerTurn: ->
        @currentPlayerI = (@currentPlayerI + 1) % @players.length
        @currentPlayer = @players[@currentPlayerI]

    rollDice: ->
        @log('rolls the dice')
        return @dice.roll()

    movePlayerAhead: (player, spaces) ->
        console.log player.get('position')
        oldTile = @tiles()[player.get('position')]
        pos = (player.get('position') + spaces) % @tilesCollection.length

        @log('moves ahead ' + pos + ' spaces')

        # Pass GO, collect £200
        if player.position > pos
            @log('has passed GO and collects £200!')
            player.updateBalance(200)

        tile = @tilesCollection.models[pos]

        if tile.playerLanded(@, player)
            @log('has landed on ' + tile.get('name'))
            player.set('position', pos)
            # console.log oldTile.playersPresent.remove()
            newArray = []
            _.each oldTile.playersPresent(), (tempplayer) =>
                if tempplayer != player
                    newArray.push(tempplayer)
            oldTile.playersPresent(newArray)
            tileVM = @tiles()[pos]
            tileVM.playersPresent(tileVM.playersPresent().concat([player]))
        else
            @log('Game over??', true)

        return tile

    checkWinState: ->

    gameComplete: ->


return BoardViewModel


`})`
