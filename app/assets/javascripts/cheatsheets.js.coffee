class Group extends Spine.Model
    @configure 'Group', 'name', 'desc', 'color'

class Shortcut extends Spine.Model
    @configure 'Shortcut', 'key', 'desc'

class ShortcutController extends Spine.Controller
    elements:
        '.title': 'title'
        '.name': 'name'
        '.edit_key': 'edit_key'
        '.edit_desc': 'edit_desc'

    events:
        'dblclick': "enter_edit"
        "keypress .edit_key, .edit_desc": "check_edit_finished"
        "click .delete": "on_delete"
        "hover": "on_hover"

    constructor: ->
        super
        @item.bind "update", @render
        @item.bind "destroy", @release
        @item.bind "active", @active

    render: =>
        @replace(JST['app/views/shortcuts/show'] shortcut: @item)
        @

    active: =>
        @el.addClass('on')

    enter_edit: =>
        @el.addClass('editing')
        @edit_key.focus()

    leave_edit: =>
        @item.updateAttributes key: @edit_key.attr('value'), desc: @edit_desc.attr('value')
        @el.removeClass('editing')

    check_edit_finished: (e)=>
        return unless e.keyCode == 13
        @leave_edit()

    on_delete: =>
        @item.destroy()

    on_hover: =>
        Shortcut.trigger "active_key", @item.key

    release: =>
        @el.fadeOut(300, =>@el.remove())

class ShortcutsController extends Spine.Controller

    constructor: ->
        super
        Shortcut.bind "create", @add_one
        Shortcut.create key: 'a', desc: 'move left'

    on_add: =>
        shortcut = Shortcut.create key: "a", desc: "move left"

    add_one: (shortcut)=>
        view = new ShortcutController(item: shortcut, group: @group)
        el = view.render().el
        el.hide().fadeIn(300)
        @el.append(el)


class GroupController extends Spine.Controller
    elements:
        '.title': 'title'
        '.name': 'name'
        '.edit_name': 'edit_name'
        '.shortcuts': 'shortcuts'

    events:
        'dblclick .title': "enter_edit"
        "keypress .edit_name": "check_change_name_finished"
        "click .title .delete": "on_delete"
        "click .title .add": "on_add_shortcut"

    constructor: ->
        super
        @item.bind "update", @render
        @item.bind "destroy", @release

    render: =>
        @replace(JST['app/views/groups/show'] group: @item)
        @title.css('background-color', @item.color)
        @shortcuts_controller = new ShortcutsController(el: @shortcuts, group: @)
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

    on_add_shortcut: =>
        @shortcuts_controller.on_add()

    on_delete: =>
        @item.destroy()

    release: =>
        @el.fadeOut(300, =>@el.remove())

class GroupsController extends Spine.Controller
    events:
        'click > .ctl .add': "on_add"

    constructor: ->
        super
        Group.bind "create", @add_one
        Group.create name: 'movement', desc: '', color: "red"

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
        ".keyboard": "keyboard"

    events:
        "hover .key": "on_active_key"

    constructor: ->
        super
        @groups_controller = new GroupsController(el: @groups)
        Shortcut.bind "active_key", @on_active_shortcut

    on_active_key: (e)=>
        k = $(e.target)
        key = k.attr('id').substring(2, 100)
        @on_active_shortcut(key) if key

    on_active_shortcut: (key)=>
        @keyboard.find('.key.on').removeClass('on')
        @groups.find('.shortcut.on').removeClass('on')

        sc = Shortcut.findByAttribute('key', key)
        sc.trigger 'active' if sc

        k = @keyboard.find('#k_'+key)
        k.addClass('on') if k.length > 0

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