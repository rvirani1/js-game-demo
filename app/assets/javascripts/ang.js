var app = angular.module("twitterApp", []);

app.controller("AppCtrl", function($scope) {
  $scope.loadMoreTweets = function() {
    console.log("loading tweets");
  };
  $scope.deleteTweets = function() {
    console.log("deleting tweets");
  };

});

app.directive("enter", function() {
  return function(scope, element, attrs) {
    element.bind("mouseenter", function() {
      scope.$apply(attrs.enter);
    });
  };


});