angular.module("td")
  .controller "CalendarCtrl", ($rootScope, $scope, sessionsFactory, calendarFactory) ->
    $scope.theMoment = moment()
    $scope.month_names = [ "Januar", "Februar", "Mars", "April", "Mai", "Juni",
    "Juli", "August", "Spetember", "Oktober", "November", "Desember" ]
    $scope.day_names = [ "Mandag", "Tirsdag", "Onsdag", "Torsdag", "Fredag", "Lørdag", "Søndag" ]

    $scope.getNextMonth = ->
      $scope.theMoment.add(1, 'month')
      $scope.current_month = calendarFactory.getMonth($scope.theMoment)

    $scope.getPrevMonth = ->
      $scope.theMoment.subtract(1, 'month')
      $scope.current_month = calendarFactory.getMonth($scope.theMoment)

    $scope.activeWeek = (weekNumber) ->
      $scope.theMoment = moment().week(weekNumber)

      unless $rootScope.currentUser == undefined
        sessionsFactory.currentWeek($scope.theMoment)

      $scope.current_week = calendarFactory.getWeek($scope.theMoment)

    $scope.currentMonth = ->
      $scope.current_month = calendarFactory.getMonth($scope.theMoment)

    $scope.current_month = calendarFactory.getMonth($scope.theMoment)
    # $scope.current_year = calendarFactory.getYear($scope.theMoment)
    $scope.activeWeek($scope.theMoment.get('week'))
