angular.module("td")
  .controller "SessionsCtrl", ($rootScope, $scope, sessionsFactory, metaFactory) ->

    $rootScope.$watch 'currentUser', ->
      unless $rootScope.currentUser == undefined
        sessionsFactory.currentWeek(moment()).then (sessions) ->
          $scope.current_week_sessions = sessions

    $scope.destroySession = (session) ->
      sessionsFactory.destroy(session.$id)

    $scope.updateSession = (session) ->
      sessionsFactory.update(session)

    $scope.addSession = (date) ->
      sessionsFactory.create(date)
