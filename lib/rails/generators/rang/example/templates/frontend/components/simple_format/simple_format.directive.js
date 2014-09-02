angular.module('shared.simpleFormat').directive('simpleFormat', function(){
  return {
    replace: true,
    scope: {
      simpleFormat: '='
    },
    controller: function($scope) {
      $scope.paragraphs = $scope.simpleFormat.split("\n\n")
    },
    template: '<p ng-repeat="paragraph in paragraphs">{{paragraph}}</p>'
  }
})
