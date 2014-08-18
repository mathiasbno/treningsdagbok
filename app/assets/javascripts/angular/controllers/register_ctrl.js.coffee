angular.module("td")
  .controller "RegisterCtrl", ($scope, $state, $firebase, $rootScope, simpleLoginFactory, FIREBASE_URL) ->

    firebaseRef = new Firebase FIREBASE_URL

    $scope.registerUser = {
      email: '',
      password: ''
    }

    $scope.register = ->
      $scope.errors = []
      user = $scope.registerUser
      simpleLoginFactory.$createUser(user.email, user.password).then (user) ->

        firebaseRef.child('users').child(user.uid).set(user)

        $rootScope.currentUser = user
        $scope.registerUser = {
          email: '',
          password: ''
        }

        $state.go 'user_update'
      , (error) ->
        $scope.errors.push error
