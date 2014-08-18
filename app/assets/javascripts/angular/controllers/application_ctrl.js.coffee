angular.module("td")
  .controller "ApplicationCtrl", ($scope, $rootScope, simpleLoginFactory, FIREBASE_URL) ->

    $scope.logout = ->
      simpleLoginFactory.$logout()
      $rootScope.currentUser = undefined

    myRef = new Firebase(FIREBASE_URL);
    authClient = new FirebaseSimpleLogin myRef, (error, user) ->
      if (error)
        # an error occurred while attempting login
        console.log error
      else if (user)
        # user authenticated with Firebase
        $scope.currentUser = user
        console.log "User ID: " + user.uid + ", Provider: " + user.provider
      else
        # user is logged out
        console.log 'Not logged in'
