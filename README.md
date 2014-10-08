# Rang

This is a gem that makes Rails and Angular play nicely together.

It should replace all the strange initializers and bag of angular_* gems you've
got in your Rails & Angular project.

Where existing solutions are effective and well-maintained, they are included.
Otherwise, we've included our own.

## Installation

Add this to your Gemfile:

`gem 'rang'`

Then:

```bash
$ bundle install
```

## Quickstart

```bash
# Prompts you to run each of the generators below.
$ rails g rang:install
```

## Features

This gem collects quite a few things. Summary:

* Facilitates the Angular best practice structure.
* Serves and precompiles Angular templates.
* Precompiles Angular with DI annotations.
* Uses [rails-assets](http://rails-assets.org) to manage Bower dependencies.
* Gets Angular + Rails working together on CSRF protection.
* Provides an `ng-view` root route.
* Provides a generator to install and configure [Teaspoon](https://github.com/modeset/teaspoon) for Angular.
* Configures slim, if available, to ignore `{` and `}`.

### Frontend structure

Instead of using `/assets/javascripts`, `/assets/stylesheets`, etc, this gem
supports following the best practice structure [recommended by Google](https://docs.google.com/a/cultivatehq.com/document/d/1XXMvReO8-Awi1EZXAXS4PzDzdNvV6pGcuaF4Q9821Es/pub).
[This very readable post](https://github.com/yeoman/generator-angular/issues/109)
sets out the rationale and walks through the recommended structure.

What this means in practice is that assets in `assets/frontend` are served and
compiled just like `assets/javascripts` and `assets/stylesheets` would be.

To get started:

```bash
# This should be non-destructive, but it's your assets on the line.
$ rails g rang:assets:init
```

This moves your existing `/app/assets` to `/app/assets.removed` and sets up a
fresh assets directory following the best practice structure.

Caveats:

* CSS might still need some special treatment.
* The structure is still under active refinement. However, this gem is flexible
  enough to accept most changes.

### Templates

In line with the structure above, Rang also compiles templates into
Angular's `$templateCache`. You should load them in your routes like this:

```javascript
angular
  .module('blog.posts', ['ngRoute'])
  .config(function($routeProvider) {
    $routeProvider
      .when('/posts', {
        templateUrl: '/assets/posts/posts.html', // Use .html, not .slim, etc
        controller: 'PostsController'
      });
  });
```

And then in your `application.js`, follow this structure:

```javascript
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

[Slim](https://github.com/slim-template/slim-rails) is automatically supported
for assets if it's in your `Gemfile`.

### Annotation (minification)

Rang employs [ng-annotate](https://github.com/olov/ng-annotate) (via
[ngannotiate-rails](https://github.com/kikonen/ngannotate-rails)) to make sure
your Angular code is minified properly.

### Bower dependencies

Rang uses [rails-assets.org](http://rails-assets.org/) to include
bower packages. While a little slow sometimes, it's still a better solution than
requiring npm and bower / having a load of useless stuff in source control. For now.

It manages the rails-assets dependencies in an auxilliary gemfile called
`Gemfile.bower`. This can be created and managed with generators.

Usage:

```bash
# Not strictly necessary, but take a look at what it generates.
$ rails g rang:bower:init

# Adds angular-cookies gem to Gemfile.bower.
$ rails g rang:bower:add angular-cookies '~ 1.2.0'

# As above, but runs bundler after.
$ rails g rang:bower:add angular@ '~ 1.2.0'
```

### Teaspoon

```bash
$ rails g rang:teaspoon:install
```

This does the following:

* Adds `teaspoon` & `phantomjs` to your Gemfile.
* Runs the normal `teaspoon:install` generator.
* Adds `angular-mocks` to your `Gemfile.bower` and includes it in `spec_helper.js`.
* Preconfigures Teaspoon to fix some issues ([#120](https://github.com/modeset/teaspoon/issues/120), [#197](https://github.com/modeset/teaspoon/issues/197)).
* Configures Teaspoon to enable putting specs alongside your code (optional).

### API Configuration

```bash
$ rails g rang:api:configure
```

This does the following:

* Installs and confgures [active_model_serializers](https://github.com/rails-api/active_model_serializers/tree/0-9-stable)
  to serve Angular-appropriate JSON out of the box.
* Installs and requires [angular-restmod](https://github.com/platanus/angular-restmod),
  a Rails-inspired ORM for Angular.
* Sets up an `api/` route and controller scope for your API controllers.

### CSRF

Rang uses [angular_rails_csrf](https://github.com/jsanders/angular_rails_csrf)
to join up Rails + Angular's CSRF protection.

So you don't need to feel bad turning it off anymore!

### Root route

To avoid having a controller just to serve 'ng-view' there's a convenience
action for you to wire your root to.

```bash
$ rails g rang:add_root
```

Adds this to `config/routes.rb`:

```ruby
mount Rang::Engine => "/"
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rails-meet-angular/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
