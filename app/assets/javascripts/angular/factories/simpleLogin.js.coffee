angular.module("td").factory "simpleLoginFactory", ($firebaseSimpleLogin, FIREBASE_URL) ->
  firebaseRef = new Firebase FIREBASE_URL
  return $firebaseSimpleLogin firebaseRef
