require 'spec_helper'

describe Rang::Railtie do

  it 'adds /frontend to assets directories' do
    expect(Rails.application.config.assets.paths).to include "#{Rails.root}/app/assets/frontend"
  end

  it 'registers slim as an assets engine' do
    expect(Rails.application.assets.engines['.slim']).to eq ::Slim::Template
  end

end
