require 'yaml'

# Chess game
class ChessGame
  def initialize
    @board = Board.new
    @players = [Player.new(:white), Player.new(:black)]
    @current_player = @players[0]
  end

  def play
    loop do
      display_board
      puts "#{@current_player.color.capitalize}'s turn."
      move = prompt_for_move

      if move == 'save'
        save_game
        puts 'Game saved.'
        next
      end

      break if move == 'quit'

      until @board.valid_move?(move, @current_player.color)
        puts 'Invalid move. Try again.'
        move = prompt_for_move
      end

      break if move == 'quit'

      @board.move_piece(move)
      switch_players
      check_for_checkmate
    end
  end

  private

  def display_board
    puts @board.render
  end

  def prompt_for_move
    print 'Enter your move (e.g., "a2 a4" or "quit"): '
    gets.chomp.downcase
  end

  def save_game
    File.open('save.yml', 'w') { |file| file.write(YAML.dump(self)) }
  end

  def switch_players
    @current_player = @current_player == @players[0] ? @players[1] : @players[0]
  end

  def check_for_checkmate
    if @board.checkmate?(@current_player.color)
      display_board
      puts "Checkmate! #{@current_player == @players[0] ? 'Black' : 'White'} wins!"
      exit
    elsif @board.check?(@current_player.color)
      display_board
      puts 'Check!'
    end
  end
end

