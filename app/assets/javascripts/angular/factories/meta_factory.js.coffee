angular.module("td").factory 'metaFactory', ($rootScope, $firebase, helperFactory, FIREBASE_URL) ->
    meta = ''

    $rootScope.$watch 'currentUser', ->
      unless $rootScope.currentUser == undefined
        firebaseMetasRef = new Firebase FIREBASE_URL + "users/#{$rootScope.currentUser.$id}/meta"
        meta = $firebase firebaseMetasRef

    factory = {}

    factory.baseAll = ->
      firebaseMetasRef = new Firebase FIREBASE_URL + "meta"
      metaBase = $firebase firebaseMetasRef

      metaBase.$asArray().$loaded().then (list) ->
        return list

    factory.all = ->
      meta.$asArray().$loaded().then (list) ->
        return list

    factory.create = (id) ->
      firebaseMetasRef = new Firebase FIREBASE_URL + "users/#{id}/meta"
      meta = $firebase firebaseMetasRef

      newMeta = [
        {name: 'Tid', type: 'time'}
        {name: 'Kommentar', type: 'text'},
      ]

      meta.$set(newMeta).then (ref, error) ->
        return ref.name()

    factory.add = (metaObject) ->
      meta.$asArray().$add(metaObject).then (ref, error) ->
        return ref.name()

    return factory
