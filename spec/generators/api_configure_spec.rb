require 'spec_helper'
require 'rails/generators'
require_relative '../../lib/rails/generators/rang/api/configure/configure_generator.rb'

describe Rang::Api::Generators::ConfigureGenerator do
  let(:klass) { Rang::Api::Generators::ConfigureGenerator }
  let(:generator) { klass.new }

  it "has a description" do
    expect(klass.desc.empty?).to be_falsey
  end

  pending "test api configure."


end
