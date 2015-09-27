require_relative '../player'

describe Player do
  it "wont fail on bet_request" do
    game_state = {}
    expect(Player.new.bet_request(game_state)).to_not raise_error
  end

end
