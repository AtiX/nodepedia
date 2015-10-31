# For now, only a test script that logs the created graph to the console

NodeGraph = require './node-graph/NodeGraph'

graph = new NodeGraph({ path: './sampleGraphData'})
graph.registerParser('MarkdownParser')
graph.load()
.then (rootNode) ->
  console.log 'Tree view:'
  console.log ''
  printTree 0, rootNode

# Print the created tree somehow nicely
printTree = (indentation, node) ->
  printIndentated indentation, '--( ) Node:'

  node.forEachProperty (key, value) ->
    if 'object' != typeof value
      valueStr = value.toString()
    else
      valueStr = JSON.stringify(value)

    if valueStr.length > 50
      valueStr = valueStr.substring(0,50)
      valueStr += '...'

    printIndentated indentation, "   |  #{key}: #{valueStr}"

  printIndentated indentation, '   |'

  indentation++
  for child in node.children
    printTree indentation, child

printIndentated = (num, string) ->
  str = getSpaces(num)
  str += string
  console.log str

getSpaces = (num) ->
  str = ''
  for i in [0..num]
    str += '   |'
  return str
