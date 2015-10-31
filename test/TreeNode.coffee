chai = require 'chai'
expect = chai.expect

TreeNode = require '../src/node-graph/TreeNode.coffee'

describe 'TreeNode', ->
  it 'should add a new child and link parent and child', ->
    parent = new TreeNode()
    child = parent.addNewChild()

    expect(child.parent).to.equal(parent)
    expect(parent.children.length).to.equal(1)
    expect(parent.children[0]).to.equal(child)

  it 'should set a property and report hasProperty correctly', ->
    node = new TreeNode()

    expect(node.hasProperty('testkey')).to.be.false
    node.setProperty 'testkey', 'testvalue'
    expect(node.hasProperty('testkey')).to.be.true

  it 'should set a property and retrieve it', ->
    node = new TreeNode()

    expect(node.getProperty('testkey')).to.equal.null
    node.setProperty 'testkey', 'testvalue'
    expect(node.getProperty('testkey')).to.equal('testvalue')

  it 'should report hasProperty for lookInParents = true correctly', ->
    parent = new TreeNode()
    child = parent.addNewChild()

    expect(child.hasProperty('parentkey', true)).to.be.false
    parent.setProperty 'parentkey', 'parentvalue'
    expect(child.hasProperty('parentkey', true)).to.be.true

  it 'should get a parent property when using lookInParents = true', ->
    parent = new TreeNode()
    child = parent.addNewChild()

    expect(child.getProperty('parentkey', true)).to.be.null
    parent.setProperty 'parentkey', 'parentvalue'
    expect(child.getProperty('parentkey', true)).to.equals('parentvalue')
