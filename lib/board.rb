require_relative './array'

class Board
	attr_accessor :state
	attr_reader :triangles

	def initialize(state=[])
		@state = state

		3.times { @state << [] }
		@state.each do |row|
			3.times { row << nil }
		end

		@triangles = generate_triangles
	end

	def columns
		columns = []
		@state.each do |row|
			row.each_with_index do |el, col_num|
				columns[col_num] ? columns[col_num] << el : columns[col_num] = [el]
			end
		end

		columns
	end

	def corners_empty?
		corners = [[0, 0], [0, 2], [2, 0], [2, 2]]
		corners.all? { |corner| !occupied_at?(corner[0], corner[1]) }
	end

	def diagonals
		diagonals = [[], []]
		(0..2).each do |index|
			diagonals[0] << @state[index][index]
			diagonals[1] << @state[index][-1 - index]
		end

		diagonals
	end

	def filled_up?
		columns.all? { |column| column.all? { |el| el != nil } }
	end

	def get_position(row_num, col_num)
		@state[row_num][col_num]
	end

	def get_winning_symbol
		if self.has_win?
			return winning_symbol(self.columns)
			return winning_symbol(self.rows)
			return winning_symbol(self.diagonals)
		else
			'No winning symbol'
		end
	end

	def has_win?
		return true if Board::has_same_elements?(self.columns)
		return true if Board::has_same_elements?(self.rows)
		return true if Board::has_same_elements?(self.diagonals)
		false
	end

	def occupied_at?(row, col)
		!!get_position(row, col)
	end

	def print_state
			puts "    0    1    2  "
		@state.each_with_index do |row, index|
			puts "#{index} #{row}"
		end
	end

	def rows
		@state
	end

	def set_position(row_num, col_num, symbol)
		@state[row_num][col_num] = symbol
	end

	def squares_top_left
		[[0, 0], [0, 1], [1, 0], [1, 1]]
	end

	def generate_triangles
		triangles = []
		triangles << [[0, 0], [1, 1], [2, 0]]
		triangles << [[0, 0], [1, 1], [0, 2]]
		triangles << [[2, 2], [1, 1], [0, 2]]
		triangles << [[2, 2], [1, 1], [2, 0]]
		squares_top_left.each do |pos|
			triangles << [pos, pos.sum_with(1, 0), pos.sum_with(0, 1)]
			triangles << [pos, pos.sum_with(0, 1), pos.sum_with(1, 1)]
			triangles << [pos, pos.sum_with(1, 0), pos.sum_with(1, 1)]
			triangles << [pos.sum_with(0, 1), pos.sum_with(1, 1), pos.sum_with(1, 0)]
		end

		triangles
	end

	def winning_symbol(lines)
		return Board::common_symbol(lines) if Board::has_same_elements?(lines)
	end

	def self.common_symbol(set_of_lines)
		set_of_lines.each do |line|
			return line.max if line.max == line.min
		end
		nil
	end

	def self.only_one?(line, symbol)
		line.count(symbol) == 1 && line.count(nil) == 2
	end

	def self.has_same_elements?(lines)
		lines.each do |line|
			return true if !line.include?(nil) && line.uniq.count == 1
		end
		false
	end

	def self.has_pair?(arr, symbol)
		arr.count(symbol) == 2 && arr.count(nil) == 1
	end
end