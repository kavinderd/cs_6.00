require 'pry'
require 'pry-debugger'

module Scrabble

  class Game
    WORDS_FILE = './assignment_5/words.txt'
    
    VOWELS = %w{a e i o u }
    CONSONANTS = %w{b c d f g h j k l m n q r s t v w x y z}
    SCRABBLE_LETTER_VALUES = {
      'a'=> 1, 'b'=> 3, 'c'=> 3, 'd'=> 2, 'e'=> 1, 'f'=> 4, 'g'=> 2, 'h'=> 4, 'i'=> 1, 'j'=> 8, 'k'=> 5, 'l'=> 1, 'm'=> 3, 'n'=> 1, 'o'=> 1, 'p'=> 3, 'q'=> 10, 'r'=> 1, 's'=> 1, 't'=> 1, 'u'=> 1, 'v'=> 4, 'w'=> 4, 'x'=> 8, 'y'=> 4, 'z'=> 10
    }
    attr_reader :words
    def initialize
      @words = File.readlines(WORDS_FILE).map { |l| l.chomp }
      nil
    end

    def get_word_score(word, max_length)
      points = 0
      word.downcase.each_char do |c|      
        points += SCRABBLE_LETTER_VALUES[c]
      end
      points += 50 if word.length == max_length
      points
    end

    def display_hand(hand)
      output = ""
      hand.each do |k, v|
        v.times do 
          output << k + " " 
        end
      end
      print output.strip
    end

    def deal_hand(n)
      vowels= n/3
      hand = {}
      vowels.times do 
        vowel   = VOWELS.sample
        hand[vowel] = (hand.fetch(vowel) {0}) + 1
      end
      (n-vowels).times do
        cons = CONSONANTS.sample
        hand[cons] = (hand.fetch(cons) { 0 }) + 1
      end
      hand
    end
    
    def update_hand(hand, word)
      result = hand.dup
      word.each_char do |char|
        if result[char] - 1 > 0
          result[char] = result[char] - 1
        else
          result.delete(char)
        end
      end
      result
    end
  
    def is_valid_word(word, hand)
      inclusive = false
      word.each_char do |char|
        inclusive = hand.keys.include?(char)
        break unless inclusive
      end
      inclusive
    end

    def play_hand(hand)
      loop do
        display_hand(hand)
        print "\n"
        input = ""
        loop do
          print "Enter Word: "
          input = gets.chomp
          break if is_valid_word(input, hand)
        end 
        hand = update_hand(hand, input)
        binding.pry
        puts get_word_score(input, 7)
      end
    end

    def vowel_count(hand)
      hand.keys.keep_if { |chr| VOWELS.include?(chr) }.count
    end

  end
end
