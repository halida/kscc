class CheatsheetController extends Spine.Controller
    elements:
        ".group": "groups"
        ".keyboard": "keyboard"

    events:
        "hover .shortcut": "on_active_shortcut"

    constructor: ->
        super

        for g in @groups
            g = $(g)
            color = g.data('color')
            console.log color

            g.find('.name').css('background-color', color)

            for key in g.find('.shortcut .key')
                key = $(key).text()
                @keyboard.find("#k_"+key).css('background-color', color)


    on_active_shortcut: (e)=>
        target = e.target
        console.log target

window.init_cheatsheet = ->
    new CheatsheetController(el: ".cheatsheet")