require "spec_helper"

describe Rang::Patcher do

  def enable_config(prop, value=true)
    allow(Rang::Config).to receive(prop).and_return(value)
  end

  describe "#patch_sprockets_to_use_html_extension!" do
    let(:trail) { double() }

    before do
      enable_config(:patch_sprockets_to_use_html_extension)
      allow(trail).to receive(:alias_extension)
      allow(Rails.application.assets).to receive(:send).and_return(trail)
      allow(Rails.application.assets).to receive(:instance_eval)
      allow(Rails.application.assets).to receive(:register_mime_type)
    end

    it "patches sprockets trail with slim->html alias" do
      expect(Rails.application.assets).to receive(:send).with(:trail).and_return(trail)
      expect(trail).to receive(:alias_extension).with(".slim", ".html")
      Rang::Patcher.patch!
    end

    it "patches assets to change #extension_for_mime_type behaviour" do
      expect(Rails.application.assets).to receive(:instance_eval).and_call_original
      allow(Rails.application.assets).to receive(:register_mime_type).and_call_original
      Rang::Patcher.patch!
    end

    it "registers the text/html mime type to .html" do
      allow(Rails.application.assets).to receive(:instance_eval).and_call_original
      allow(Rails.application.assets).to receive(:register_mime_type).and_call_original
      Rang::Patcher.patch!
      expect(Rails.application.assets.extension_for_mime_type("text/html")).to eq ".html"
    end
  end

  describe "#disable_html_precompilation!" do
    before do
      enable_config(:disable_html_precompilation)
    end

    it "Changes assets.precompile to ignore html files" do
      expect(Rails.application.config.assets).to receive(:precompile=) do |proc, regex|
        expect(proc.call("asset.html", "app/assets")).to be_falsey
      end
      Rang::Patcher.patch!
    end
  end

  describe "#add_frontend_assets_directory!" do
    before do
      enable_config(:frontend_assets_directory, "frontend")
    end

    it "adds /frontend to assets directories" do
      Rang::Patcher.patch!
      expect(Rails.application.config.assets.paths).to include "#{Rails.root}/app/assets/frontend"
    end
  end

  describe "#register_slim_as_assets_engine!" do
    context "when slim gem is present" do
      before do
        allow(Rang::Util).to receive(:gem_present?).and_return(true)
      end

      it "registers slim as an assets engine" do
        expect(Rails.application.assets).to receive(:register_engine)
          .with(".slim", ::Slim::Template)
        Rang::Patcher.patch!
      end
    end

    context "when slim gem is not present" do
      before do
        allow(Rang::Util).to receive(:gem_present?).and_return(false)
      end

      it "does not register slim as an assets engine" do
        expect(Rails.application.assets).to_not receive(:register_engine)
          .with(".slim", ::Slim::Template)
        Rang::Patcher.patch!
      end
    end
  end

end
