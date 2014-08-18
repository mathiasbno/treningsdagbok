angular.module("td")
  .controller "NewUserCtrl", ($state, $rootScope, $scope, Restangular) ->
    $scope.user = {}

    $scope.newUser = ->
      Restangular.all('bruker').post($scope.user).then (user) ->
        if user.error
          $scope.error = user
        else
          console.log "Saved #{user.first_name}"
        # $rootScope.currentUser = user
