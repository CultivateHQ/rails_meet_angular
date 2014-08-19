require 'spec_helper'

class ContextFake
  def return_self(*arguments)
    self
  end

  def escape_javascript(string)
    string
  end

  alias_method :assets, :return_self
  alias_method :logical_paths, :return_self
  alias_method :assets, :return_self
  alias_method :environment, :return_self
  alias_method :find_asset, :return_self
  alias_method :depend_on_asset, :return_self
end

describe RailsMeetAngular::Helpers do

  context '#templates' do
    let(:context) { ContextFake.new }

    it 'calls given block for each template path' do
      allow(context).to receive(:logical_paths).and_return(['one.htm','two.htm','three.htm', 'invalid.jpg'])
      expect do |b|
        RailsMeetAngular::Helpers.templates(context, &b)
      end.to yield_control.exactly(3).times
    end

    it 'calls given block with valid slimmed path' do
      allow(context).to receive(:logical_paths).and_return(['one.htm'])
      expect do |b|
        RailsMeetAngular::Helpers.templates(context, &b)
      end.to yield_with_args('one.slim', anything)
    end

    it 'calls given block with template string' do
      template_string = '<p>html</p>'
      allow(context).to receive(:logical_paths).and_return(['one.htm'])
      allow(context).to receive(:find_asset).and_return(template_string)
      expect do |b|
        RailsMeetAngular::Helpers.templates(context, &b)
      end.to yield_with_args(anything, RailsMeetAngular::Helpers.escape_javascript(template_string))
    end

    it 'calls given block with escaped template string' do
      template_string = '<p>html</p>'
      allow(context).to receive(:logical_paths).and_return(['one.htm'])
      allow(RailsMeetAngular::Helpers).to receive(:escape_javascript).and_return(template_string)
      expect do |b|
        RailsMeetAngular::Helpers.templates(context, &b)
      end.to yield_with_args(anything, template_string)
    end

    it 'calls depend_on_asset for each template' do
      template_path = 'one.htm'
      allow(context).to receive(:logical_paths).and_return([template_path, 'invalid.jpg'])
      expect(context).to receive(:depend_on_asset).with(template_path)
      RailsMeetAngular::Helpers.templates(context) {}
    end
  end
end
