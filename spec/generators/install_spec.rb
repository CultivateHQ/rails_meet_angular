require 'spec_helper'
require 'rails/generators'
require_relative '../../lib/rails/generators/rang/install/install_generator.rb'

describe Rang::Generators::InstallGenerator do

  let(:klass) { Rang::Generators::InstallGenerator }
  let(:generator) { klass.new }

  it "has a description" do
    expect(klass.desc.empty?).to be_falsey
  end

  describe "#install_generator" do
    let(:expected_config) do
      {
        patch_sprockets_to_use_html_extension: true,
        disable_html_precompilation: true,
        frontend_assets_directory: "frontend"
      }
    end

    it "installs the generator" do
      expect(generator).to receive(:template).with("rang.rb", "config/initializers/rang.rb")
      generator.install_initializer
    end

    it "installs a generator with appropriate config" do
      expect(generator).to receive(:template) do |file, path|
        eval(IO.read(File.join(klass.source_root, file)))
        expected_config.each do |key, value|
          expect(Rang::Config.send(key)).to eq value
        end
      end

      generator.install_initializer
    end
  end

end
