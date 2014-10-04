angular.module("td").factory 'calendarFactory', () ->

  month_names = [ "Januar", "Februar", "Mars", "April", "Mai", "Juni",
  "Juli", "August", "Spetember", "Oktober", "November", "Desember" ]
  day_names = [ "Mandag", "Tirsdag", "Onsdag", "Torsdag", "Fredag", "Lørdag", "Søndag" ]

  factory = {}

  factory.getWeek = (date_input) ->
    date = moment(date_input)

    console.log date.get('week')

    week = 'week_number': date.get('week'), 'days': []

    i = 1
    day = date.weekday(1)

    while i < 8
      dayObj = {
        'date': day.get('date'),
        'month': day.get('month'),
        'year': day.get('year'),
        'full_date': new Date(day),
        'date_name': day_names[day.isoWeekday() - 1],
        'week': day.week()
      }

      week.days.push dayObj

      i++
      day.day(i)

    return week

  factory.getMonth = (date_input) ->
    date = moment(date_input)

    month = {
      'month_name': month_names[date.get('month')],
      'month_number': date.get('month'),
      'days_in_month': date.daysInMonth()
      'weeks': []
    }

    loop_date = date.clone().startOf('month')

    while loop_date.diff(date.clone().endOf('month'), 'days') < 0
      week = factory.getWeek(loop_date)
      month.weeks.push week
      loop_date.add(1, 'week')

    return month

  factory.getYear = (date_input) ->
    date = moment(date_input)
    year = []

    months = []
    year = date.get('year')
    i = 0

    while i <= 11
      month = factory.getMonth(date.clone().startOf('year'))
      months.push month
      i++

    year = {
      'year': year,
      'months': months
    }

    return year

  return factory
