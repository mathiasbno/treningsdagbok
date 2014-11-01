angular.module("td")
  .controller "MetaCtrl", ($scope, metaFactory) ->

    $scope.$watch 'current_week_sessions', ->
      unless $scope.current_week_sessions == undefined
        metaFactory.all().then (fields) ->
          $scope.meta = fields

    metaFactory.baseAll().then (metas) ->
      $scope.meta_base = metas

    $scope.addMeta = (meta) ->
      metaFactory.add(meta)
