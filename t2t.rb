class Game

	attr_accessor :board, :wins

	def initialize(name)
		@@board = []
		@player = Player.new(name)
		@computer = Computer.new
		@@wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
		@victory = false
		@moves = 0
	end

	def make_board
		9.times { @@board << "" }
	end

	def play
		make_board
		while !board_full? && win_or_lose == false
			make_move
			print_board
		end
		puts "Game over."
	end

	def win_or_lose

		@@x_positions = Array.new
		@@o_positions = Array.new

		@@x_positions << @@board.size.times.select {|i| @@board[i] == 'x'}
		@@o_positions << @@board.size.times.select {|i| @@board[i] == 'o'}

		@@wins.each do |win_condition|
			if win_condition.all? { |e| @@x_positions[0].include?(e) }
				puts "Player wins!"
				@victory = true
				return true
			elsif win_condition.all? { |e| @@o_positions[0].include?(e) }
				puts "Computer wins!"
				@victory = true
				return true
			end
		end

		if @victory == false && board_full? == true
			puts "Draw!"
			return true
		end

		return false
	end

	def board_full?
		if @@board.include?("")
			return false
		else
			return true
		end
	end

	def print_board
		puts "#{@@board[0]}" + " | " + "#{@@board[1]}" + " | " + "#{@@board[2]}"
		puts "----------"
		puts "#{@@board[3]}" + " | " + "#{@@board[4]}" + " | " + "#{@@board[5]}"
		puts "----------"
		puts "#{@@board[6]}" + " | " + "#{@@board[7]}" + " | " + "#{@@board[8]}"
	end

	def make_move
		if @moves % 2 == 0 || @moves == 0
			@moves += 1
			puts "Select a position from 0-8 to place your mark."
			player_move = gets.chomp.to_i
			if @@board[player_move] == ""
				@@board[player_move] << "x"
			else
				@moves -= 1
				make_move
			end
		else
			@moves += 1
			open_spaces = []
			@@board.each_with_index do |space, index|
				if space == ""
					open_spaces << index
				end
			end
			computer_move = open_spaces[rand(open_spaces.size)]
			@@board[computer_move] << "o"
		end
	end
end

class Player
	def initialize(name)
		@name = name
	end
end

class Computer
	def initialize
		@sign = "o"
	end
end

ttt = Game.new("Graham")
ttt.play
