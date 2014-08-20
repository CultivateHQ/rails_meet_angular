# Rails, Meet Angular

__VERY EARLY DAYS — much of this is imagined__

This is a gem that makes Rails and Angular place nicely together.

It should replace all the strange initializers and bag of angular_* gems you've
got in your Rails & Angular project.

Where existing solutions are effective and well-maintained, they are included.
Otherwise, we've included our own.

## Installation

Add this to your Gemfile:

`gem 'rails_meet_angular'`

And run

`bundle install`

## Features

This gem does quite a few disparate things. Here's a list:

### Frontend structure

Instead of using `/assets/javascripts`, `/assets/stylesheets`, etc, this gem
recommends following Google's
[Best Practice Recommendations for Angular App Structure](https://docs.google.com/a/cultivatehq.com/document/d/1XXMvReO8-Awi1EZXAXS4PzDzdNvV6pGcuaF4Q9821Es/pub).
(This [excellent and very readable rationale](https://github.com/yeoman/generator-angular/issues/109) by @joshdmiller is worth reading too.)

In short, this means your 'assets' folder should look something like this:

```
|-- assets/
|   |-- frontend/
|   |   |-- posts/
|   |   |   |-- posts.js
|   |   |   |-- posts_controller.js
|   |   |   |-- posts_controller.spec.js
|   |   |   |-- posts.scss
|   |   |   |-- posts.tpl.slim
|   |   |-- components/
|   |   |   |-- datepicker/
|   |   |   |   |-- datepicker.js
|   |   |   |   |-- datepicker.directive.js
|   |   |   |   |-- datepicker.directive.spec.js
|   |   |   |   |-- datepicker.scss
|   |   |   |   |-- datepicker.tpl.slim
|   |   |-- application.scss
|   |   |-- application.js
|   |-- images/
```

Each directory should have its own module, set out in a `foldername.js` manifest
file. `foldername.js` also sets its own routes (maybe).

`application.js` ties all the modules up and adds fallback routing.

The benefits are laid out in @joshdmiller's rationale (which is really worth
reading, you should read it), but in short — it keeps everything together and
allows you to copy a component from one project to another without any issues.

(I haven't worked out how to work the tests yet, and the CSS might need a little
thinking about, but I think something like this. This structure is very much
under development and will be refined over time.)

__You can still use the old way if you want. Nothing prevents you.__

### Templates

In line with the structure above, RailsMeetAngular also compiles templates into
Angular's $templateCache. You should load them in your routes like this:

```
angular
  .module('blog.posts', ['ngRoute'])
  .config(function($routeProvider) {
    $routeProvider
      .when('/posts', {
        templateUrl: '/assets/posts/posts.slim',
        controller: 'PostsController'
      });
  });
```

And then in your application.js, follow this structure:

```
//= require angular
//= require angular-route
//= require posts/posts
//= require angular-templates

angular.module('blog', ['blog.posts', 'ngRoute'])
  .config(function($routeProvider){
    $routeProvider.otherwise({
      redirectTo: '/posts'
    });
  })
  .run(AngularTemplates.load);
```

`AngularTemplates.load` is DI'd with `$templateCache` and includes all the templates
in your directory tree.

(This should probably be optional, but it isn't for now. Also only Slim is
supported because only Slim is good.)

### Annotation (ng-min)

RailsMeetAngular employs [ng-annotate](https://github.com/olov/ng-annotate) (via
ngannotiate-rails) to make sure your Angular code is minified properly.


## Contributing

1. Fork it ( https://github.com/[my-github-username]/rails-meet-angular/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
