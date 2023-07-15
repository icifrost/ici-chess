class Bishop < Piece
    def render
      @color == :white ? '♗' : '♝'
    end
  
    def valid_move?(board, from_col, from_row, to_col, to_row)
      from_col_num = board.col_to_num(from_col)
      to_col_num = board.col_to_num(to_col)
  
      return false unless (from_row - to_row).abs == (from_col_num - to_col_num).abs
  
      row_step = from_row < to_row ? 1 : -1
      col_step = from_col_num < to_col_num ? 1 : -1
  
      row = from_row + row_step
      col = from_col_num + col_step
      while row != to_row && col != to_col_num
        return false unless board.grid[8 - row][col].nil?
  
        row += row_step
        col += col_step
      end
  
      true
    end
end