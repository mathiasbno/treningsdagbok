angular.module("td")
  .controller "RegisterUserCtrl", ($scope, $state, $firebase, $rootScope, simpleLoginFactory, FIREBASE_URL) ->

    firebaseRef = new Firebase FIREBASE_URL + 'users'

    $scope.registerUser = {
      email: '',
      password: ''
    }

    $scope.register = ->
      $scope.errors = []
      $scope.user = $scope.registerUser
      simpleLoginFactory.$createUser($scope.user.email, $scope.user.password).then (user) ->

        newUser = {
          uid: user.uid
          email: user.email
        }

        onComplete = (error) ->
          if !error
            simpleLoginFactory.$login('password',
              email: $scope.user.email,
              password: $scope.user.password
            ).then (user) ->
              $scope.registerUser = {
                email: '',
                password: ''
              }

              $state.go 'user_update'
          else
            console.log 'Synchronization failed'

        firebaseRef.child(user.uid).set(newUser, onComplete)

      , (error) ->
        $scope.errors.push error
