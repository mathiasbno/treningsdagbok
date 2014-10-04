angular.module("td").factory 'sportFactory', ($firebase, helperFactory, FIREBASE_URL) ->
  firebaseRef = new Firebase FIREBASE_URL + 'sports'
  sports = $firebase(firebaseRef)

  factory = {}

  factory.all = ->
    all = sports.$asArray()
    all.$loaded().then ->
      return all

  factory.find = (id) ->
    list = sports.$asArray()
    item = list.$getRecord(id)

    return {'name': item.name}

  factory.create = (object) ->
    object.name = helperFactory.uppercaseFirstLetter object.name

    sports.$asArray().$add(object).then (ref, error) ->
      return ref.name()

  return factory
