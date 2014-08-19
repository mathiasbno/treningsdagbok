angular.module("td")
  .controller "LoginCtrl", ($scope, $firebase, $rootScope, Restangular, simpleLoginFactory, FIREBASE_URL) ->

    usersRef = new Firebase FIREBASE_URL + '/users'

    $scope.loginUser = {
      email: '',
      password: ''
    }

    $scope.loginPassword = ->
      $scope.errors = []

      simpleLoginFactory.$login('password',
        email: $scope.loginUser.email,
        password: $scope.loginUser.password
      ).then (loginUser) ->
        $scope.loginUser = {
          email: '',
          password: ''
        }
      , (error) ->
        $scope.errors.push error

    $scope.loginFacebook = ->
      $scope.errors = []
      simpleLoginFactory.$login("facebook", {
        rememberMe: true,
        scope: 'email'
      }).then (user) ->

        usersRef.once 'value', (snapshot) ->
          unless snapshot.hasChild(user.uid)
            newUser = {
              uid: user.uid
              email: user.thirdPartyUserData.email
              first_name: user.thirdPartyUserData.first_name
              last_name: user.thirdPartyUserData.last_name
              full_name: user.thirdPartyUserData.name
              gender: user.thirdPartyUserData.gender
            }

            usersRef.child(user.uid).set newUser
