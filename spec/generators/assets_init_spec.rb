require 'spec_helper'
require 'rails/generators'
require_relative '../../lib/rails/generators/rails_meet_angular/assets/init/init_generator.rb'

describe RailsMeetAngular::Assets::Generators::InitGenerator do
  let(:klass) { RailsMeetAngular::Assets::Generators::InitGenerator }
  let(:generator) { klass.new }

  before { allow(generator).to receive(:say_status) }

  it "has a description" do
    expect(klass.desc.empty?).to be_falsey
  end

  describe "#deprecate_old_assets!" do
    before do
      allow(File).to receive(:exist?).and_return(true)
      allow(generator).to receive(:empty_directory)
      allow(generator).to receive(:run)
      allow(generator).to receive(:remove_dir)
    end

    it 'copies assets to holding dirs' do
      expect(generator).to receive(:run).with("mv app/assets/javascripts app/assets.removed/javascripts", anything)
      expect(generator).to receive(:run).with("mv app/assets/stylesheets app/assets.removed/stylesheets", anything)
      generator.deprecate_old_assets!
    end

    it 'removes asset dirs' do
      expect(generator).to receive(:remove_dir).with("app/assets/javascripts")
      expect(generator).to receive(:remove_dir).with("app/assets/stylesheets")
      generator.deprecate_old_assets!
    end
  end

  describe "#create_assets!" do
    before do
      allow(generator).to receive(:template)
    end

    it 'creates all assets' do
      expect(generator).to receive(:template).with('application.js', 'app/assets/frontend/application.js')
      expect(generator).to receive(:template).with('application.scss', 'app/assets/frontend/application.scss')
      expect(generator).to receive(:template).with('_base.scss', 'app/assets/frontend/style/_base.scss')
      expect(generator).to receive(:template).with('components.js', 'app/assets/frontend/components/components.js')
      generator.create_assets!
    end

  end


end
