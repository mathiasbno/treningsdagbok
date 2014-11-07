angular.module("td")
  .controller "CalendarCtrl", ($rootScope, $scope, sessionsFactory, calendarFactory) ->
    $scope.theMoment = moment()
    $scope.today = moment().format('YYYY-MM-DD')

    $scope.getNextMonth = ->
      $scope.theMoment.add(1, 'month')
      $scope.current_month = calendarFactory.getMonth($scope.theMoment)

    $scope.getPrevMonth = ->
      $scope.theMoment.subtract(1, 'month')
      $scope.current_month = calendarFactory.getMonth($scope.theMoment)

    $scope.activeWeek = (weekNumber) ->
      $scope.theMoment = moment().week(weekNumber)

      unless $rootScope.currentUser == undefined
        sessionsFactory.currentWeek($scope.theMoment).then (sessions) ->
          $scope.current_week_sessions = sessions

      $scope.current_week = calendarFactory.getWeek($scope.theMoment)

    $scope.currentMonth = (montNumber) ->
      if montNumber
        date = moment().month(montNumber)
        $scope.current_month = calendarFactory.getMonth(date)
      else
        $scope.current_month = calendarFactory.getMonth($scope.theMoment)

      $scope.$broadcast 'openMonth', event.currentTarget

    $scope.current_month = calendarFactory.getMonth($scope.theMoment)
    $scope.current_year = calendarFactory.getYear($scope.theMoment)
    $scope.activeWeek($scope.theMoment.get('week'))
