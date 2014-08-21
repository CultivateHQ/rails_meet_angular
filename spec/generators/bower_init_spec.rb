require 'spec_helper'
require 'rails/generators'
require_relative '../../lib/rails/generators/rails_meet_angular/bower/init/init_generator.rb'

describe RailsMeetAngular::Bower::Generators::InitGenerator do

  let(:klass) { RailsMeetAngular::Bower::Generators::InitGenerator }
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
      expect(generator).to receive(:append_file).with("Gemfile", "\n"+
        "# Include Gemfile.bower for assets via https://rails-assets.org/.\n" +
        "eval(IO.read('Gemfile.bower'), binding) if File.exist? 'Gemfile.bower'\n")
      generator.include_bower_gemfile_into_gemfile
    end
  end

  describe "#add_angular_gems" do
    before do
      allow(generator).to receive(:generate)
      allow(generator).to receive(:run)
    end

    it 'adds essential angular gems' do
      expect(generator).to receive(:generate).with("rails_meet_angular:bower:add", "angular '~> 1.2.0' quiet")
      expect(generator).to receive(:generate).with("rails_meet_angular:bower:add", "angular-route '~> 1.2.0' quiet")
      generator.add_angular_gems
    end

    it 'runs bundler' do
      expect(generator).to receive(:run).with("bundle install")
      generator.add_angular_gems
    end
  end

end
