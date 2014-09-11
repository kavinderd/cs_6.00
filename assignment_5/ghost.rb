class Ghost
  PLAYERS = ["Player 1", "Player 2"]
  WORDS = File.readlines("./assignment_5/words.txt").map { |word| word.chomp }

  def initialize
    @player = PLAYERS.cycle 
  end

  def play
    string = ""
    loop do 
      current_player = @player.next
      print "#{current_player}, enter a letter: "
      input = gets().chomp
      string << input
      puts string
      if WORDS.include?(string.upcase) && string.length > 3
        puts "#{current_player} loses"
        break
      end
    end
    self.play 
  end
end
