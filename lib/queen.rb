class Queen < Piece
    def render
      @color == :white ? '♕' : '♛'
    end
  
    def valid_move?(board, from_col, from_row, to_col, to_row)
      from_col_num = board.col_to_num(from_col)
      to_col_num = board.col_to_num(to_col)
  
      return true if (from_col_num == to_col_num && from_row != to_row) || (from_row == to_row && from_col_num != to_col_num)
      return true if (from_row - to_row).abs == (from_col_num - to_col_num).abs
  
      false
    end
end