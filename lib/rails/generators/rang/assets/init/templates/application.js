//= require angular
//= require angular-route
//= require angular-templates

// You should require module manifests from this file, e.g. require posts/posts
// Those manifests should specify their own dependencies.

angular.module('<%= Rang::Util.application_name %>', ['ngRoute'])
  .config(function($routeProvider) {
    $routeProvider.otherwise({
      redirectTo: '/'
    });
  })
  .run(AngularTemplates.load);
