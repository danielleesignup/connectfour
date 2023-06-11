class Game
    attr_accessor :columnA, :columnB, :columnC, :columnD, :columnE, :columnF, :columnG, :player_list, :computer_list,
    :rowA_display, :rowB_display, :rowC_display, :rowD_display, :rowE_display, :rowF_display, :rowG_display, :rows

    attr_reader :row_header

    def initialize
        @columnA = [1, 8, 15, 22, 29, 36]
        @columnB = [2, 9, 16, 23, 30, 37]
        @columnC = [3, 10, 17, 24, 31, 38]
        @columnD = [4, 11, 18, 25, 32, 39]
        @columnE = [5, 12, 19, 26, 33, 40]
        @columnF = [6, 13, 20, 27, 34, 41]
        @columnG = [7, 14, 21, 28, 35, 42]
        @columns = [@columnA, @columnB, @columnC, @columnD, @columnE, @columnF, @columnG]
        @rowA = [1, 2, 3, 4, 5, 6, 7]
        @rowB = [8, 9, 10, 11, 12, 13, 14]
        @rowC = [15, 16, 17, 18, 19, 20, 21]
        @rowD = [22, 23, 24, 25, 26, 27, 28]
        @rowE = [29, 30, 31, 32, 33, 34, 35]
        @rowF = [36, 37, 38, 39, 40, 41, 42]
        @rows = [@rowA, @rowB, @rowC, @rowD, @rowE, @rowF]
        @player_list = []
        @computer_list = []
        @row_header = ['A', 'B', 'C', 'D', 'E', 'F', 'G']
        @rowA_display = ['_', '_', '_', '_', '_', '_', '_']
        @rowB_display = ['_', '_', '_', '_', '_', '_', '_']
        @rowC_display = ['_', '_', '_', '_', '_', '_', '_']
        @rowD_display = ['_', '_', '_', '_', '_', '_', '_']
        @rowE_display = ['_', '_', '_', '_', '_', '_', '_']
        @rowF_display = ['_', '_', '_', 'g', '_', '_', '_']
        @rowG_display = ['_', '_', '_', 'g', '_', '_', '_']
        @rows_display = [@rowA_display, @rowB_display, @rowC_display, @rowD_display, @rowE_display, @rowF_display, @rowG_display]

    end

    def display_welcome
        puts "Welcome to a game of Connect Four!"
        puts "-----------------------------------------------------------------"
        puts "You will be O and the computer will be X."
        puts "When prompted, please enter the column alphabet to drop the disk."
        puts "-----------------------------------------------------------------"
    end

    def display_board
        p @row_header
        p @rowA_display
        p @rowB_display
        p @rowC_display
        p @rowD_display
        p @rowE_display
        p @rowF_display
        p @rowG_display
    end 

    def playerturn
        #ask the player for column to drop the disk 
        choice = get_player_choice
        drop_disk_player(choice)
    end

    def get_player_choice
        puts ""
        puts "Player's Turn!"
        while true do 
            begin
                puts ""
                puts "which column?: "
                choice = gets.chomp.downcase!
                if choice.match?(/^[a-g]$/i) 
                    if column_full?(choice)
                        puts ""
                        puts "That column is full! Choose another"
                        next
                    else
                        break
                    end
                else
                    puts ""
                    puts "Invalid input try again"
                end
            rescue => e
                puts ""
                puts "Invalid input try again"
            end
        end
        choice.downcase
    end

    def column_full?(choice)
        case choice 
        when 'a'
            return @columnA.empty?
        when 'b'
            return @columnB.empty?
        when 'c'
            return @columnC.empty?
        when 'd'
            return @columnD.empty?
        when 'e'
            return @columnE.empty?
        when 'f'
            return @columnF.empty?
        when 'g'
            return @columnG.empty?
        end
    end

    def drop_disk(choice, who)
        case choice 
        when 'a'
            popped = @columnA.pop #change this as well
            @player_list.push(popped)
            next_available_slot = next_available_slot(0) #change num for each cases 
            if who == 'player' 
                abbrev = 'p'
            else
                abbrev = 'c'
            end
            fill_in_slot(@rows_display[next_available_slot], 0, abbrev)
        when 'b'
            popped = @columnB.pop #change this as well
            @player_list.push(popped)
            next_available_slot = next_available_slot(1) #change num for each cases 
            fill_in_slot(@rows_display[next_available_slot], 1, abbrev)
        when 'c'
            popped = @columnC.pop #change this as well
            @player_list.push(popped)
            next_available_slot = next_available_slot(2) #change num for each cases 
            fill_in_slot(@rows_display[next_available_slot], 2, abbrev)
        when 'd'
            popped = @columnD.pop #change this as well
            @player_list.push(popped)
            next_available_slot = next_available_slot(3) #change num for each cases 
            fill_in_slot(@rows_display[next_available_slot], 3, abbrev)
        when 'e'
            popped = @columnE.pop #change this as well
            @player_list.push(popped)
            next_available_slot = next_available_slot(4) #change num for each cases 
            fill_in_slot(@rows_display[next_available_slot], 4, abbrev)
        when 'f'
            popped = @columnF.pop #change this as well
            @player_list.push(popped)
            next_available_slot = next_available_slot(5) #change num for each cases 
            fill_in_slot(@rows_display[next_available_slot], 5, abbrev)
        when 'g'
            popped = @columnG.pop #change this as well
            @player_list.push(popped)
            next_available_slot = next_available_slot(5) #change num for each cases 
            fill_in_slot(@rows_display[next_available_slot], 5, abbrev)
        end
    end

    def next_available_slot(slotnum)
        @rows_display.to_enum.with_index.reverse_each do |row, index|
            if row[slotnum] == '_'
                return index
            end
        end
    end

    def fill_in_slot(rowdisplay, next_available_slot, abbrev)
        if abbrev == 'player'
            rowdisplay[next_available_slot] = 'O'
        elsif abbrev == 'computer'
            rowdisplay[next_available_slot] = 'X'
        else
            puts "WHTATATA"
        end
    end

    def winner?
        if [diagonalA?(player_list), diagonalB?(player_list), vertical?(player_list), horizontal?(player_list)].include?(true)
            return 'player'
        elsif [diagonalA?(computer_list), diagonalB?(computer_list), vertical?(computer_list), horizontal?(computer_list)].include?(true)
            return 'computer'
        else
            return nil
        end
    end

    

    def same_row?(number1, number2)
        @rows.each do |row|
            if row.include?(number1) && row.include?(number2)
                return true
            end
        end
        false  # Numbers not in the same row
    end
    
    def all_same_column?(number1, number2, number3, number4)
        @columns.each do |column|
            if column.include?(number1) && column.include?(number2) && column.include?(number3) && column.include?(number4)
                return true
            end
        end
        false  # Numbers not in the same row
    end

    def all_same_row?(number1, number2, number3, number4)
        @rows.each do |row|
            if row.include?(number1) && row.include?(number2) && row.include?(number3) && row.include?(number4)
                return true
            end
        end
        false  # Numbers not in the same row
    end

    def diagonalA?(list)
        list.each do |num|
            elements_to_check = [num, num + 6, num + 12, num + 18]
            if elements_to_check.all? { |element| list.include?(element) } 
                if same_row?(num, num + 6)
                    return false
                elsif same_row?(num + 6, num + 12)
                    return false
                elsif same_row?(num + 12, num + 18)
                    return false
                elsif same_row?(num + 18, num)
                    return false
                else
                    return true
                end
            end
        end
        false
    end

    def diagonalB?(list)
        list.each do |num|
            elements_to_check = [num, num + 8, num + 16, num + 24]
            if elements_to_check.all? { |element| list.include?(element) } 
                if same_row?(num, num + 6)
                    return false
                elsif same_row?(num + 8, num + 16)
                    return false
                elsif same_row?(num + 16, num + 24)
                    return false
                elsif same_row?(num + 24, num)
                    return false
                else
                    return true
                end
            end
        end
        false
    end

    def horizontal?(list)
        list.each do |num|
            elements_to_check = [num, num + 1, num + 2, num + 3]
            if elements_to_check.all? { |element| list.include?(element) } 
                if all_same_row?(num, num + 1, num + 2, num + 3)
                    return true
                else
                    return false
                end
            end
        end
        false
    end

    def vertical?(list)
        list.each do |num|
            elements_to_check = [num, num + 1, num + 2, num + 3]
            if elements_to_check.all? { |element| list.include?(element) } 
                if all_same_column?(num, num + 1, num + 2, num + 3)
                    return true
                else
                    return false
                end
            end
        end
        false
    end

        



end

newgame = Game.new
# newgame.display_welcome
# newgame.get_player_choice
# p newgame.column_full?('c')
# p newgame.columnC.empty?
# p newgame.rows_display[newgame.next_available_slot(3)]
# p newgame.fill_in_slot(newgame.rowB_display, 2, 'player')
# p newgame.rowB_display
# p newgame.display_board
p newgame.diagonalA?(newgame.player_list)
