require_relative '../card.rb'

describe Card do
  it "initializes with rand and suits" do
    expect(Card.new(6, 'hearts')).to be_kind_of Card
  end
  it "compares by rank" do
    expect(Card.new('K', 'hearts').same_rank? Card.new('K','spades')).to be_true
  end
end
