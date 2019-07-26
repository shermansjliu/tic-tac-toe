class GameController
    attr_accessor :tie
    def initialize
        @players = []
        @tie = false
    end

    def tie_msg

    end

    def winMsg(sign)
        winningPlayer = ''
        @players.each { |player|
            if player.sign == sign
                winningPlayer = player
                break
            end
        }
        return "#{winningPlayer.name} Wins!"
    end



    def addPlayer(player)
        @players.push(player)
    end

end

class Player
    attr_accessor :name, :sign
    def initialize (name)
        @name  = name
        @sign  = ''
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



    #If no player has won and the board is full, there is a tie
    #If one player has their sign 3 in a row, column, or diagonal
    def win?
        x = ['x' ,'x', 'x']
        o = ['o', 'o', 'o']
        win = false
        sign = ''
        #check row
        @moves.each { |row|
            if row == x or row == o
                win = true
                sign = row[0]
                break
            end
        }

        #check diagonal
        diagArr = []
        i = 0
        3.times {
            diagArr << @moves[i][i]
            i += 1
        }
        if diagArr == x or diagArr == o
            win = true
            sign = diagArr[0]
        end

        #check column
        for row in (0..2)
            column = []
            for col in (0..2)
                column.push(@moves[col][row])
            end
            if column == x or column == o
                win = true
                sign = column[0]
                break
            end
        end

        return [win, sign]
    end

    def addMove(sign)
        x = ''
        y = ''
        loop do
            move = gets
            x, y = @tiles[move.to_i] if @tiles.has_key?(move.to_i)
            if x.is_a?(Integer) and y.is_a?(Integer)
                if tileEmpty?(x, y)
                    @moves[x][y] = sign
                    break
                else
                    puts ("Tile already taken")
                end
            end
        end

    end

    def boardFull?

        for row in @moves
            for tile in row
                if !tile.is_a?(String)
                    return false
                end
            end
        end
        return true

    end
    private
    def tileEmpty?(x, y)
        return @moves[x][y].is_a?(Integer)
    end

end

def displayText(str)
    print "\n"
    str.split("").each {|char|
        print char
        sleep(0.03)
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
    displayText("Is #{playerOne.name} 'x' or 'o'?")
    sign = gets.chomp.downcase
    playerOne.sign = sign
    break if sign == 'x' || sign == 'o'
end

if playerOne.sign == 'x'
    playerTwo.sign = 'o'
else
    playerTwo.sign = 'x'
end

gc.addPlayer(playerOne)
gc.addPlayer(playerTwo)

displayText("#{playerTwo.name} will be #{playerTwo.sign}")

currentPlayer = playerOne
loop do
    sign = ''
    displayText("It's #{currentPlayer.name}'s turn\n")
    print board.display()
    displayText("Enter a number between 1-9 that corresponds to an empty tile \n")
    board.addMove(currentPlayer.sign)

    if currentPlayer == playerOne
        currentPlayer = playerTwo
    else
        currentPlayer = playerOne
    end

    win, sign = board.win?

    if win
        puts gc.winMsg (sign)
        break

    elsif board.boardFull?
        #The board is fulld and everyone has tied
        displayText("You both tie!")
        break

    end

end
