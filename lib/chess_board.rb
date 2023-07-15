# Chess board
class Board
    attr_accessor :grid
  
    def initialize
      @grid = create_board
      setup_pieces
    end
  
    def create_board
      Array.new(8) { Array.new(8) }
    end
  
    def setup_pieces
      place_pawns
      place_rooks
      place_knights
      place_bishops
      place_queens
      place_kings
    end
  
    def place_pawns
      @grid[1].map! { |cell| Pawn.new(:black) }
      @grid[6].map! { |cell| Pawn.new(:white) }
    end
  
    def place_rooks
      @grid[0][0], @grid[0][7] = Rook.new(:black), Rook.new(:black)
      @grid[7][0], @grid[7][7] = Rook.new(:white), Rook.new(:white)
    end
  
    def place_knights
      @grid[0][1], @grid[0][6] = Knight.new(:black), Knight.new(:black)
      @grid[7][1], @grid[7][6] = Knight.new(:white), Knight.new(:white)
    end
  
    def place_bishops
      @grid[0][2], @grid[0][5] = Bishop.new(:black), Bishop.new(:black)
      @grid[7][2], @grid[7][5] = Bishop.new(:white), Bishop.new(:white)
    end
  
    def place_queens
      @grid[0][3], @grid[7][3] = Queen.new(:black), Queen.new(:white)
    end
  
    def place_kings
      @grid[0][4], @grid[7][4] = King.new(:black), King.new(:white)
    end
  
    def render
      board_string = ""
      @grid.each_with_index do |row, i|
        row_string = row.map { |piece| piece ? piece.render : ' ' }.join(' | ')
        board_string << "#{8 - i} | #{row_string} |\n"
        board_string << "---------------------------------\n" unless i == 7
      end
      board_string << "   a   b   c   d   e   f   g   h"
    end
  
    def move_piece(move)
      from, to = move.split
      from_col, from_row = from[0], from[1].to_i
      to_col, to_row = to[0], to[1].to_i
  
      piece = @grid[8 - from_row][col_to_num(from_col)]
      @grid[8 - from_row][col_to_num(from_col)] = nil
      @grid[8 - to_row][col_to_num(to_col)] = piece
    end
  
    def valid_move?(move, color)
      from, to = move.split
      from_col, from_row = from[0], from[1].to_i
      to_col, to_row = to[0], to[1].to_i
  
      piece = @grid[8 - from_row][col_to_num(from_col)]
      return false unless piece && piece.color == color
  
      piece.valid_move?(self, from_col, from_row, to_col, to_row)
    end
  
    def check?(color)
      king_position = find_king(color)
      opponent_color = color == :white ? :black : :white
  
      @grid.each_with_index do |row, row_index|
        row.each_with_index do |piece, col_index|
          next unless piece && piece.color == opponent_color
          return true if piece.valid_move?(self, col_to_letter(col_index), 8 - row_index, col_to_letter(king_position[1]), 8 - king_position[0])
        end
      end
  
      false
    end
  
    def checkmate?(color)
      return false unless check?(color)
  
      @grid.each_with_index do |row, row_index|
        row.each_with_index do |piece, col_index|
          next unless piece && piece.color == color
          return false if piece.valid_moves(self, col_to_letter(col_index), 8 - row_index).any?
        end
      end
  
      true
    end
  
    def col_to_num(col)
      col.ord - 97
    end
  
    private
  
    def col_to_letter(col_num)
      (col_num + 97).chr
    end
  
    def find_king(color)
      @grid.each_with_index do |row, row_index|
        row.each_with_index do |piece, col_index|
          return [row_index, col_index] if piece.is_a?(King) && piece.color == color
        end
      end
    end
  end