class King < Piece
    def render
      @color == :white ? '♔' : '♚'
    end
  
    def valid_move?(_board, from_col, from_row, to_col, to_row)
      (from_row - to_row).abs <= 1 && (from_col - to_col).abs <= 1
    end
end