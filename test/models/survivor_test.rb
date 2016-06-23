require 'test_helper'

class SurvivorTest < ActiveSupport::TestCase
  def setup
    @aanchondo_1 = FactoryGirl.create(:survivor_user_1)
    @jluna_2 = FactoryGirl.create(:survivor_user_2)
    @survivor_game_1 = FactoryGirl.create(:survivor_game_1)
    @survivor_game_1.update(:winner_team => FactoryGirl.create(:mavericks).id, :local_score => 60, :visit_score => 50)
    @jluna_3 = FactoryGirl.create(:survivor_user_3)
    @survivor_game_2 = FactoryGirl.create(:survivor_game_2)
    @survivor_game_2.update(:winner_team => FactoryGirl.create(:mexico).id, :local_score => 3, :visit_score => 2)
    @aanchondo_4 = FactoryGirl.create(:survivor_user_4)
    @jluna_6 = FactoryGirl.create(:survivor_user_6)
    @survivor_game_3 = FactoryGirl.create(:survivor_game_3)
    @survivor_game_3.update(:winner_team => FactoryGirl.create(:chicago).id, :local_score => 56, :visit_score => 52)
    @survivor_game_4 = FactoryGirl.create(:survivor_game_4)
    @survivor_game_4.update(:winner_team => FactoryGirl.create(:brazil).id, :local_score => 5, :visit_score => 3)
    @aanchondo_7 = FactoryGirl.create(:survivor_user_7)
    @jluna_9 = FactoryGirl.create(:survivor_user_9)
    @survivor_game_5 = FactoryGirl.create(:survivor_game_5)
    @survivor_game_5.update(:winner_team => FactoryGirl.create(:rockets).id, :local_score => 70, :visit_score => 50)
    @aanchondo_10 = FactoryGirl.create(:survivor_user_10)
    @jluna_11 = FactoryGirl.create(:survivor_user_11)
    @survivor_game_7 = FactoryGirl.create(:survivor_game_7)
    @survivor_game_7.update(:winner_team => FactoryGirl.create(:nuggets).id, :local_score => 66, :visit_score => 60)
  end

  test "User aanchondo 1 is alive after victory of mavericks" do
    @aanchondo_1.reload
    assert @aanchondo_1.status == "alive", "aanchond 1 isn't alive"
  end

  test "User jluna 2 is loser after victory of mavericks" do
    @jluna_2.reload
    assert @jluna_2.status == "loser", "jluna 2 isn't loser"
  end

  test "User jluna 3 is alive after victory of mexico" do
    @jluna_3.reload
    assert @jluna_3.status == "alive", "jluna 3 isn't alive"
  end

  test "User jluna 6 is winner after victory of brazil" do
    @jluna_6.reload
    assert @jluna_6.status == "winner", "jluna 6 isn't winner"
  end

  test "Survivor last week can close" do
    assert @survivor_game_4.survivor_week_game.can_close?, "Survivor last week can't close"
  end

  test "User Jorge Luna has 1000 DB after closing survivor" do
    @survivor_game_4.survivor_week_game.survivor.close
    @jluna_6.reload
    assert @jluna_6.user.balance == 1000.0, "Jorge Luna hasn't 2000 DB"
  end

  test "User aanchondo 10 is winner after victory of nuggets" do
    @aanchondo_10.reload
    assert @aanchondo_10.status == "winner", "aanchondo 10 isn't winner"
  end

  test "User jluna 11 is winner after victory of nuggets" do
    @jluna_11.reload
    assert @jluna_11.status == "winner", "jluna 11 isn't winner"
  end

  test "User Alfredo Anchondo has 2400 DB after closing survivor" do
    @survivor_game_7.survivor_week_game.survivor.close
    @aanchondo_10.reload
    assert @aanchondo_10.user.balance == 2400.0, "Alfredo Anchondo hasn't 2400 DB"
  end

  test "User Jorge Alberto has 1600 DB after closing survivor" do
    @survivor_game_7.survivor_week_game.survivor.close
    @jluna_11.reload
    assert @jluna_11.user.balance == 1600.0, "Jorge Luna hasn't 1600 DB"
  end
end
