angular.module("td").factory 'userFactory', ($q, $firebase, FIREBASE_URL) ->
    firebaseRef = new Firebase FIREBASE_URL + 'users'
    userSync = $firebase(firebaseRef)

    factory = {}

    factory.update = (id, object) ->
      debugger
      userSync.$update(id, object)


    return factory
