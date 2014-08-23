angular.module("td")
  .controller "ApplicationCtrl", ($state, $scope, $rootScope, Restangular, simpleLoginFactory, FIREBASE_URL) ->

    $scope.logout = ->
      simpleLoginFactory.$logout()
      $rootScope.currentUser = undefined
      $state.go 'home'

    myRef = new Firebase(FIREBASE_URL);
    authClient = new FirebaseSimpleLogin myRef, (error, user) ->
      if (error)
        console.log error
      else if (user)
        Restangular.oneUrl('firebase', FIREBASE_URL + 'users/' + user.uid + '.json').get().then (fullUser) ->
          $rootScope.currentUser = fullUser
        console.log "User ID: " + user.uid + ", Provider: " + user.provider
      else
        console.log 'Not logged in'
