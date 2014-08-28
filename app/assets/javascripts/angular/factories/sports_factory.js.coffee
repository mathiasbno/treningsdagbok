angular.module("td").factory 'sportFactory', ($q, $firebase, FIREBASE_URL) ->
    firebaseRef = new Firebase FIREBASE_URL + 'sports'
    sports = $firebase(firebaseRef)

    factory = {}

    factory.all = ->
      all = sports.$asArray()
      all.$loaded().then ->
        return all

    factory.find = (id) ->
      sportRef = new Firebase firebaseRef + '/' + id
      sport = $firebase(sportRef)

      one = sport.$asObject()
      one.$loaded().then ->
        return {'name': one.name}

    factory.post = (object) ->
      object.name = object.name.charAt(0).toUpperCase() + object.name.substring(1)

      sports.$asArray().$add(object).then (ref, error) ->
        console.log ref.name()
        return ref.name()

    return factory
