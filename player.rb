require_relative 'card'
class Player

  ALL_IN_BET = 1000
  DEFAULT_BET = 200
  VERSION = "Default Ruby folding player"
  TOP_COMBS = [['A', 'K'], ['A', 'Q'], ['A', 'J'], ['A', 'T'], ['K', 'Q'], ['K', 'J'], ['Q', 'J']]

  def bet_request(game_state)
    puts game_state.to_s
    @me = me(game_state)
    return ALL_IN_BET if is_top_comb?
    return ALL_IN_BET if i_have_pair?
    DEFAULT_BET
  rescue StandardError => e
    puts '!!!!!!!!!!!!!!!!!!!!!!!!!!'
    puts e
    150
  end

  def showdown(game_state)

  end

  private

  def me(game_state)
    game_state["players"].find { |p| p['name'] == 'Fish' }
  end

  def my_cards
    @me["hole_cards"].map { |i| Card.new(i["rank"], i["suit"]) }
  end

  def i_have_pair?
    my_cards[0].same_rank? my_cards[1]
  end

  def is_top_comb?
    TOP_COMBS.map(&:sort).include? my_cards.map{ |card| card['rank'] }.sort
  end

  def our_position(game_state)
    game_state[:in_action]
  end

end
