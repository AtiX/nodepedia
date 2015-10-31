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

  it 'should iterate over own properties', ->
    node = new TreeNode()

    node.setProperty 'a', 'b'
    node.setProperty 'c', 'd'

    aCalled = false
    cCalled = false

    node.forEachProperty (key, value) ->
      if key == 'a'
        aCalled = true
        expect(value).to.equal('b')
      else if key == 'c'
        cCalled = true
        expect(value).to.equal('d')
      else
        throw new Error("Unexpected key")

  it 'should flatten properties with the "childWins" strategy', ->
    parent = new TreeNode()
    child = parent.addNewChild()

    parent.setProperty 'p', 0
    parent.setProperty 'a', 1
    child.setProperty 'a', 2
    child.setProperty 'c', 3

    merged = child.flattenProperties 'childWins'

    expectedMerged = {
      p: 0
      a: 2
      c: 3
    }

    expect(merged).to.eql(expectedMerged)

  it 'should flatten properties with the "parentWins" strategy', ->
    parent = new TreeNode()
    child = parent.addNewChild()

    parent.setProperty 'p', 0
    parent.setProperty 'a', 1
    child.setProperty 'a', 2
    child.setProperty 'c', 3

    merged = child.flattenProperties 'parentWins'

    expectedMerged = {
      p: 0
      a: 1
      c: 3
    }

    expect(merged).to.eql(expectedMerged)
