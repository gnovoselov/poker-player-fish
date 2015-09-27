require_relative '../card.rb'

describe Card do
  it "initializes with rand and suits" do
    expect(Card.new(6, 'hearts')).to be_kind_of Card
  end
end
