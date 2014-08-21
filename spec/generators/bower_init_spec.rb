require 'spec_helper'
require 'rails/generators'
require_relative '../../lib/rails/generators/rang/bower/init/init_generator.rb'

describe Rang::Bower::Generators::InitGenerator do

  let(:klass) { Rang::Bower::Generators::InitGenerator }
  let(:generator) { klass.new }

  it "has a description" do
    expect(klass.desc.empty?).to be_falsey
  end

  describe "#create_bower_gemfile" do
    it 'creates Gemfile.bower' do
      expect(generator).to receive(:create_file).with("Gemfile.bower", "source 'https://rails-assets.org'\n")
      generator.create_bower_gemfile
    end
  end

  describe "#include_bower_gemfile_into_gemfile" do
    it 'includes Gemfile.bower into Gemfile' do
      expect(generator).to receive(:inject_into_file) do |filename, regex, &block|
        expect(filename).to eq "Gemfile"
        expect(block.call).to include "\neval(IO.read('Gemfile.bower'), binding) if File.exist? 'Gemfile.bower'"
      end
      generator.include_bower_gemfile_into_gemfile
    end

    it 'includes Gemfile.bower into Gemfile at the right point' do
      expect(generator).to receive(:inject_into_file) do |filename, regex, &block|
        regex = regex[:after]
        expect("source 'https://rubygems.org'\n" =~ regex).to be_truthy
      end
      generator.include_bower_gemfile_into_gemfile
    end
  end

  describe "#add_angular_gems" do
    before do
      allow(generator).to receive(:generate)
      allow(generator).to receive(:run)
    end

    it 'adds essential angular gems' do
      expect(generator).to receive(:generate).with("rang:bower:add", "angular '~> 1.2.0' quiet")
      expect(generator).to receive(:generate).with("rang:bower:add", "angular-route '~> 1.2.0' quiet")
      generator.add_angular_gems
    end

    it 'runs bundler' do
      expect(generator).to receive(:run).with("bundle install")
      generator.add_angular_gems
    end
  end

end
