# Main program
require_relative './lib/piece.rb'
require_relative './lib/chess_board.rb'
require_relative './lib/pawn.rb'
require_relative './lib/rook.rb'
require_relative './lib/knight.rb'
require_relative './lib/bishop.rb'
require_relative './lib/queen.rb'
require_relative './lib/king.rb'
require_relative './lib/player.rb'
require_relative './lib/chess_game.rb'
game = ChessGame.new
game.play