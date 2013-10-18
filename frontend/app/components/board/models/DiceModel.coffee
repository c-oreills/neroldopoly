`define([
    'backbone'
],
function(Backbone){`

class DiceModel extends Backbone.Model

    defaults:
        value1: null
        value2: null
        total: null
        isDouble: false
        doublesCount: 0

    initialize: ->

    roll: ->
        @value1 = Math.floor(Math.random() * 6 + 1)
        @value2 = Math.floor(Math.random() * 6 + 1)

        @checkIsDouble()

        return @total = @value1 + @value2

    checkIsDouble: ->
        if @value1 == @value2
            @doublesCount++
            @isDouble = true
        else
            @doublesCount = 0
            @isDouble = false

return DiceModel

`})`
