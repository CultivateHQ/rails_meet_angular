require 'spec_helper'
require 'rails/generators'
require_relative '../../lib/rails/generators/rails_meet_angular/bower/add/add_generator.rb'

describe RailsMeetAngular::Bower::Generators::AddGenerator do

  let(:klass) { RailsMeetAngular::Bower::Generators::AddGenerator }
  let(:generator) { klass.new(['angular', '~> 2.0']) }

  it "has a description" do
    expect(klass.desc.empty?).to be_falsey
  end

  describe '#run_init' do
    context 'when a Gemfile.bower is absent' do
      it 'runs the init task' do
        expect(generator).to receive(:generate).with("rails_meet_angular:bower:init")
        generator.run_init
      end
    end

    context 'when a Gemfile.bower exists' do
      before do
        allow(File).to receive(:exist?).and_return(true)
      end

      it 'doesn’t run the init task' do
        expect(generator).to_not receive(:generate)
        generator.run_init
      end
    end
  end

  describe '#add_gem_to_bower_gemfile' do
    # Silence messages
    before { allow(generator).to receive(:puts) }
    before { allow(generator).to receive(:append_file) }

    it 'adds the gem to Gemfile.bower' do
      expect(generator).to receive(:append_file).with("Gemfile.bower",
        "gem 'rails-assets-angular', '~> 2.0'\n")
      generator.add_gem_to_bower_gemfile
    end

    context 'if dependency_name doesn’t end with a @' do
      it 'doesn’t run bundler' do
        expect(generator).to_not receive(:run).with('bundle install')
        generator.add_gem_to_bower_gemfile
      end
    end

    context 'if dependency_name ends with a @' do
      let(:generator) { klass.new(['angular@', '~> 2.0']) }

      it 'runs bundler' do
        expect(generator).to receive(:run).with('bundle install')
        generator.add_gem_to_bower_gemfile
      end
    end
  end

end
