angular.module("td").factory 'sessionsFactory', ($rootScope, $firebase, helperFactory, FIREBASE_URL) ->
  firebaseSessionsRef = ''
  sessions = ''

  $rootScope.$watch 'currentUser', ->
    unless $rootScope.currentUser == undefined
      factory.current_week_sessions(moment())

  factory = {}

  factory.current_week_sessions = (date_input) ->
    date = moment(date_input)

    sessions_date = {
      'week': date.get('week'),
      'year': date.get('year')
    }
    firebaseSessionsRef = new Firebase FIREBASE_URL+ "sessions/#{$rootScope.currentUser.$id}/#{sessions_date.year}-#{sessions_date.week}"
    sessions = $firebase(firebaseSessionsRef).$asArray()

    factory.currentWeek()

  factory.currentWeek = ->
    sessions.$loaded().then (list) ->
      $rootScope.active_sessions = list

  factory.create = (id, date) ->
    object = {'date': date.full_date}
    sessions.$add(object).then (ref, error) ->
      return ref.name()

  factory.update = (id, updatedSession) ->
    sessions.$update(id, updatedSession).then (ref, error) ->
      return ref.name()

  factory.destroy = (id) ->
    sessions.$remove(id).then (ref, error) ->
      return ref.name

  return factory
