angular.module("td").factory 'userFactory', ($rootScope, $firebase, $firebaseSimpleLogin, helperFactory, FIREBASE_URL) ->
    firebaseUsersRef = new Firebase FIREBASE_URL + 'users'
    users = $firebase firebaseUsersRef

    factory = {}

    factory.find = (id) ->
      firebaseUserRef = new Firebase FIREBASE_URL + 'users/' + id
      user = $firebase firebaseUserRef
      user.$asObject()

      object = user.$asObject()
      return object.$loaded()

    factory.create = (newUser) ->
      key = helperFactory.escapeEmailAddress(newUser.email)

      users.$set(key, newUser).then (ref, error) ->
        return ref.name()

    factory.update = (id, object) ->
      users.$update(id, object)

    return factory
