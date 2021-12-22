require 'rails_helper'

RSpec.describe 'UnnecessaryRoutes', type: :routing do
  it 'does not define unnecessary pirate routes' do
    expect(post: '/pirates').not_to be_routable
    expect(patch: '/pirates/1').not_to be_routable
  end

  it 'does not define unnecessary island routes' do
    expect(get: '/islands/1').not_to be_routable
    expect(post: '/islands').not_to be_routable
    expect(patch: '/islands/1').not_to be_routable
    expect(delete: '/islands/1').not_to be_routable
  end

  it 'does not define unnecessary treasure routes' do
    expect(get: '/treasures').not_to be_routable
    expect(get: '/treasures/1').not_to be_routable
    expect(patch: '/treasures/1').not_to be_routable
    expect(delete: '/treasures/1').not_to be_routable
  end
end
