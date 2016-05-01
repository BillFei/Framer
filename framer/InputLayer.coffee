{Layer} = require "./Layer"
{TextLayer} = require "./TextLayer"
{Events} = require "./Events"

Events.EnterKey  = "EnterKey"
Events.BackSpaceKey  = "BackSpaceKey"
Events.InputValueChange = "InputValueChange"

class exports.InputLayer extends TextLayer
	constructor: (options={}) ->

		options.backgroundColor ?= "#fff"
		options.width ?= 480
		options.height ?= 100

		super options

		@input = document.createElement("input")
		@_element.appendChild(@input)


		# Match TextLayer defaults and type properties
		@input.style.fontFamily = @fontFamily
		@input.style.fontSize = @fontSize
		@input.style.lineHeight = @lineHeight
		@input.style.fontWeight = @fontWeight
		@input.style.outline = "none"
		@input.style.backgroundColor = "transparent"
		@input.style.width = "#{@width}px"
		@input.style.height = "#{@height}px"
		@input.style.color = "#aaa"
		@input.style.cursor = "auto"

		# If text has been defined, use that, otherwise default to placeholder
		@input.value = if @text isnt "Type Something" then @text else "Placeholder"

		# Override text property setting the html
		@html = ""

		# Default focus interaction
		@input.onfocus = ->
			@style.color = "#000"
			@value = ""

		isInArray = (value, array) ->
			return array.indexOf(value) > -1

		@input.onkeyup = (e) =>

			# Check last character
			lastCharacter = @input.value.substr(@input.value.length - 1)

			# Exclude enter, space and caps lock
			unless e.which is 20 or e.which is 13 or @value is ""
				@emit("change:value", @value)
				@emit(Events.InputValueChange, @value)

			# If enter key is pressed
			if e.which is 13
				@emit(Events.EnterKey, event)

			# If backspace key
			if e.which is 8
				@emit(Events.BackSpaceKey, event)

	@define "value",
		get: -> @input.value

	@isInArray: (value, array) ->
		return array.indexOf(value) > -1

	onEnterKey: (cb) -> @on(Events.EnterKey, cb)
	onBackSpaceKey: (cb) -> @on(Events.BackSpaceKey, cb)
	onInputChange: (cb) -> @on(Events.InputValueChange, cb)
