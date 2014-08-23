angular.module("td").factory 'sportFactory', ($q, $firebase, FIREBASE_URL) ->
    firebaseRef = new Firebase FIREBASE_URL + 'sports'
    sync = $firebase(firebaseRef)
    syncArray = $firebase(firebaseRef).$asArray()
    deferred = $q.defer()

    all: ->
      firebaseRef.once 'value', (snap) ->
        deferred.resolve snap.val()

      return deferred.promise

    post: (object) ->
      syncArray.$add(object).then (ref) ->
        deferred.resolve ref.name()
      , (error) ->
        deferred.resolve error

      return deferred.promise
