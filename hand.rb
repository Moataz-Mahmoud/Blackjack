class Hand
    VALUES = {
        '2': 2,
        '3': 3,
        '4': 4,
        '5': 5,
        '6': 6,
        '7': 7,
        '8': 8,
        '9': 9,
        '10': 10,
        'Jack': 10,
        'Queen': 10,
        'King': 10,
        'Ace': 1
    }

    attr_accessor :dealt_cards

    def initialize
        @dealt_cards = []
    end

    def add_card(card)
        @dealt_cards.push(card)
    end

    def get_value_old_version
        #get rank of cards and put in an array
        card_ranks = []
        dealt_cards.each { |card| card_ranks.push(card.rank)}

        value = 0
        card_ranks.each do |rank|
            rank = rank.to_sym  #convert string to symbol
            value = value + VALUES[rank]  #we will have a hash of values
        end

        value  #returns value
    end

    #compressed version of get_value
    def get_value
        card_ranks = dealt_cards.map { |card| card.rank }

        #reduce function starts from 0.
        #every iteration, acc is set to the result of the previous iteration and does the calculation until the end of the iterations.
        value = card_ranks.reduce(0) { |acc, rank| acc + VALUES[rank.to_sym]}

        #Ace can have value of 11 provided the total hand value is less than 21
        if card_ranks.include?('Ace')
            value += 10 if value + 10 <= 21
        end

        value
    end

    def to_s
        report = ""
        
        dealt_cards.each { |card| report += card.to_s + ", " if card.show}

        if dealt_cards.first.show == false
            first_value = VALUES[dealt_cards.first.rank.to_sym]
            first_value += 10 if dealt_cards.first.rank == 'Ace'
            report + "Total value: " + (get_value - first_value).to_s

        else
            report + "Total value: " + get_value.to_s
        end
    end
end
