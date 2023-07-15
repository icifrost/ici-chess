class Pawn < Piece
    def render
      @color == :white ? '♙' : '♟'
    end
  
    def valid_move?(board, from_col, from_row, to_col, to_row)
      return false unless from_col == to_col
  
      direction = @color == :white ? 1 : -1
      return true if from_row + direction == to_row && board.grid[8 - to_row][board.col_to_num(to_col)].nil?
      return true if from_row + direction * 2 == to_row && from_row == (@color == :white ? 1 : 6) && board.grid[8 - to_row][board.col_to_num(to_col)].nil?
  
      false
    end
end