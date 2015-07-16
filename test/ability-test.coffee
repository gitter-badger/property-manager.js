chai            = require 'chai'
sinon           = require 'sinon'
sinonChai       = require 'sinon-chai'
should          = chai.should()
expect          = chai.expect
assert          = chai.assert
chai.use(sinonChai)

inherits        = require 'inherits-ex/lib/inherits'
extend          = require 'util-ex/lib/_extend'
defineProperty  = require 'util-ex/lib/defineProperty'
PropertyManager = require '../src/ability'
Simple          = require '../src/simple'
Normal          = require '../src/normal'
Advance         = require '../src/advance'
test            = require './property-manager'
setImmediate    = setImmediate || process.nextTick


describe 'PropertyManagerAbility', ->
  checkProperty = (aClass)->
    aClass.should.have.ownProperty 'defineProperties'
    checkBasicProperty(aClass)
    
  checkBasicProperty = (aClass)->
    aClass::should.have.ownProperty 'assign'
    aClass::should.have.ownProperty 'assignPropertyTo'
    aClass::should.have.ownProperty 'initialize'
    aClass::should.have.ownProperty 'getProperties'
    aClass::should.have.ownProperty 'defineProperties'
    aClass::should.have.ownProperty 'assign',

  checkIsSame = (aClass, aManager)->
    aClass.should.be.have.property 'defineProperties', aManager.defineProperties
    checkBasicIsSame aClass, aManager
  checkBasicIsSame = (aClass, aManager)->
    aClass::should.be.have.property 'getProperties', aManager::getProperties
    aClass::should.be.have.property 'assignPropertyTo', aManager::assignPropertyTo
    aClass::should.be.have.property 'defineProperties', aManager::defineProperties
    
  it 'should choose simple manager to a class', ->
    class A
      constructor: ->@initialize.apply @, arguments
      PropertyManager A, 'simple'
    checkBasicProperty A
    checkBasicIsSame A, Simple

  it 'should choose simple manager to a class with name option', ->
    class A
      constructor: ->@initialize.apply @, arguments
      PropertyManager A, name:'simple'
    checkBasicProperty A
    checkBasicIsSame A, Simple

  it 'should choose normal manager to a class', ->
    class A
      constructor: ->@initialize.apply @, arguments
      PropertyManager A, 'normal'
    checkProperty A
    checkIsSame A, Normal

  it 'should choose advance manager to a class', ->
    class A
      constructor: ->@initialize.apply @, arguments
      PropertyManager A, 'advance'
    checkProperty A
    checkIsSame A, Advance

  it 'should apply the ability to a class', ->
    class A
      constructor: ->@initialize.apply @, arguments
      PropertyManager A
    checkProperty A
    test('AbilityPropertyManagerA', A)


  it 'should apply the ability to a class with optionsPosition', ->
    class B
      constructor: ->@initialize.apply @, arguments
      initialize: (@my, @sec)->
      PropertyManager B, optionsPosition:2
    checkProperty B

    b = new B 'hi', 1222
    b.should.have.property 'my', 'hi'
    b.should.have.property 'sec', 1222

    test('AbilityPropertyManagerB', B, 2)