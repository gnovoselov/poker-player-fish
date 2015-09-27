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

  private

  def me(game_state)
    game_state["players"].find { |p| p.name == 'Fish' }
  rescue
    puts game_state
  end

  def my_cards
    @me["hole_cards"].map { |i| Card.new(i["rank"], i["suit"]) }
  end

  def i_have_pair?
    my_cards[0].same_rank? my_cards[1]
  end

end
