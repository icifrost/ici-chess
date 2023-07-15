class Rook < Piece
    def render
      @color == :white ? '♖' : '♜'
    end
  
    def valid_move?(board, from_col, from_row, to_col, to_row)
      return false unless (from_col == to_col && from_row != to_row) || (from_row == to_row && from_col != to_col)
  
      if from_col == to_col
        step = from_row < to_row ? 1 : -1
        (from_row + step).step(to_row - step, step).each do |row|
          return false unless board.grid[8 - row][board.col_to_num(to_col)].nil?
        end
      else
        step = from_col < to_col ? 1 : -1
        (from_col + step).step(to_col - step, step).each do |col|
          return false unless board.grid[8 - to_row][col].nil?
        end
      end
  
      true
    end
end