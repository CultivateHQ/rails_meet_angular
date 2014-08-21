require "spec_helper"
require "rails/generators"
require_relative "../../lib/rails/generators/rang/teaspoon/install/install_generator.rb"

describe Rang::Teaspoon::Generators::InstallGenerator do

  let(:klass) { Rang::Teaspoon::Generators::InstallGenerator }
  let(:generator) { klass.new }

  it "has a description" do
    expect(klass.desc.empty?).to be_falsey
  end

  describe "#add_teaspoon_to_gemfile" do
    it "Adds gems to gemfile" do
      expect(generator).to receive(:gem_group).with(:development, :test).and_yield
      expect(generator).to receive(:gem).with("teaspoon", an_instance_of(String))
      expect(generator).to receive(:gem).with("phantomjs", an_instance_of(String))
      generator.add_teaspoon_to_gemfile
    end
  end

  describe "#add_angular_mocks_to_gemfile" do
    it "Runs bower:add generator with angular-mocks" do
      expect(generator).to receive(:generate)
        .with("rang:bower:add", "angular-mocks '~> 1.2.0' quiet")
      generator.add_angular_mocks_to_gemfile
    end
  end

  describe "#teaspoon_install" do
    it "runs teaspoon:install" do
      expect(generator).to receive(:generate).with("teaspoon:install")
      generator.teaspoon_install
    end
  end

  describe "#add_teaspoon_assets_hack" do
    it "injects fix into teaspoon_env" do
      expect(generator).to receive(:inject_into_file)
        .with("spec/teaspoon_env.rb", {before: "Teaspoon.configure do |config|"}) do |a, b, &block|
          expect(block.call).to be_a String
        end
      generator.add_teaspoon_assets_hack
    end
  end

  describe "#add_matcher" do
    it "adds test matcher to teaspoon_env" do
      expect(generator).to receive(:inject_into_file) do |filename, regex, &block|
        expect(filename).to eq "spec/teaspoon_env.rb"
        expect(block.call).to be_a String
      end
      generator.add_matcher
    end

    it "uses a line regex that matches the right line" do
      expect(generator).to receive(:inject_into_file) do |filename, regex, &block|
        regex = regex[:after]
        expect("#suite.matcher = \"{spec/javascripts,app/assets}/**/*[_.]spec.{js,js.coffee,coffee}\"" =~ regex).to be_truthy
      end
      generator.add_matcher
    end

    it "uses a line regex that doesn't match the similar line later on" do
      expect(generator).to receive(:inject_into_file) do |filename, regex, &block|
        regex = regex[:after]
        expect("  #config.suite :targeted do |suite|\n#  suite.matcher = \"test/javascripts/targeted/*_test.{js,js.coffee,coffee}\"\n  #end" =~ regex ).to be_falsey
      end
      generator.add_matcher
    end
  end

  describe "#require_angular_mocks" do
    it "adds angular-mocks require to test_helper" do
      expect(generator).to receive(:append_file)
        .with('spec/javascripts/spec_helper.js') do |a, &block|
          expect(block.call).to include '//= require angular-mocks'
        end
      generator.require_angular_mocks
    end
  end

  describe "#inform_of_actions" do
    it "informs the user of some things" do
      expect(generator).to receive(:say).at_least(1).times
      generator.inform_of_actions
    end
  end

  describe "#inform_about_better_errors" do
    context "when better_errors is in the Gemfile" do
      before do
        allow(Gem::Specification).to receive(:find_all_by_name).with('better_errors').and_return([true])
      end

      it "warns the user" do
        expect(generator).to receive(:say).at_least(1).times
        generator.inform_about_better_errors
      end
    end

    context "when better_errors is not in the Gemfile" do
      before do
        allow(Gem::Specification).to receive(:find_all_by_name).with('better_errors').and_return([])
      end

      it "does not speak" do
        expect(generator).to_not receive(:say)
        generator.inform_about_better_errors
      end
    end
  end

end
