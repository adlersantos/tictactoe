require_relative 'board'

class Game
	attr_reader :player1, :player2
	attr_accessor :board	

	def initialize
		@player1 = Player.new('x')
		@player2 = Player.new('o')
		@board = Board.new
	end

	def play
		players = [@player1, @player2]
		i = 0

		@board.print_state

		until board.has_win?
			player = players[i]	

			puts "Player #{i + 1}, make your move:"

			# parsing the input and doing the move
			player_move = gets.chomp
			row_num = player_move.split(' ')[0].to_i
			col_num = player_move.split(' ')[1].to_i
			player.move(row_num, col_num, @board)

			@board.print_state

			i = 1 - i
		end
	end
end

class Player
	attr_reader :symbol

	def initialize(symbol)
		@symbol = symbol
	end

	def move(row_num, col_num, board)
		board.set_position(row_num, col_num, @symbol)
	end
end

# class Human < Player

# end

# class Computer < Player	

# end

game = Game.new
game.play