angular.module("td").factory "authFactory", ($rootScope, $state, $firebaseSimpleLogin, FIREBASE_URL) ->
  firebaseRef = new Firebase FIREBASE_URL
  auth = $firebaseSimpleLogin(firebaseRef)

  factory = {}

  factory.auth = ->
    return auth.$getCurrentUser()

  factory.login = (provider, loginUser) ->
    if provider == 'password'
      return auth.$login('password',
        email: loginUser.email,
        password: loginUser.password
      )

    else if provider == 'facebook'
      return auth.$login("facebook",
        rememberMe: true,
        scope: 'email'
      )

  factory.create = (email, password) ->
    return auth.$createUser(email, password)

  factory.logOut = ->
    auth.$logout()
    delete $rootScope.currentUser;
    $state.go 'home'

  return factory
