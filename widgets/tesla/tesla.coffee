class Dashing.Tesla extends Dashing.Widget

  onData: (data) ->
    @setBackgroundClassBy data.state

  setBackgroundClassBy:(state) ->
    @removeBackgroundClass()
    $(@node).addClass "tesla-state-#{state}"

  removeBackgroundClass: ->
    classNames = $(@node).attr("class").split " "
    for className in classNames
      match = /tesla-state-(.*)/.exec className
      $(@node).removeClass match[0] if match
