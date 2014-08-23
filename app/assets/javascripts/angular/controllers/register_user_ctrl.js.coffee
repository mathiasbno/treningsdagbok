angular.module("td")
  .controller "RegisterUserCtrl", ($scope, $state, $firebase, $rootScope, simpleLoginFactory, FIREBASE_URL) ->

    usersRef = new Firebase FIREBASE_URL + '/users'
    sync = $firebase usersRef

    $scope.registerUser = {
      email: ''
      password: ''
      first_name: ''
      last_name: ''
    }

    $scope.register = ->
      $scope.errors = []
      $scope.user = $scope.registerUser
      simpleLoginFactory.$createUser($scope.user.email, $scope.user.password).then (user) ->

        newUser = {
          uid: user.uid
          email: user.email
          first_name: $scope.user.first_name
          last_name: $scope.user.last_name
          name: "#{$scope.user.first_name} #{$scope.user.last_name}"
        }

        sync.$set("#{user.uid}", newUser).then ->
          simpleLoginFactory.$login('password',
            email: $scope.user.email,
            password: $scope.user.password
          ).then (user) ->
            $scope.registerUser = {
              email: '',
              password: ''
            }

            $state.go 'user_update'

      , (error) ->
        stripedError = {
          code: error.code
          message: error.message
        }

        $scope.errors.push stripedError
