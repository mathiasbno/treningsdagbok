angular.module("td")
  .controller "LoginCtrl", ($scope, $rootScope, authFactory, userFactory, helperFactory) ->

    $scope.loginUser = {
      email: '',
      password: ''
    }

    $scope.login = (provider) ->
      if provider == 'password'
        authFactory.login(provider, $scope.loginUser).then (user) ->
          id = helperFactory.escapeEmailAddress user.email
          userFactory.find(id).then (user) ->
            $rootScope.currentUser = user

      else if provider == 'facebook'
        authFactory.login(provider).then (user) ->
          newUser = {
            provider: 'facebook'
            email: user.thirdPartyUserData.email
            first_name: user.thirdPartyUserData.first_name
            last_name: user.thirdPartyUserData.last_name
            full_name: user.thirdPartyUserData.name
            gender: user.thirdPartyUserData.gender
          }

          userFactory.create(newUser).then (id) ->
            userFactory.find(id).then (user) ->
              $rootScope.currentUser = user
