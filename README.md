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
supports following the best practice structure [recommended by Google](https://docs.google.com/a/cultivatehq.com/document/d/1XXMvReO8-Awi1EZXAXS4PzDzdNvV6pGcuaF4Q9821Es/pub).
[This very readable post](https://github.com/yeoman/generator-angular/issues/109)
sets out the rationale and walks through the recommended structure.

What this means in practice is that assets in `assets/frontend` are served and
compiled just like `assets/javascripts` and `assets/stylesheets` would be.

To get started:

```
# This should be non-destructive, but it's your assets on the line.
rails g rails_meet_angular:assets:init
```

Caveats:

* JS tests still aren't integrated.
* CSS might still need some special treatment.
* The structure is still under active refinement. However, this gem is flexible
  enough to accept most changes.

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


### Assets

RailsMeetAngular uses [rails-assets.org](http://rails-assets.org/) to include
bower packages. While a little slow sometimes, it's still a better solution than
requiring npm and bower / having a load of useless stuff in source control. For now.

It manages the rails-assets dependencies in an auxilliary gemfile called
`Gemfile.bower`. This can be created and managed with generators.

Usage:

```
rails g rails_meet_angular:bower:init # Not strictly necessary, but take a look.
rails g rails_meet_angular:bower:add angular '~ 1.2.0' # Adds angular gem to Gemfile.bower
rails g rails_meet_angular:bower:add angular@ '~ 1.2.0' # As above, but runs bundler after.
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/rails-meet-angular/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
