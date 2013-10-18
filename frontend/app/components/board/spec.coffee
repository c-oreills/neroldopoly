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
    viewModel:
        create:
            module: '/app/components/board/viewmodel/board'



    plugins: [
        # { module: 'wire/debug', trace: false }
        { module: 'wire/dom' }
        { module: 'wire/dom/render' }
        { module: 'wire/connect'}
        { module: 'js/components/knockout/knockout'}
    ]
