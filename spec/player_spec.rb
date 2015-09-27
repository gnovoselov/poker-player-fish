require_relative '../player'

STATE_HASH = {"tournament_id"=>"55e4be2d4adaaf0003000002", "game_id"=>"5607a67de9958b0003000005", "round"=>8, "players"=>[{"name"=>"Senior and Co", "stack"=>820, "status"=>"folded", "bet"=>40, "version"=>"", "id"=>0}, {"name"=>"node", "stack"=>0, "status"=>"out", "bet"=>0, "version"=>"Preflop stage active", "id"=>1}, {"name"=>"Fish", "stack"=>190, "status"=>"active", "bet"=>150, "hole_cards"=>[{"rank"=>"7", "suit"=>"clubs"}, {"rank"=>"5", "suit"=>"spades"}], "version"=>"Default Ruby folding player", "id"=>2}, {"name"=>"Abuse Or Lose", "stack"=>1830, "status"=>"active", "bet"=>1010, "version"=>"0.1.0", "id"=>3}, {"name"=>"inem", "stack"=>0, "status"=>"out", "bet"=>0, "version"=>"Default Ruby folding player", "id"=>4}, {"name"=>"Mandarine", "stack"=>940, "status"=>"folded", "bet"=>20, "version"=>"Default Ruby folding player", "id"=>5}], "small_blind"=>10, "orbits"=>1, "dealer"=>2, "community_cards"=>[{"rank"=>"4", "suit"=>"hearts"}, {"rank"=>"K", "suit"=>"clubs"}, {"rank"=>"A", "suit"=>"hearts"}], "current_buy_in"=>1010, "pot"=>1220, "in_action"=>2, "minimum_raise"=>860, "bet_index"=>11}

describe Player do
  let(:game_state) { STATE_HASH }

  it "wont fail on bet_request" do
    expect(Player.new.bet_request(game_state)).to_not raise_error
  end

  describe "while in bet" do
    before do
      @player = Player.new
      @player.bet_request(game_state)
    end
    it "i have pair" do
      expect(@player.i_have_pair?).to eq false
    end
    it "out position" do
      expect(@player.our_position).to_not raise_error
    end
    it "cards on deck" do
      expect(@player.cards_on_deck).to be_kind_of Array
    end
    it "calls rainman api", focus: true do
      expect(@player.get_cards_rank).to_not raise_error
    end
  end

end
