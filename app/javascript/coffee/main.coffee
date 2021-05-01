class Dummy
  constructor: (@text = "Hello world!") ->
  print: ->
    console.log @text
module.exports = Dummy