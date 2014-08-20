module RailsMeetAngular
  module Generators
    class AddRootGenerator < Rails::Generators::Base
      desc "Adds a root route that is just ng-view."

      def add_route
        route 'mount RailsMeetAngular::Engine => "/"'
      end

    end
  end
end
