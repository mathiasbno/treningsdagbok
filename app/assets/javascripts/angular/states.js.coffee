angular.module("td")
  .config ($locationProvider, $stateProvider, $urlRouterProvider) ->
    $locationProvider.html5Mode true

    $stateProvider
      .state "home",
        url: "/"
        templateUrl: "home/index.html"
        controller: 'FrontPageCtrl'

      .state "user",
        url: "/user/show.html"
        templateUrl: "user/show.html"
      .state "user_update",
        url: "/user/update.html"
        templateUrl: "user/update.html"
        controller: 'UpdateUsersCtrl'

      # .state "user_update",
      #   url: "/bruker/rediger"
      #   templateUrl: "/bruker/edit.html"
      # .state "user_show",
      #   url: "/bruker/:id"
      #   templateUrl: (params) ->
      #     "/bruker/#{params.id}.html"
      # .state "user_new",
      #   url: "/bruker/new"
      #   controller: 'NewUserCtrl'
      # .state "user_edit",
      #   url: "/bruker/:id/edit"
      #   controller: 'UpdateUsersCtrl'
      #   templateUrl: (params) ->
      #     "/bruker/#{params.id}/edit.html"

      # .state "clubs",
      #   url: "/klubber"
      #   controller: 'ClubsCtrl'
      #   templateUrl: "/klubber"

      # .state "sessions",
      #   url: "/trening"
      #   controller: 'SessionsCtrl'
      #   templateUrl: "/trening"

      # .state "logout",
      #   url: "/log_out"

      .state "otherwise",
        url : '/'
