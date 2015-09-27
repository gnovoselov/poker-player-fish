require_relative 'card'
class Player

  VERSION = "Default Ruby folding player"

  def bet_request(game_state)
    puts game_state.to_s
    @me = me(game_state)
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

end
