angular.module("td")
  .config ($locationProvider, $stateProvider, $urlRouterProvider) ->
    $locationProvider.html5Mode true

    $stateProvider
      .state "home",
        url: "/"
        templateUrl: "/templates/home/index.html"
        controller: 'FrontPageCtrl'

      .state "user",
        url: "/templates/user"
        templateUrl: "user/show.html"
      .state "user_update",
        url: "/views/user/update"
        templateUrl: "/templates/user/update.html"
        controller: 'UpdateUsersCtrl'

      .state "otherwise",
        url : '/'
