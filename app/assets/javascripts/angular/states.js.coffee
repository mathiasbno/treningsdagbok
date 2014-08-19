angular.module("td")
  .config ($locationProvider, $stateProvider, $urlRouterProvider) ->
    $locationProvider.html5Mode true

    $stateProvider
      .state "home",
        url: "/"
        templateUrl: "templates/home/index.html"
        controller: 'FrontPageCtrl'

      .state "user",
        url: "/user"
        templateUrl: "templates/user/show.html"
      .state "user_new",
        url: "/user/register"
        templateUrl: "templates/user/register.html"
        controller: 'RegisterUserCtrl'
      .state "user_update",
        url: "/user/update"
        templateUrl: "templates/user/update.html"
        controller: 'UpdateUsersCtrl'

      .state "otherwise",
        url : '/'
