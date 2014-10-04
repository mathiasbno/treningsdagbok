angular.module("td").factory 'helperFactory', ($rootScope, $firebase, FIREBASE_URL) ->

    factory = {}

    factory.escapeEmailAddress = (email) ->
      email = email.toLowerCase()
      email = email.replace(/\./g, '-')
      email = email.replace(/\@/g, '-')
      return email

    factory.uppercaseFirstLetter = (text) ->
      text = text.charAt(0).toUpperCase() + text.substring(1)
      return text

    factory.stripObject = (array) ->
      angular.copy(array)

    factory.seassionsRefConstructor = (year, week) ->
      firebaseSessionsRef = new Firebase FIREBASE_URL + "sessions/#{$rootScope.currentUser.$id}/#{year}-#{week}"
      return $firebase(firebaseSessionsRef).$asArray()

    return factory
