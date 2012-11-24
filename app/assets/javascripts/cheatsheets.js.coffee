class Group extends Spine.Model
    @configure 'Group', 'name', 'desc', 'color'

class Shortcut extends Spine.Model
    @configure 'Shortcut', 'key', 'desc'

class GroupController extends Spine.Controller
    elements:
        '.title': 'title'
        '.name': 'name'
        '.edit_name': 'edit_name'

    events:
        'dblclick .title': "enter_edit"
        "keypress .edit_name": "check_change_name_finished"
        "click .delete": "on_delete"

    constructor: ->
        super
        @item.bind "update", @render
        @item.bind "destroy", @release

    render: =>
        @replace(JST['app/views/groups/show'] group: @item)
        @title.css('background-color', @item.color)
        @

    enter_edit: =>
        @el.addClass('editing')
        @edit_name.focus()

    leave_edit: =>
        @item.updateAttribute "name", @edit_name.attr('value')
        @el.removeClass('editing')

    check_change_name_finished: (e)=>
        return unless e.keyCode == 13
        @leave_edit()

    on_delete: =>
        @item.destroy()

    release: =>
        @el.fadeOut(300, =>@el.remove())

class GroupsController extends Spine.Controller
    events:
        'click .add': "on_add"

    constructor: ->
        super
        Group.bind "create", @add_one
        Group.create name: 'movement', desc: 'for move', color: "red"

    on_add: =>
        group = Group.create name: "default", color: "green"

    add_one: (group)=>
        view = new GroupController(item: group)
        el = view.render().el
        el.hide().fadeIn(300)
        @el.append(el)

class CheatsheetController extends Spine.Controller
    elements:
        ".groups": "groups"
    constructor: ->
        super
        @groups_controller = new GroupsController(el: @groups)

    # elements:
    #     ".group": "groups"
    #     ".keyboard": "keyboard"
    #     ".keyboard .key": "keys"

    # events:
    #     "hover .shortcut": "on_active_shortcut"
    #     "hover .key": "on_active_key"

    # constructor: ->
    #     super
    #     @key2shortcut = {}
    #     @key2keyboard = {}

    #     for k in @keys
    #         k = $(k)
    #         id = k.attr('id')
    #         continue unless id
    #         key = id.substr(2, 100)
    #         @key2keyboard[key] = k

    #     for g in @groups
    #         g = $(g)
    #         color = g.data('color')

    #         g.find('.name').css('background-color', color)

    #         for sc in g.find('.shortcut')
    #             sc = $(sc)
    #             key = sc.data('key')
    #             @key2shortcut[key] = sc
    #             @key2keyboard[key].css('background-color', color)


    # on_active_shortcut: (e)=>
    #     sc = $(e.target)
    #     sc = sc.parents('.shortcut') unless sc.hasClass('shortcut')
    #     key = sc.data('key')
    #     @active_key(key)

    # on_active_key: (e)=>
    #     k = $(e.target)
    #     key = k.attr('id').substring(2, 100)
    #     @active_key(key)

    # active_key: (key)=>
    #     return unless @key2shortcut[key]
    #     @el.find('.key.on').removeClass('on')
    #     @el.find('.shortcut.on').removeClass('on')

    #     @key2shortcut[key].addClass('on')
    #     @key2keyboard[key].addClass('on')

window.init_cheatsheet = ->
    new CheatsheetController(el: ".cheatsheet")