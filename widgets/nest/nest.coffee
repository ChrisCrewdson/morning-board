class Dashing.Nest extends Dashing.Widget

	onData: (data) ->
		@setBackgroundClassBy data.state						

	setBackgroundClassBy:(state) ->
		@removeBackgroundClass()
		$(@node).addClass "nest-state-#{state}"

	removeBackgroundClass: ->
		classNames = $(@node).attr("class").split " "		
		for className in classNames
			match = /nest-state-(.*)/.exec className
			$(@node).removeClass match[0] if match

			
