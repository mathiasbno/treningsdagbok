angular.module("td").factory 'helperFactory', () ->

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

    return factory
