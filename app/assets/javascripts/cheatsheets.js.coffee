class CheatsheetController extends Spine.Controller
    elements:
        ".group": "groups"
        ".keyboard": "keyboard"
        ".keyboard .key": "keys"

    events:
        "hover .shortcut": "on_active_shortcut"
        "hover .key": "on_active_key"

    constructor: ->
        super
        @key2shortcut = {}
        @key2keyboard = {}

        for k in @keys
            k = $(k)
            id = k.attr('id')
            continue unless id
            key = id.substr(2, 100)
            @key2keyboard[key] = k

        for g in @groups
            g = $(g)
            color = g.data('color')

            g.find('.name').css('background-color', color)

            for sc in g.find('.shortcut')
                sc = $(sc)
                key = sc.data('key')
                @key2shortcut[key] = sc
                @key2keyboard[key].css('background-color', color)


    on_active_shortcut: (e)=>
        sc = $(e.target)
        sc = sc.parents('.shortcut') unless sc.hasClass('shortcut')
        key = sc.data('key')
        @active_key(key)

    on_active_key: (e)=>
        k = $(e.target)
        key = k.attr('id').substring(2, 100)
        @active_key(key)

    active_key: (key)=>
        return unless @key2shortcut[key]
        @el.find('.key.on').removeClass('on')
        @el.find('.shortcut.on').removeClass('on')

        @key2shortcut[key].addClass('on')
        @key2keyboard[key].addClass('on')

window.init_cheatsheet = ->
    new CheatsheetController(el: ".cheatsheet")