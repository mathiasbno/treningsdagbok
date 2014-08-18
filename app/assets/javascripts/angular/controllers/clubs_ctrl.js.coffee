angular.module("td")
  .controller "ClubsCtrl", ($scope, Restangular) ->
    Restangular.all("klubber").getList().then (clubs) ->
      $scope.clubs = clubs