require_relative 'card'
class Player

  attr_reader :me, :game_state

  ALL_IN_BET = 1000500
  DEFAULT_BET = 200
  VERSION = 'Fish 0.1'
  TOP_COMBS = [['A', 'K'], ['A', 'Q'], ['A', 'J'], ['A', 'T'], ['K', 'Q'], ['K', 'J'], ['K', 'T'], ['Q', 'J']]
  GOOD_SUITS = [['T', '9'], ['J', 'T'], ['Q', 'J'], ['Q', 'T'], ['8', '9']]

  def bet_request(game_state)
    puts game_state.to_s
    @game_state = game_state
    @me = me
    return double_max_bet if is_top_comb?
    return double_max_bet if i_have_pair?
    suggested_bet
  rescue StandardError => e
    puts '!!!!!!!!!!!!!!!!!!!!!!!!!!'
    puts e
    ALL_IN_BET
  end

  def showdown(game_state)

  end

  def suggested_bet
    DEFAULT_BET
  end

  def double_max_bet
    max_bet * 2
  end

  def max_bet
    @game_state["players"].max_by { |player| player["bet"] }
  end

  def me
    @game_state["players"].find { |p| p['name'] == 'Fish' }
  end

  def my_cards
    @me["hole_cards"].map { |i| Card.new(i["rank"], i["suit"]) }
  end

  def i_have_pair?
    same_rank?
  end

  def is_top_comb?
    TOP_COMBS.map(&:sort).include? my_cards.map{ |card| card.rank }.sort
  end

  def same_rank?
    my_cards.map { |card| card.rank }.uniq.size == 1
  end

  def our_position
    @game_state[:in_action]
  end

end
