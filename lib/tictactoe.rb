require_relative './board'
require_relative './treenode'
require 'debugger'

class Game
	attr_reader :player1, :player2
	attr_accessor :board

	def initialize
		@player1 = Player.new('x')
		@player2 = Computer.new('o')
		@board = Board.new
	end

	def move_valid?(row, col)
		range = (0..2)
		if range.include?(row) && range.include?(col)
			return true if @board.get_position(row, col).nil?
		end
		false
	end

	def play
		players = [@player1, @player2]
		i = 0

		@board.print_state

		until board.has_win?
			player = players[i]

			puts "Player #{i + 1}, make your move:"

			while true
				if player.class == Computer
					comp_position = player.calculate_move(board)
					row, col = comp_position[0], comp_position[1]
					p "row: #{row}", "col #{col}"
				else
					player_move = gets.chomp
					row, col = player_move.scan(/\-?\d+/).map(&:to_i)
				end

				if row.nil? || col.nil?
					puts "Invalid move. Make your move again player #{i + 1}:"
					next
				end

			  break if move_valid?(row, col)
 				puts "Invalid move. Make your move again player #{i + 1}:"
			end

	  	player.move(row, col, @board)

			@board.print_state

			if board.has_win?
				puts "Player #{i + 1} wins!"
				break
			end

			i = 1 - i
		end
	end
end

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
		position = []

		board.rows.each_with_index do |row, i|
			return position = [i, row.index(nil)] if Board.pair_exists?(row, @symbol)
		end
		board.columns.each_with_index do |column, i|
			return position = [column.index(nil), i] if Board.pair_exists?(column, @symbol)
		end

		row = Random.rand(3)
		col = Random.rand(3)
		until !board.occupied_at?(row, col)
			row = Random.rand(3)
			col = Random.rand(3)
		end

		return [row, col]
		# problem with diagonals (just do them pairwise?)
		# nil_index = Computer.pair_exists?(board.diagonals[0])
	end
end

game = Game.new
game.play