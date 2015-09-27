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
