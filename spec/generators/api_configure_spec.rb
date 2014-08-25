require 'spec_helper'
require 'rails/generators'
require_relative '../../lib/rails/generators/rang/api/configure/configure_generator.rb'

describe Rang::Api::Generators::ConfigureGenerator do
  let(:klass) { Rang::Api::Generators::ConfigureGenerator }
  let(:generator) { klass.new }

  it "has a description" do
    expect(klass.desc.empty?).to be_falsey
  end

  describe "#add_to_application_js" do
    before do
      allow(Rails.application.assets).to receive_message_chain(:find_asset, :pathname).and_return 'app.js'
      allow(generator).to receive(:inject_into_file)
      allow(generator).to receive(:no?).and_return false
    end

    it "should insert require into application.js" do
      expect(generator).to receive(:inject_into_file) do |path, matcher, &block|
        expect(path).to eq 'app.js'
        expect(block.call).to eq "\n//= require angular-restmod/angular-restmod-bundle"
      end
      generator.add_to_application_js
    end

    it "should insert require after angular" do
      expect(generator).to receive(:inject_into_file) do |path, matcher, &block|
        expect("\n//= require angular" =~ matcher[:after]).to be_truthy
      end
      generator.add_to_application_js
    end

    it "shouldn't insert require after similar requires" do
      expect(generator).to receive(:inject_into_file) do |path, matcher, &block|
        expect("\n//= require angular-route" =~ matcher[:after]).to be_falsey
      end
      generator.add_to_application_js
    end
  end


end
