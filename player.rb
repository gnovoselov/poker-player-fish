require_relative 'card'
class Player

  attr_reader :me, :game_state

  ALL_IN_BET = 1000500
  DEFAULT_BET = 50
  VERSION = 'Fish 0.1'
  TOP_COMBS = [['A', 'K'], ['A', 'Q'], ['A', 'J'], ['A', 'T'], ['K', 'Q'], ['K', 'J'], ['K', 'T'], ['Q', 'J']]
  GOOD_SUITS = [['T', '9'], ['J', 'T'], ['Q', 'J'], ['Q', 'T'], ['8', '9']]

  def bet_request(game_state)
    puts game_state.to_s
    @game_state = game_state
    @me = me
    return double_max_bet if is_top_comb?
    return double_max_bet if i_have_pair?
    return double_max_bet if has_ace?
    suggested_bet
  rescue StandardError => e
    puts '!!!!!!!!!!!!!!!!!!!!!!!!!!'
    puts e
    ALL_IN_BET
  end

  def showdown(game_state)
  end

  def flop?
    cards_on_deck.size == 3
  end

  def turn?
    cards_on_deck.size == 4
  end

  def river
    cards_on_deck.size == 5
  end

  def cards_on_deck
    @game_state["community_cards"].map { |c| Card.new(c["rank"], c["suit"]) }
  end

  def all_cards
    cards_on_deck + my_cards
  end

  def suggested_bet(blinds = 3)
    max_bet + @game_state["small_blind"] * blinds - max_bet % @game_state["small_blind"]
  end

  def double_max_bet
    max_bet * 2
  end

  def max_bet
    @game_state["players"].max_by{ |player| player["bet"] }["bet"]
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

  def has_ace?
    my_cards.any?{ |card| card.rank == 'A' }
  end

  def active_players_count
    size=0

    first_player = (@game_state["dealer"]+1)%(@game_state["players"].length)
    second_player = (@game_state["dealer"]+2)%(@game_state["players"].length)

    @game_state["players"].each do |player|
      if player["name"]!='Fish' && player["id"]!=first_player && player["id"]!=second_player && player["status"]=='active'
        size+=1
      end
    end

    size
  end

end
