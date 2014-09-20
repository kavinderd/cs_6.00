require 'pry'
require 'pry-debugger'

module Scrabble
  PLAYERS = [:human, :cpu].cycle
  DEFAULT_HAND = 7
  def self.play
    game = Game.new
    scores = Hash.new(0)
    loop do
      puts "#{scores}"
      current_player = PLAYERS.next
      puts "#{current_player}, your turn"
      hand = game.deal_hand(DEFAULT_HAND)
      score = game.play_hand(hand, current_player)
      puts "got #{score}"
      scores[current_player] += score
    end
  end

  class Game
    WORDS_FILE = './assignment_5/words.txt'
    TIME_LIMIT = 16
    VOWELS = %w{a e i o u }
    CONSONANTS = %w{b c d f g h j k l m n q r s t v w x y z}
    SCRABBLE_LETTER_VALUES = {
      'a'=> 1, 'b'=> 3, 'c'=> 3, 'd'=> 2, 'e'=> 1, 'f'=> 4, 'g'=> 2, 'h'=> 4, 'i'=> 1, 'j'=> 8, 'k'=> 5, 'l'=> 1, 'm'=> 3, 'n'=> 1, 'o'=> 1, 'p'=> 3, 'q'=> 10, 'r'=> 1, 's'=> 1, 't'=> 1, 'u'=> 1, 'v'=> 4, 'w'=> 4, 'x'=> 8, 'y'=> 4, 'z'=> 10
    }
    MAX_WORD_LENGTH = 7
    PLAYER_TYPES = [:human, :cpu]
    attr_reader :words, :words_list
    def initialize
      @words = File.readlines(WORDS_FILE).map { |l| l.chomp }
      initialize_word_hash
      get_word_rearrangements(@words)
      binding.pry
      @cpu_time_limit = get_time_limit(1)
    end

    def initialize_word_hash
      @words_list = {}
      @words.each do |word|
        @words_list[word] = get_word_score(word, MAX_WORD_LENGTH)
      end 
    end

    def get_word_score(word, max_length)
      points = 0
      word.downcase.each_char do |c|      
        points += SCRABBLE_LETTER_VALUES[c]
      end
      points += 50 if word.length == max_length
      points
    end

    def get_words_to_points(words)
      points = {}
      words.each do |word|
        points[word] = @words_points.fetch(word) { get_word_score(word, 7) }
      end
      points
    end

    def get_word_rearrangements(words)
      @letter_arrangements = {}
      words.each do |word|
        chars = word.chars.sort { |a,b| a<=>b }.join.downcase
        @letter_arrangements[chars] = word
      end
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

    def hand_to_chars(hand)
      chars =[]
      hand.each do |k, v|
        v.times do 
          chars << k
        end
      end
      chars
    end
  
    def is_valid_word(word, hand)
      word = word.downcase
      chars = hand_to_chars(hand)
      return false unless @words_list[word.upcase] || @words.include?(word.upcase)
      inclusive = false
      word.each_char do |char|
        if chars.empty?
          inclusive = false
          break
        else
          inclusive = chars.include?(char)
          break unless inclusive
          chars.delete_at(chars.index(char))
        end
      end
      inclusive
    end

    def play_hand(hand, player_type= :human)
      @current_player = player_type
      total_time = 0
      score = 0
      loop do
        display_hand(hand)
        print "\n"
        input = ""
        before = 0
        after = 0
        loop do
          before = Time.now
          print "Enter Word: "
          input = @current_player == :human ? gets.chomp : pick_best_word_faster(hand).downcase
          after = Time.now
          total_time += (after-before)
          break if valid_attempt?(input, hand, total_time) || escape?(input) || times_up?(total_time)
          puts "Not a valid word try again"
        end
        break if escape?(input)
        hand = update_hand(hand, input)
        time = after - before
        if within_time?(total_time)
          puts "It took you #{time} to answer"
          play_score = get_word_score(input, 7)
          score += play_score
          puts score
        else
          puts "You're out of time. You took #{total_time} when you only had #{TIME_LIMIT} seconds"
          break
        end
      end
      score
    end

    #PROBLEM 5: Algorithm Analysis
    # There is a tremendous difference between pick_best_word and pick_best_word_faster
    # pick_best_word's efficiency is constantly in terms of the size of word_list
    # regardless of hand size, pick_best_word checks every word in words_list every time
    # That's a constant of around 83k times. So pick_best_words order of growth is 0(word_list)
    #
    # pick_best_word_faster is around 15x faster as its order of growth is in terms of the size of the hand
    # which presently is no larger than 7.  The expensive task in _faster is creating the permutations of hand
    # this at worst is 7! + 6! + 5! ... resulting in ~5912 operations. So _faster's order of growth is 0(n!..n-n!)
    def pick_best_word(hand)
      best_word = ""
      max_points= 0
      @words_list.each do |k, v|
        if is_valid_word(k, hand) && v > max_points
          best_word = k
          max_points = v
        end
      end
      puts "best word is #{best_word} "
      best_word
    end

    def pick_best_word_faster(hand)
      best_word = ""
      max_points = 0
      (hand.length).downto(1) do |i|
        permutations = hand_to_chars(hand).sort { |a,b| a <=> b }.combination(i)
        permutations.each do |perm|
          if word = @letter_arrangements[perm.join]
            if @words_list[word] > max_points
              best_word = word
              max_points = @words_list[word]
            end
          end
        end
      end
      best_word
    end
            
    def get_time_limit(k)
      start_time = Time.now
      @words_list.each do |word, value|
        get_word_score(word, MAX_WORD_LENGTH)
      end
      end_time = Time.now
      return (end_time - start_time) * k
    end

    def valid_attempt?(input, hand, total_time)
      within_time?(total_time) && is_valid_word(input,hand)
    end

    def escape?(input)
      input == '.' || input == ""
    end

    def times_up?(time)
      if @current_player == :human
        TIME_LIMIT - time < 0
      else
        @cpu_time_limit - time < 0
      end
    end

    def within_time?(time)
      !times_up?(time)
    end

    def vowel_count(hand)
      hand.keys.keep_if { |chr| VOWELS.include?(chr) }.count
    end

  end
end

