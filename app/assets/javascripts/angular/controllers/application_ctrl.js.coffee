angular.module("td")
  .controller "ApplicationCtrl", ($state, $rootScope, $scope, authFactory, userFactory, metaFactory, helperFactory) ->

    authFactory.auth().then (user) ->
      unless user == undefined
        if user.provider == 'facebook'
          id = helperFactory.escapeEmailAddress user.thirdPartyUserData.email
        else if user.provider == 'password'
          id = helperFactory.escapeEmailAddress user.email

        userFactory.find(id).then (user) ->
          $rootScope.currentUser = user

    $scope.logout = ->
      authFactory.logOut()
