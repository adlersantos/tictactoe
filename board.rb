class Board
	attr_accessor :state

	def initialize
		@state = []

		3.times { @state << [] }
		@state.each do |row|
			3.times { row << nil }
		end
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

	def diagonals
		diagonals = [[], []]
		(0..2).each do |index|
			diagonals[0] << @state[index][index]
			diagonals[1] << @state[index][(1 + index) * -1]
		end

		diagonals
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

	def print_state
		@state.each do |row|
			puts "#{row}"
		end
	end

	def rows
		@state
	end

	def set_position(row_num, col_num, symbol)
		@state[row_num][col_num] = symbol
	end

	def winning_symbol(lines)
		return Board::common_symbol(lines) if Board::has_same_elements?(lines)
	end

  # class methods go below

	def self.has_same_elements?(lines)
		lines.each do |line|
			return true if !line.include?(nil) && line.uniq.count == 1
		end
		false
	end

	def self.common_symbol(set_of_lines)
		set_of_lines.each do |line|
			return line.max if line.max == line.min
		end
		nil
	end
end