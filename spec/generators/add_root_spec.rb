require 'spec_helper'
require 'rails/generators'
require_relative '../../lib/rails/generators/rails_meet_angular/add_root/add_root_generator.rb'

describe RailsMeetAngular::Generators::AddRootGenerator do
  let(:klass) { RailsMeetAngular::Generators::AddRootGenerator }
  let(:generator) { klass.new }

  describe "#add_root" do
    it 'adds a root route' do
      expect(generator).to receive(:route).with('mount RailsMeetAngular::Engine => "/"')
      generator.add_route
    end
  end


end
