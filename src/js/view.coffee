_                   = require('lodash')
store               = require('./storage')

Draggabilly = require('draggabilly')

indexTemplate       = require('../templates/index.hbs')
lastSessionTemplate = require('../templates/last_session.hbs')
sessionsTemplate    = require('../templates/sessions.hbs')
saveSessionTemplate  = require('../templates/save_session.hbs')

class PeteshowView
  controller  : Peteshow.controller

  $peteshow    : '#peteshow'
  $tools       : '#peteshow-menu'
  $sessions    : '#peteshow-sessions'
  $lastSession : '#peteshow-last-session'
  $saveSession : '#peteshow-save-session'

  constructor: ->
    @_position = store.get('position') || {x:0, y:0}
    @_open     = store.get('open')
    @_events   =
      '#fill-out-forms'            : @controller.fillOutForms
      '#fill-out-forms-and-submit' : @controller.fillOutFormsAndSubmit
      '#peteshow-hide'             : @hide

  render: ->
    $('body').append(indexTemplate)

    @_positionWindow(store.get('position'))
    @_createEvents(@_events)

    @update()
    @open(@_open)

    @setSession('new')

  update: ->
    lastSession = @controller.lastSession
    sessions    = @controller.sessions

    $(@$lastSession).html(
      lastSessionTemplate
        lastSession     : lastSession
        lastSessionName : @_sessionName(lastSession)
    )

    $(@$sessions).html(sessionsTemplate(sessions: sessions))
    $(@$saveSession).html(saveSessionTemplate())

  _createEvents: (events) ->
    for key, value of events
      $(key).on 'click', (e) =>
        e.preventDefault()
        e.stopPropagation()
        events["##{e.target.id}"]()

    $(document).keydown @_handleKeydown

    @$drag = new Draggabilly(
      @$peteshow,
      handle      : '#peteshow-toggle',
      containment : 'html'
    )

    @$drag
      .on 'dragEnd', @_handleDragEnd
      .on 'staticClick', @open

    $('#peteshow-menu input:radio').on 'change', (e) =>
      id = $(e.currentTarget).data('session')
      @controller.setSession(id)
      return

  _handleKeydown: (e) =>
    code = String.fromCharCode(e.keyCode)

    @open() if (e.keyCode == 192)

    action  = $("[data-command='#{code}']")
    visible = $(@$peteshow).is('.open')

    action.click() if (action.length > 0 and visible)

  _handleDragEnd: ->
    @_position = this.position
    store.set('position', @_position)

  _positionWindow: (position) ->
    if position == undefined
      position = @_position

    @_position = position
    $(@$peteshow).css(left: position.x, top: position.y)

  open: (open) =>
    if open == undefined || typeof open != 'boolean'
      open = !@_open

    $(@$tools).toggle(open)
    $(@$peteshow).toggleClass('open', open)

    @_open = open
    store.set('open', @_open)

    return

  reset: (position) ->
    if position == undefined
      position = {x:0, y:0}

    @_positionWindow(position)
    @_position = position

    store.set('position', @_position)

    return position

  setSession: (id) ->
    $(@$tools).find("[data-session=#{id}]").prop('checked', true).change()

  _sessionName: (session) ->
    return "#{session.first_name} #{session.last_name}" if session.first_name and session.last_name
    return session.first_name if session.first_name
    return session.email if session.email
    return session.id

  show: =>
    $(@$peteshow).show()

  hide: =>
    $(@$peteshow).hide()

  destroy: ->
    $(@$peteshow).remove()

module.exports = new PeteshowView()
