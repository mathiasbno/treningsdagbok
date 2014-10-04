angular.module("td")
  .controller "UpdateUsersCtrl", ($rootScope, $scope, sportFactory, userFactory, helperFactory) ->
    $scope.newSport == undefined
    $scope.selectedSport = {sportId: ''}

    $scope.genders = [{id: 'mail', name: 'Man'}, {id: 'femail', name: 'Woman'}]

    sportFactory.all().then (sports) ->
      $scope.sports = sports

    $scope.addSportToUser = ->
      if $rootScope.currentUser.sports == undefined
          $rootScope.currentUser.sports = []

      if $scope.newSport == undefined
        if $scope.selectedSport.sportId.length
          sport = sportFactory.find($scope.selectedSport.sportId)

          $rootScope.currentUser.sports.push sport
          $scope.selectedSport = {sportId: ''}

      else
        $scope.errors = []

        sportObj = {"name": $scope.newSportInput.sport}
        sportFactory.create(sportObj).then (sportId) ->
          sportFactory.find(sportId).then (sport) ->
            $rootScope.currentUser.sports.push sport
            $scope.newSportInput.sport = ''
            $scope.newSport = false

    $scope.updateUser = ->

      if $rootScope.currentUser.sports == undefined
          $rootScope.currentUser.sports = []

      id = helperFactory.escapeEmailAddress $rootScope.currentUser.$id

      updatedUser = {
        email: $rootScope.currentUser.email
        first_name: $rootScope.currentUser.first_name
        last_name: $rootScope.currentUser.last_name
        full_name: "#{$rootScope.currentUser.first_name} #{$rootScope.currentUser.last_name}"
        gender: $rootScope.currentUser.gender
        sports: helperFactory.stripObject($rootScope.currentUser.sports)
      }

      userFactory.update(id, updatedUser)
