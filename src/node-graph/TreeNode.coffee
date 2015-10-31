##
# A node in the tree datastructure.
# mainly consists out of helper functions
# @class TreeNode
module.exports = class TreeNode

  constructor: (@parent = null) ->
    @children = []
    @properties = []

  ##
  # Creates a new TreeNode and adds it as a child
  # @returns {TreeNode} the created child node
  addNewChild: =>
    child = new TreeNode(@)
    @children.push child
    return child

  ##
  # Adds a property to this node. If the key already exists,
  # the value will be overwritten
  # @param {String} key the name of the property
  # @param {Object} value arbitrary object representing the value
  setProperty: (key, value) =>
    @properties[key] = value

  ##
  # Query if the node has a given property
  # @param {String} key the name of the property
  # @param {Boolean} lookInParents if true, the property will be searched in parents if it does not exist
  # @returns a boolean value indicating whether the property exists
  hasProperty: (key, lookInParents = false) =>
    if @properties[key]?
      return true
    if lookInParents and @parent?
      return @parent.hasProperty key, true
    return false

  ##
  # Returns the value for a given key.
  # @param {String} key the name of the property
  # @param {Boolean} lookInParents if true, the property will be searched in parents if it does not exist
  # @returns the property or null, if it does not exist
  getProperty: (key, lookInParents = false) =>
    if @hasProperty key
      return @properties[key]
    if lookInParents and @parent?
      return @parent.getProperty key, true
    return null


