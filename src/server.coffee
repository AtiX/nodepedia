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
  printIndentated indentation, "   |  dirName:  #{node.getProperty('dirName')}"
  printIndentated indentation, "   |  fullPath: #{node.getProperty('fullPath')}"
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
