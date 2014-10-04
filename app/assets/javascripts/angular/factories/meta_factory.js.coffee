angular.module("td").factory 'metaFactory', ($rootScope, $firebase, helperFactory, FIREBASE_URL) ->
    $rootScope.$watch 'currentUser', ->
      unless $rootScope.currentUser == undefined
        firebaseMetasRef = new Firebase FIREBASE_URL + 'users/' + $rootScope.currentUser.$id + '/meta'
        meta = $firebase firebaseMetasRef

    factory = {}

    factory.create = (id) ->
      newMeta = [
        {name: 'Kommentar', type: 'text', static: true},
        {name: 'Tid', type: 'time', static: true}
      ]

      sessions.$set(id, newMeta).then (ref, error) ->
        return ref.name()

    factory.add = (id, metaObject) ->
      firebaseMetaObjectRef = new Firebase FIREBASE_URL + 'meta/' + id
      object = $firebase firebaseMetaObjectRef

      object.$push metaObject

    return factory
