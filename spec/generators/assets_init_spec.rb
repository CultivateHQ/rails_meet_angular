require 'spec_helper'
require 'rails/generators'
require_relative '../../lib/rails/generators/rang/assets/init/init_generator.rb'

describe Rang::Assets::Generators::InitGenerator do
  let(:klass) { Rang::Assets::Generators::InitGenerator }
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

  describe "#add_html_attributes" do
    before do
      allow(Rang::Util).to receive(:application_name).and_return 'dogs'
      allow(generator).to receive(:gsub_file)
      allow(generator).to receive(:no?).and_return false
    end

    context "when layout is an ERB file" do
      before do
        allow(generator).to receive(:layout_file).and_return "fake.html.erb"
        allow(generator).to receive(:layout_handler).and_return "ActionView::Template::Handlers::ERB"
      end

      it "inserts ng-app" do
        expect(generator).to receive(:gsub_file).with("fake.html.erb", "<html>", "<html ng-app='dogs'>")
        generator.add_html_attribute
      end
    end

    context "when layout is a Slim file" do
      before do
        allow(generator).to receive(:layout_file).and_return "fake.slim"
        allow(generator).to receive(:layout_handler).and_return "Slim::RailsTemplate"
      end

      it "inserts ng-app" do
        expect(generator).to receive(:gsub_file).with("fake.slim", /^html$/, "html ng-app='dogs'")
        generator.add_html_attribute
      end
    end

    it "hasn't been broken by ActionController changes" do
      expect(ApplicationController.new.send(:_layout).identifier).to be_a String
      expect(ApplicationController.new.send(:_layout).handler).to respond_to :call
      expect(generator.send(:layout_file)).to eq ApplicationController.new.send(:_layout).identifier
      expect(generator.send(:layout_handler)).to eq ApplicationController.new.send(:_layout).handler.class.to_s
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
