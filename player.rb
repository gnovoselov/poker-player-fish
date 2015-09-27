require_relative 'card'
class Player

  attr_reader :me, :game_state

  ALL_IN_BET = 1000
  DEFAULT_BET = 200
  VERSION = "Default Ruby folding player"
  TOP_COMBS = [['A', 'K'], ['A', 'Q'], ['A', 'J'], ['A', 'T'], ['K', 'Q'], ['K', 'J'], ['K', 'T'], ['Q', 'J']]

  def bet_request(game_state)
    puts game_state.to_s
    @me = me(game_state)
    @game_state = game_state
    return ALL_IN_BET if is_top_comb?
    return ALL_IN_BET if i_have_pair?
    ALL_IN_BET
  rescue StandardError => e
    puts '!!!!!!!!!!!!!!!!!!!!!!!!!!'
    puts e
    DEFAULT_BET
  end

  def showdown(game_state)

  end

  def max_bet_plus_double_blind
    max_bet + blind * 2
  end

  def max_bet

  end

  def blind

  end

  private

  def me
    game_state["players"].find { |p| p['name'] == 'Fish' }
  end

  def my_cards
    @me["hole_cards"].map { |i| Card.new(i["rank"], i["suit"]) }
  end

  def i_have_pair?
    my_cards[0].same_rank? my_cards[1]
  end

  def is_top_comb?
    TOP_COMBS.map(&:sort).include? my_cards.map{ |card| card.rank }.sort
  end

  def same_rank?
    my_cards.map { |card| card.suit }.uniq.size == 1
  end

  def our_position
    game_state[:in_action]
  end

end
