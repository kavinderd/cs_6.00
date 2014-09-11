require_relative 'scrabble'
require 'minitest/autorun'

class ScrabbleTest < MiniTest::Unit::TestCase
  def test_initialize_game_with_worrds
    g = Scrabble::Game.new
    assert(Hash, g.words.class)
  end

  def test_get_word_score
    g = Scrabble::Game.new
    score =g.get_word_score("rabbit", 7)
    assert_equal(10, score) 
  end

  def test_display_hand
    g = Scrabble::Game.new
    assert_output('a x x l l l e') {g.display_hand({'a'=>1, 'x'=>2,'l'=>3,'e'=>1})}
  end

  def test_deal_hand
    g = Scrabble::Game.new
    hand = g.deal_hand(7)
    assert((7/3).to_i, g.vowel_count(hand))
  end

  def test_update_hand
    g = Scrabble::Game.new
    hand = { 'a'=> 1, "b" => 1, "z"=> 1, "t"=>1, "s"=> 2 }
    word = "bats"
    new_hand = g.update_hand(hand, word)
    assert({'z' => 1, 't' => 1, 's' => 1}, new_hand) 
  end

  def test_is_valid_word
    g = Scrabble::Game.new
    hand = { 'a'=> 1, "b" => 1, "z"=> 1, "t"=>1, "s"=> 2 }
    word = "bats"
    assert(true, g.is_valid_word(word, hand))
  end
  
end
