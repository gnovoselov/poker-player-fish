class Card
  attr_reader :rank, :suite
  def initialize(rank, suite)
    @rank = rank
    @suite = suite
  end

  def same_rank?(card)
    card.rank == @rank
  end

  def == (card)
    card.rank == @rank && card.suite = @suite
  end

end
