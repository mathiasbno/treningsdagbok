angular.module("td")
  .directive "monthAnimation", ($timeout) ->
    link: (scope, element, attrs) ->

      scope.$on 'openMonth', (e, month) ->
        _position = $(month).position()
        _width = $(month).width()

        $(element).css
          'top': _position.top
          'left': _position.left
          'width': _width

        $(element).show()
        $(element).delay(1000).addClass('open')

        $('.year').css
          'marginTop': 300
