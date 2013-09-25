class Player
  attr_accessor :symbol

  def initialize(symbol)
    @symbol = symbol
  end

  def move(row, col, board)
    board.set_position(row, col, @symbol)
  end
end

class Computer < Player
  def initialize(symbol)
    super(symbol)
  end

  def calculate_move(board)

    if board.get_position(1, 1) == 'x' && board.corners_empty?
      return [0, 0]
    elsif !board.occupied_at?(1, 1)
      return [1, 1]
    end

    return find_hole('has_pair?', board, @symbol) if find_hole('has_pair?', board, @symbol)
    return find_hole('has_pair?', board, 'x') if find_hole('has_pair?', board, 'x')
    return find_triangulation(board, 'x') if find_triangulation(board, 'x')
    return find_hole('only_one?', board, @symbol)
  end

  def find_hole(method_name, board, symbol)
    board.rows.each_with_index do |row, i|
      return [i, row.index(nil)] if Board.send(method_name, row, symbol)
    end

    board.columns.each_with_index do |column, i|
      return [column.index(nil), i] if Board.send(method_name, column, symbol)
    end

    board.diagonals.each_with_index do |diagonal, i|
      if Board.send(method_name, diagonal, symbol)
        return [diagonal.index(nil), diagonal.index(nil)] if i == 0
        return [diagonal.index(nil), 2 - diagonal.index(nil)]
      end
    end

    nil
  end

  def find_triangulation(board, symbol)
    board.triangles.each do |triangle|
      elements = triangle.collect { |pos| board.get_position(pos[0], pos[1]) }

      if Board.has_pair?(elements, symbol)
        remaining_pos = elements.index(nil)
        return triangle[remaining_pos]
      end
    end

    nil
  end
end
