RSpec.describe Kan::Abilities do
  class PostAbilities
    include Kan::Abilities

    register('read') { |_| true }
    register('edit') { |_, _| false }
  end

  class EmptyAbilities
    include Kan::Abilities
  end

  let(:abilities) { PostAbilities.new }

  describe '::ability_list' do
    it { expect(EmptyAbilities.ability_list).to eq({}) }

    it { expect(PostAbilities.ability_list).to be_a Hash }
    it { expect(PostAbilities.ability_list.keys).to eq [:read, :edit] }
  end

  describe '#action' do
    it { expect(abilities.ability('read')).to be_a Proc }
    it { expect(abilities.ability('read').call).to eq true }
    it { expect(abilities.ability('edit').call).to eq false }
  end
end