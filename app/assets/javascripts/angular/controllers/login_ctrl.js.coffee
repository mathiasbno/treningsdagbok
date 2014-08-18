angular.module("td")
  .controller "LoginCtrl", ($scope, $firebase, $rootScope, simpleLoginFactory, FIREBASE_URL) ->

    firebaseRef = new Firebase FIREBASE_URL

    $scope.user = {
      email: '',
      password: ''
    }

    $scope.loginPassword = ->
      $scope.errors = []

      promis = simpleLoginFactory.$login('password',
        email: $scope.user.email,
        password: $scope.user.password
      ).then (user) ->
        $rootScope.currentUser = user
        $scope.user = {
          email: '',
          password: ''
        }
      , (error) ->
        $scope.errors.push error

    $scope.loginFacebook = ->
      $scope.errors = []
      simpleLoginFactory.$login("facebook").then (user) ->
        debugger
        firebaseRef.child('users').child(user.uid).set(user)
