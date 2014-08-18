angular.module("td")
  .controller "CalendarCtrl", ($rootScope, $scope, $filter, Restangular) ->
    $scope.today = new Date
    $scope.month_names = [ "Januar", "februar", "Mars", "April", "Mai", "Juni",
    "Juli", "August", "Spetember", "Oktober", "November", "Desember" ]
    $scope.day_names = [ "Søndag", "Mandag", "Tirsdag", "Onsdag", "Torsdag", "Fredag", "Lørdag" ]

    Date.prototype.getWeekNumber = ->
      onejan = new Date this.getFullYear(), 0, 1
      week_number = Math.ceil (((this - onejan) / 86400000) + onejan.getDay() + 1) / 7

      if week_number == 53
        return week_number = 1
      else
        return week_number

    $scope.daysInMonth = (month, year) ->
      return new Date(year, (month + 1), 0).getDate();

    $scope.getNextMonth = (date) ->
      $scope.current_month = $scope.getMonth(date)

    $scope.getPrevMonth = (date) ->
      $scope.current_month = $scope.getMonth(date)

    $scope.activeWeek = (date_input) ->
      date = new Date(date_input)

      $scope.current_week = $scope.getWeek(date)
      start_date = new Date(date)
      start_date = start_date.setDate(date.getDate() - (date.getDay() - 1))
      start_date = $filter('date')(start_date, 'yyyy-MM-dd')

      end_date = new Date(date)
      end_date = $filter('date')(end_date.setDate(end_date.getDate() + 5), 'yyyy-MM-dd')

      Restangular.all("active_range").getList({
        'user_id': $rootScope.current_user.id,
        datestart: start_date,
        dateend: end_date
      }).then (sessions) ->
        $scope.sessions = sessions

    $scope.getWeek = (date_input) ->
      date = new Date(date_input)

      first_day_in_week = date.getDate() - (date.getDay() - 1)
      first_day_copy = new Date(date)
      first_day = new Date(first_day_copy.setDate(first_day_in_week))

      first_day_in_next_week = date.getDate() - (date.getDay() + 8)
      start_of_next_week = new Date(first_day)
      start_of_next_week.setDate(start_of_next_week.getDate() + 7);

      loop_date = first_day

      $scope.week = 'week_number': (loop_date).getWeekNumber(), 'start_of_next_week': start_of_next_week, 'start_of_week': first_day, 'days': []
      i = 0

      while i < 7
        day = {
          'date': loop_date.getDate(),
          'month': loop_date.getMonth() + 1,
          'year': loop_date.getFullYear(),
          'full_date': $filter('date')(loop_date, 'yyyy-MM-dd'),
          'date_name': $scope.day_names[loop_date.getDay()]
        }

        $scope.week.days.push day
        loop_date.setDate(loop_date.getDate() + 1)
        i++

      return $scope.week

    $scope.getMonth = (date_input) ->
      date = new Date(date_input)

      month_number = date.getMonth()
      month_name = $scope.month_names[month_number]
      last_day = new Date(date.getFullYear(), month_number + 1, 0);
      first_day = new Date(date.getFullYear(), month_number, 1);
      days_in_month = $scope.daysInMonth(month_number, date.getFullYear())

      next_month = date
      prev_month = date
      next_month.setDate(1)
      prev_month.setDate(1)

      $scope.month = {
        'month_name': $scope.month_names[month_number],
        'month_number': month_number,
        'days_in_month': days_in_month,
        'next_month': new Date(next_month.setMonth(date.getMonth() + 1)),
        'prev_month': new Date(prev_month.setMonth(date.getMonth() - 2)),
        'weeks': []
      }

      loop_date = first_day

      while loop_date <= last_day
        week = $scope.getWeek(loop_date)
        $scope.month.weeks.push week
        loop_date = week.start_of_next_week

      return $scope.month

    $scope.getYears = (date_input) ->
      date = new Date(date_input)
      $scope.years = []
      i = 1

      while i <= 3
        $scope.months = []
        year = (date.getFullYear() - 2) + i
        a = 0

        while a <= 11
          first_in_month = new Date(year, a, 1);
          month = $scope.getMonth(first_in_month)
          $scope.months.push month
          a++

        $scope.year = {
          'year': year,
          'months': $scope.months
        }

        $scope.years.push $scope.year
        i++

      return $scope.years

    $scope.current_week = $scope.getWeek($scope.today)
    $scope.current_month = $scope.getMonth($scope.today)
    $scope.current_years = $scope.getYears($scope.today)
    $scope.activeWeek($scope.today)
