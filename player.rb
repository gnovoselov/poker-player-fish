require_relative 'card'
class Player

  VERSION = "Default Ruby folding player"
  TOP_COMBS = [['A', 'K'], ['A', 'Q'], ['A', 'J'], ['A', 'T'], ['K', 'Q'], ['K', 'J'], ['Q', 'J']]

  def bet_request(game_state)
    puts game_state.to_s
    @me = me(game_state)
    return 1000500 if is_top_comb?
    1000
  rescue StandardError => e
    puts e
    150
  end

  def showdown(game_state)

  end

  def me(game_state)
    game_state["players"].find { |p| p.name == 'Fish' }
  end

  def my_cards
    @me["hole_cards"]
  end

  def is_top_comb?
    TOP_COMBS.map(&:sort).include? my_cards.map{ |card| card['rank'] }.sort
  end

end
