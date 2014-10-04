angular.module("td")
  .controller "SessionsCtrl", ($rootScope, $scope, sessionsFactory) ->

    $scope.destroySession = (id, date) ->
      sessionsFactory.destroy(id, date)

    $scope.addSession = (id, date) ->
      sessionsFactory.create(id, date)
