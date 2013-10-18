define

    # Page layout. Defines container for the boards
    layout:
        render:
            template:
                module: 'text!app/components/board/view/board.html'
            css:
                module: 'css!app/components/board/view/style.css'
        insert:
            at:
                $ref: 'dom.first!body'

    tilesCollection:
        create:
            module: 'app/components/board/collections/TilesCollection'
            args: module: 'text!json/tiles.json'

    boardViewModel:
        create:
            module: '/app/components/board/viewmodel/board'
        properties:
            tilesCollection: $ref: 'tilesCollection'

        init: 'init'

        knockout:
            bind: 'layout'



    # stateMachine:
    #     create:
    #         module: 'directory of the class'

    plugins: [
        # { module: 'wire/debug', trace: false }
        { module: 'wire/dom' }
        { module: 'wire/dom/render' }
        { module: 'wire/connect'}
        { module: '/app/wire/knockout'}
    ]
