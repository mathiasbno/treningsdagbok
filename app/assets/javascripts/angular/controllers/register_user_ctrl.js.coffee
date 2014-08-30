angular.module("td")
  .controller "RegisterUserCtrl", ($scope, $state, $rootScope, userFactory, authFactory, helperFactory) ->

    $scope.registerUser = {
      email: ''
      password: ''
      first_name: ''
      last_name: ''
    }

    $scope.register = ->
      $scope.errors = []
      $scope.user = $scope.registerUser

      $scope.user.first_name = helperFactory.uppercaseFirstLetter $scope.user.first_name
      $scope.user.last_name = helperFactory.uppercaseFirstLetter $scope.user.last_name

      authFactory.create($scope.user.email, $scope.user.password).then (user) ->

        loginUser = {
          email: user.email,
          password: $scope.user.password
        }

        authFactory.login(user.provider, loginUser).then (loggedInUser) ->

          newUser = {
            uid: loggedInUser.provider
            email: loggedInUser.email
            first_name: $scope.user.first_name
            last_name: $scope.user.last_name
            name: "#{$scope.user.first_name} #{$scope.user.last_name}"
          }

          userFactory.create(newUser).then (id) ->
            userFactory.find(id).then (user) ->
              $rootScope.currentUser = user

              $scope.registerUser = {
                email: '',
                password: ''
              }

              $state.go 'user_update'
