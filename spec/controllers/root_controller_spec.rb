require 'spec_helper'

describe Rang::RootController do
  let(:controller) { Rang::RootController.new }

  describe '#display' do
    it 'returns an ng-view element' do
      expect(controller).to receive(:render).with({text: '<div ng-view></div>', layout: 'application'})
      controller.display
    end
  end
end
