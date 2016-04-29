{Layer} = require "./Layer"
{Events} = require "./Events"

Events.EnterKey  = "EnterKey"
Events.BackSpaceKey  = "BackSpaceKey"

class exports.InputLayer extends Layer
	constructor: (options={}) ->

		options.backgroundColor ?= "#fff"
		options.width ?= 480
		options.height ?= 100

		super options

		@input = document.createElement("input")
		@_element.appendChild(@input)

		@input.style.font = "400 40px/1.25 -apple-system, SF UI Text, Helvetica Neue"
		@input.style.outline = "none"
		@input.style.backgroundColor = "transparent"
		@input.style.width = "#{@width}px"
		@input.style.height = "#{@height}px"
		@input.style.paddingLeft = "32px"
		@input.style.color = "#aaa"
		@input.style.cursor = "auto"
		@input.value = "Placeholder"

		@input.onfocus = ->
			@style.color = "#000"
			@value = ""

		alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@{}#$%^&*()_+1234567890".split("")

		isInArray = (value, array) ->
			return array.indexOf(value) > -1

		@input.onkeyup = (e) =>

			# Check last character
			lastCharacter = @input.value.substr(@input.value.length - 1)

			# Exclude enter, space and caps lock
			if isInArray(lastCharacter, alphabet) and e.which isnt 20
				@emit("change:value", @input.value)

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
