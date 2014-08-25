require 'spec_helper'
require 'rails/generators'
require_relative '../../lib/rails/generators/rang/add_root/add_root_generator.rb'

describe Rang::Generators::AddRootGenerator do
  let(:klass) { Rang::Generators::AddRootGenerator }
  let(:generator) { klass.new }

  it "has a description" do
    expect(klass.desc.empty?).to be_falsey
  end

  describe "#add_root" do
    it 'adds a root route' do
      expect(generator).to receive(:route).with("mount Rang::Engine => \"/\"\n")
      generator.add_route
    end
  end


end
