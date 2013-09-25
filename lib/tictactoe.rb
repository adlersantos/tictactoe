require_relative './board'
require_relative './player'

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

			if board.filled_up?
				puts "It's a draw."
				break
			end

			i = 1 - i
		end
	end
end

game = Game.new
game.play