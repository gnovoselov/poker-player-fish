class Card
  STRING_RANKS = {
    'A' => 14
    'K' => 13
    'Q' => 12
    'J' => 11
    'T' => 10
  }
  attr_reader :rank, :suite
  def initialize(rank, suite)
    @rank = rank
    @suite = suite
  end

  def int_rank
    @int_rank ||= if @rank.kind_of? String
      STRING_RANKS[@rank] 
    else
      @rank.to_i
    end
  end

  def same_rank?(card)
    card.rank == @rank
  end

  def == (card)
    card.rank == @rank
  end

end
