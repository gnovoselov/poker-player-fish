require_relative 'card'
require 'pry'
require 'active_support/all'
require 'cgi'
require 'json'

class Player
  attr_reader :me, :game_state

  ALL_IN_BET = 1000500
  DEFAULT_BET = 50
  VERSION = 'Fish 0.1'
  TOP_COMBS = [['A', 'K'], ['A', 'Q'], ['A', 'J'], ['A', 'T'], ['K', 'Q'], ['K', 'J'], ['K', 'T'], ['Q', 'J']]
  GOOD_SUITS = [['T', '9'], ['J', 'T'], ['Q', 'J'], ['Q', 'T'], ['8', '9']]
  STEAL_BET = 100

  def bet_request(game_state)
    #puts game_state.to_s
    @game_state = game_state
    @me = me
    @rainman_says = get_cards_rank
    puts @rainman_says
    return pre_flop_bets if pre_flop?
    return post_flop_bets if post_flop?
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

  def river?
    cards_on_deck.size == 5
  end

  def post_flop?
    flop? || turn? || river?
  end

  def pre_flop?
    cards_on_deck.size == 0
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

  def all_cards_json
    (@me['hole_cards'] + @game_state['community_cards']).to_json
  end

  def get_cards_rank
    return nil unless all_cards.size < 5
    uri = URI.parse("http://rainman.leanpoker.org/rank")
    JSON.parse(Net::HTTP.post_form(uri, 'cards' => all_cards_json).body)
  end

  def need_steal?
    return false unless pre_flop?

    active_players_count == 0
    my_id = @me['id']
    steal = [my_id, my_id + 1].include? @game_state['dealer'] && active_players_count == 0
    if steal
      puts
      puts "======================================"
      puts "STEALING BLIND #{steal}"
      puts "======================================"
      puts
    end

    steal
  end

  def pre_flop_bets
    return suggested_bet if is_top_comb?
    return suggested_bet if i_have_pair?
    return suggested_bet if has_ace?
    return STEAL_BET if need_steal?
    DEFAULT_BET
  end

  def post_flop_bets
    return suggested_bet if is_top_comb?
    return suggested_bet if i_have_pair?
    return suggested_bet if has_ace?
    return STEAL_BET if need_steal?
    DEFAULT_BET
  end

end
