require_relative 'card'
class Player

  VERSION = "Default Ruby folding player"

  def bet_request(game_state)
    begin
      @me = me(game_state)
      150
    rescue
      puts game_state.to_s
    end
  end

  def showdown(game_state)

  end

  def me(game_state)
    game_state["players"].find { |p| p.name == 'Fish' }
  rescue
    puts game_state
  end

  def my_cards
    @me["hole_cards"]
  end

end
