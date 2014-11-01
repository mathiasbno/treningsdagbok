angular.module("td").factory 'sessionsFactory', ($rootScope, $firebase, helperFactory, FIREBASE_URL) ->
  firebaseSessionsRef = ''
  sessions = ''
  sessions_list = ''

  $rootScope.$watch 'currentUser', ->
    unless $rootScope.currentUser == undefined
      firebaseSessionsRef = new Firebase FIREBASE_URL + "users/#{$rootScope.currentUser.$id}/sessions"
      sessions = $firebase(firebaseSessionsRef)

  sessionsDestination = (date_input) ->
    if date_input
      date = moment(date_input)
    else
      date = moment()

    sessions_date = {
      'week': date.get('week'),
      'year': date.get('year')
    }
    firebaseSessionsRef = new Firebase FIREBASE_URL + "users/#{$rootScope.currentUser.$id}/sessions/#{sessions_date.year}-#{sessions_date.week}"
    sessions = $firebase(firebaseSessionsRef)

  factory = {}

  stripsession = (session) ->

    delete session.$id
    delete session.$priority

    return session

  factory.currentWeek = (date) ->
    sessionsDestination(date)
    sessions.$asArray().$loaded().then (list) ->
      return list

  factory.create = (date) ->
    object = {'date': "#{date}"}
    sessionsDestination(date)
    sessions.$asArray().$add(object).then (ref, error) ->
      return ref.name()

  factory.update = (updatedSession) ->
    sessionsDestination(updatedSession.date)
    sessions.$update(updatedSession.$id, stripsession(updatedSession)).then (ref, error) ->
      return ref.name()

  factory.destroy = (id) ->
    sessions.$remove(id).then (ref, error) ->
      return ref.name

  return factory
