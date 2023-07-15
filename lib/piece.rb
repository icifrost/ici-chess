# Chess pieces
class Piece
    attr_reader :color
  
    def initialize(color)
      @color = color
    end
  
    def render
      raise NotImplementedError, 'Method not implemented.'
    end
  
    def valid_move?(_board, _from_col, _from_row, _to_col, _to_row)
      raise NotImplementedError, 'Method not implemented.'
    end
end