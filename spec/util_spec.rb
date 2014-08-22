require 'spec_helper'

describe Rang::Util do
  describe '#gem_present?' do
    context 'when given gem is present' do
      before do
        allow(Gem::Specification).to receive(:find_all_by_name)
          .with('fake_gem').and_return([true])
      end

      it 'returns true' do
        expect(Rang::Util.gem_present? 'fake_gem').to be_truthy
      end
    end

    context 'when given gem is present' do
      before do
        allow(Gem::Specification).to receive(:find_all_by_name)
          .with('fake_gem').and_return([false])
      end

      it 'returns false' do
        expect(Rang::Util.gem_present? 'fake_gem').to be_falsey
      end
    end
  end
end
