angular.module("td")
  .controller "SessionsCtrl", ($state, $rootScope, $scope, $filter, Restangular) ->
    # Restangular.all('trening').getList({'user_id': $rootScope.current_user.id}).then (sessions) ->
    #   $scope.sessions = sessions

    $scope.newSession = (session, date) ->
      session_params = {
        user_id: $rootScope.current_user.id,
        comment: session.comment,
        date: $filter('date')(date, 'yyyy-MM-dd')
      }
      Restangular.all('trening').post(session_params).then (session) ->
        $scope.sessions.push session

    $scope.destroySession = (session) ->
      Restangular.one('trening', session.id).remove()

      index = $scope.sessions.indexOf(session)
      $scope.sessions.splice(index, session.id)