require 'test_helper'

class SurvivorTest < ActiveSupport::TestCase
  def setup
    @aanchondo_1 = FactoryGirl.create(:survivor_user_1)
    @jluna_2 = FactoryGirl.create(:survivor_user_2)
    @survivor_game_1 = FactoryGirl.create(:survivor_game_1)
    @survivor_game_1.update(:winner_team => FactoryGirl.create(:mavericks).id)
    @jluna_6 = FactoryGirl.create(:survivor_user_6)
    @survivor_game_6 = FactoryGirl.create(:survivor_game_4)
    @survivor_game_6.update(:winner_team => FactoryGirl.create(:brazil).id)
  end

  test "User aanchondo 1 is alive after victory of mavericks" do
    @aanchondo_1.reload
    assert @aanchondo_1.status == "alive"
  end

  test "User jluna 2 is loser after victory of mavericks" do
    @jluna_2.reload
    assert @jluna_2.status == "loser"
  end

  test "User jluna 6 is winner after victory of brazil" do
    @jluna_6.reload
    assert @jluna_6.status == "winner"
  end
end
