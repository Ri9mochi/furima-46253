require 'rails_helper'

RSpec.describe 'FactoryBot sanity check', type: :model do
  describe 'FactoryBot.create can create objects without errors' do
    it 'creates a user without errors' do
      # Userオブジェクトが正常に作成されることを確認
      expect { FactoryBot.create(:user) }.not_to raise_error
    end

    it 'creates an item without errors' do
      # Itemオブジェクトが正常に作成されることを確認
      expect { FactoryBot.create(:item) }.not_to raise_error
    end
  end
end
