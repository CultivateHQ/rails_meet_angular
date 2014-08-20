module RailsMeetAngular
  class RootController < ApplicationController
    def display
      render text: '<div ng-view></div>', layout: 'application'
    end
  end
end
