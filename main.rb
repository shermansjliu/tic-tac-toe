class GameController
    attr_accessor :tie
    def initialize
        @players = {}
        @tie = false
    end

    def tie_msg

    end

    def win_msg

    end

    def game_msg
        # TODO: Compelte game msg method which displalys "It's player twos turn forever and ever until someone wins"
    end

    def addPlayer(player)
        @players[player.name] = player
    end
end

class Player
    attr_accessor :name, :move
    def initialize (name)
        @name  = name
        @move  = ''
        @win = false
    end


end

class Board
    attr_accessor :tiles
    def initialize
        @moves = [[1,2,3], [4,5,6], [7,8,9]]
        @tiles = {1=>[0,0], 2=>[0,1], 3=>[0,2], 4=>[1, 0], 5=>[1,1], 6=>[1,2], 7=>[2,0], 8=>[2,1], 9=>[2,2]}
    end


    def display
        result = ''
        @moves.each_with_index { |row, index|

            row.each_with_index {|tile, index|
                if index <= 1
                    result += "#{tile} | "
                else
                    result += "#{tile}"
                end
            }
            if index <= 1
                result += "\n--+---+--- \n"
            else
                result += "\n"
            end
        }

            return result
    end

    def result
        #check row

        #check diagonal

        #check column
    end

    def addMove()
    end


end

def displayText(str)
    str.split("").each {|char|
        print char
        # sleep(0.03)
    }
    print "\n"
end

gc = GameController.new()
board = Board.new()

displayText ("Welcome to tic tac toe!")
displayText ("What is Player 1's name?")
name = gets.chomp
playerOne = Player.new(name)
displayText ("What is Player 2's name?")
playerTwo = Player.new(gets.chomp)

loop do
displayText("Is Player 1 'x' or 'o'?")
sign = gets.chomp.downcase
playerOne.move = sign
break if sign == 'x' || sign == 'o'
end

if playerOne.move == 'x'
    playerTwo.move = 'o'
else
    playerTwo.move = 'x'
end

gc.addPlayer(playerOne)
gc.addPlayer(playerTwo)

displayText("Player 2's sign is #{playerTwo.move}")
displayText("Let the game begin!")

loop do
    print board.display()
    # print board.display()
    # displayText(gc.turn)
    #
    # displayText("Make a move")
    # board.addMove()
    tie = false
    break if tie == false
end
