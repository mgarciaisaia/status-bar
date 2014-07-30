{View} = require 'atom'

module.exports =
class SelectionCountView extends View
  @content: ->
    @div class: "selection-count inline-block"

  initialize: (@statusBar) ->
    atom.workspaceView.eachEditorView (editor) =>
      @subscribe editor, "selection:changed", @updateCount
    @subscribe atom.workspaceView, "pane-container:active-pane-item-changed", @updateCount

  destroy: ->
    @remove()

  afterAttach: ->
    @updateCount()

  updateCount: =>
    return unless editor = atom.workspace.getActiveEditor()
    if editor.getSelection().isEmpty()
      @hide()
    else
      count = editor.getSelection().getText().length
      @text("(#{count})").show()
