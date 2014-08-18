angular.module("td")
  .controller "UpdateUsersCtrl", ($state, $rootScope, $scope, Restangular) ->
    # $scope.new_sport_panel = false
    # $scope.new_club_panel = false
    # $scope.uppdate_password_panel = false

    # Restangular.all('klubber').getList().then (clubs) ->
    #   $scope.clubs = clubs

    # Restangular.all('idretter').getList().then (sports) ->
    #   $scope.sports = sports

    # $scope.addClub = (club) ->
    #   $rootScope.current_user.clubs.push club

    # $scope.removeClub = (club) ->
    #   index = $rootScope.current_user.clubs.indexOf(club);
    #   $rootScope.current_user.clubs.splice(index, club.id)

    # $scope.addSport = (sport) ->
    #   $rootScope.current_user.sports.push sport

    # $scope.removeSport = (sport) ->
    #   index = $rootScope.current_user.sports.indexOf(sport);
    #   $rootScope.current_user.sports.splice(index, sport.id)

    # $scope.addParams = ->
    #   if $scope.new_club

    #     club_params = {
    #       name: $scope.new_club,
    #     }

    #     Restangular.all('klubber').post(club_params).then (club) ->
    #       $rootScope.current_user.clubs.push club.id
    #       $scope.updateUser()

    #   if $scope.new_sport

    #     sport_params = {
    #       name: $scope.new_sport,
    #     }

    #     Restangular.all('idretter').post(sport_params).then (sport) ->
    #       $rootScope.current_user.sports.push sport.id
    #       $scope.updateUser()

    #   if !$scope.new_sport || !$scope.new_club
    #     $scope.updateUser()

    # $scope.updateUser = ->
    #   Restangular.one('bruker', $rootScope.current_user.id).patch($rootScope.current_user)
