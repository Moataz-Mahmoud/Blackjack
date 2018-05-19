require_relative 'blackjack'

RSpec.describe Blackjack do
    SUITS = ['Spades', 'Hearts', 'Clubs', 'Diamonds']
    RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

    before do
        @blackjack = Blackjack.new(SUITS, RANKS)
    end

    describe "instance methods" do
        it "responds to #dealer_hand" do
            expect(@blackjack).to respond_to(:dealer_hand)
        end

        it "responds to #player_hand" do
            expect(@blackjack).to respond_to(:player_hand)
        end

        it "responds to #playing" do
            expect(@blackjack).to respond_to(:playing)
        end

        it "responds to #current_gamer" do
            expect(@blackjack).to respond_to(:current_gamer)
        end

        it "responds to #deck" do
            expect(@blackjack).to respond_to(:deck)
        end

        it "responds to #deal" do
            expect(@blackjack).to respond_to(:deal)
        end

        it "responds to #hit" do
            expect(@blackjack).to respond_to(:hit)
        end

        it "responds to #stand" do
            expect(@blackjack).to respond_to(:stand)
        end

        it "responds to #show_hands" do
            expect(@blackjack).to respond_to(:show_hands)
        end

        it "responds to #set_results" do
            expect(@blackjack).to respond_to(:set_results)
        end

    end

    describe "dealing cards" do
        #deal two cards to dealer, and two cards to player, dealer's first card should be face down
        before do
            @blackjack.deal
            @dealer_cards = @blackjack.dealer_hand.dealt_cards
            @player_cards = @blackjack.player_hand.dealt_cards
        end

        it "returns two cards for the dealer and player" do
            expect(@dealer_cards.count).to eq 2
            expect(@player_cards.count).to eq 2
        end

        it "doesn't display the dealer's first card" do
            expect(@dealer_cards.first.show).to eq false
        end

        it "ends the player's turn if he has a blackjack" do
            card1 = Card.new("Clubs", "10")
            card2 = Card.new("Hearts", "Ace")
            card3 = Card.new("Clubs", "3")

            card4 = Card.new("Diamonds", "10")
            card5 = Card.new("Diamonds", "King")
            card6 = Card.new("Hearts", "Queen")

            @blackjack = Blackjack.new(SUITS, RANKS)

            #creat a new deck and replacing the existing deck of 52 cards our "rigged" deck of only 6 cards and not suffling them, so we can perform tests
            new_deck = [card4, card5, card2, card3, card1, card6]
            @blackjack.deck.replace_with new_deck
            @blackjack.deal
            expect(@blackjack.current_gamer).to eq('Dealer')
        end
    end

    describe "hitting a hand" do

        before do
            @blackjack.deal
            @dealer_cards = @blackjack.dealer_hand.dealt_cards
            @player_cards = @blackjack.player_hand.dealt_cards
        end

        it "can hit if playing is set to true" do
            expect(@blackjack.playing).to eq true
        end

        it "returns 2 cards for dealer but after hit, player will have 3 cards" do
            @blackjack.hit
            expect(@dealer_cards.count).to eq 2
            expect(@player_cards.count).to eq 3
        end

        it "correctly determines if player is busted" do
            #player cards
            card1 = Card.new("Clubs", "10")
            card2 = Card.new("Hearts", "10")
            card3 = Card.new("Diamonds", "2")

            #dealer cards
            card4 = Card.new("Spades", "10")
            card5 = Card.new("Clubs", "10")
            card6 = Card.new("Hearts", "Queen")

            @blackjack = Blackjack.new(SUITS, RANKS)

            #creat a new deck and replacing the existing deck of 52 cards our "rigged" deck of only 6 cards and not suffling them, so we can perform tests
            new_deck = [card6, card3, card2, card5, card1, card4]
            @blackjack.deck.replace_with new_deck
            @blackjack.deal
            @blackjack.hit

            expect(@blackjack.result).to eq('Player busted!')
        end

        it "correctly determines if dealer is busted" do
            #player cards
            card1 = Card.new("Clubs", "10")
            card2 = Card.new("Hearts", "10")
            card3 = Card.new("Diamonds", "Ace")

            #dealer cards
            card4 = Card.new("Spades", "10")
            card5 = Card.new("Clubs", "10")
            card6 = Card.new("Hearts", "Queen")

            @blackjack = Blackjack.new(SUITS, RANKS)

            #creat a new deck and replacing the existing deck of 52 cards our "rigged" deck of only 6 cards and not suffling them, so we can perform tests
            new_deck = [card6, card3, card2, card5, card1, card4]
            @blackjack.deck.replace_with new_deck
            @blackjack.deal
            @blackjack.hit #player stands

            @blackjack.current_gamer = "Dealer"
            @blackjack.hit

            expect(@blackjack.result).to eq('Dealer busted!')
        end
    end

    describe "standing" do
        it "gamer switches to 'Dealer' when 'Player' stands" do
            #player cards
            card1 = Card.new("Clubs", "10")
            card2 = Card.new("Hearts", "10")
            card3 = Card.new("Diamonds", "Ace")

            #dealer cards
            card4 = Card.new("Spades", "10")
            card5 = Card.new("Clubs", "3")
            card6 = Card.new("Hearts", "Queen")

            new_deck = [card6, card3, card2, card5, card1, card4]
            @blackjack.deck.replace_with new_deck
            @blackjack.deal
            @blackjack.hit
            @blackjack.stand

            expect(@blackjack.current_gamer).to eq("Dealer")
        end

        it "'Dealer' automatically hits if hand value < 17 and first card face up" do
            #player cards
            card1 = Card.new("Clubs", "10")
            card2 = Card.new("Hearts", "10")
            card3 = Card.new("Diamonds", "Ace")

            #dealer cards
            card4 = Card.new("Spades", "10")
            card5 = Card.new("Clubs", "3")
            card6 = Card.new("Hearts", "Queen")

            new_deck = [card6, card3, card2, card5, card1, card4]
            @blackjack.deck.replace_with new_deck
            @blackjack.deal
            expect(@blackjack.dealer_hand.get_value).to eq 13

            @blackjack.hit
            @blackjack.stand

            expect(@blackjack.dealer_hand.get_value).to eq 23
            expect(@blackjack.dealer_hand.dealt_cards.first.show).to eq true
        end
    end

    describe "showing hands" do
        before do
            @blackjack = Blackjack.new(SUITS, RANKS)
            @blackjack.deal
        end

        it "displays the gamer hand" do
            expect(@blackjack.show_hands).to match (/Player's hand/)
            expect(@blackjack.show_hands).to match(/Total value:/)

            expect(@blackjack.show_hands).to match (/Dealer's hand/)
            expect(@blackjack.show_hands).to match(/Total value:/)
        end
    end

    describe "settings results" do
        it "sets the correct results when player busts" do
            #player cards
            card1 = Card.new("Clubs", "10")
            card2 = Card.new("Hearts", "10")
            card3 = Card.new("Diamonds", "2")

            #dealer cards
            card4 = Card.new("Spades", "10")
            card5 = Card.new("Clubs", "10")
            card6 = Card.new("Hearts", "Queen")

            @blackjack = Blackjack.new(SUITS, RANKS)

            new_deck = [card6, card3, card2, card5, card1, card4]
            @blackjack.deck.replace_with new_deck
            @blackjack.deal
            @blackjack.hit  #player hits to bust
            expect(@blackjack.set_results).to eq("Player Busted!")
        end

        it "sets the correct result when dealer busts" do
            #player cards
            card1 = Card.new("Clubs", "10")
            card2 = Card.new("Hearts", "10")
            card3 = Card.new("Diamonds", "Ace")

            #dealer cards
            card4 = Card.new("Spades", "10")
            card5 = Card.new("Clubs", "6")
            card6 = Card.new("Hearts", "Queen")

            @blackjack = Blackjack.new(SUITS, RANKS)

            new_deck = [card6, card3, card2, card5, card1, card4]
            @blackjack.deck.replace_with new_deck
            @blackjack.deal
            @blackjack.hit  #player hits to and get 21
            @blackjack.stand   #player stands; it's the dealer's turn
            @blackjack.hit  #dealer hits and busts

            expect(@blackjack.set_results).to eq("Dealer Busted!")
        end

        it "sets the correct results when there is a tie" do
            #player cards
            card1 = Card.new("Clubs", "10")
            card2 = Card.new("Hearts", "10")
            card3 = Card.new("Diamonds", "Ace")

            #dealer cards
            card4 = Card.new("Spades", "10")
            card5 = Card.new("Clubs", "10")
            card6 = Card.new("Hearts", "Ace")

            @blackjack = Blackjack.new(SUITS, RANKS)

            new_deck = [card6, card3, card2, card5, card1, card4]
            @blackjack.deck.replace_with new_deck
            @blackjack.deal
            @blackjack.hit  #player hits and get 21
            @blackjack.stand  #player stands; and it's the dealer's turn now
            @blackjack.hit  #dealer hits and also gets 21. It's a tie!

            expect(@blackjack.set_results).to eq("It's a tie!")
        end 

        it "sets the correct result when player wins" do
            #player cards
            card1 = Card.new("Clubs", "10")
            card2 = Card.new("Hearts", "10")
            card3 = Card.new("Diamonds", "Ace")

            #dealer cards
            card4 = Card.new("Spades", "10")
            card5 = Card.new("Clubs", "9")
            card6 = Card.new("Hearts", "Ace")

            @blackjack = Blackjack.new(SUITS, RANKS)

            new_deck = [card6, card3, card2, card5, card1, card4]
            @blackjack.deck.replace_with new_deck
            @blackjack.deal
            @blackjack.hit  #player hits and get 21
            @blackjack.stand  #player stands; and it's the dealer's turn now
            @blackjack.hit  #dealer hits and also gets 20. Player won!

            expect(@blackjack.set_results).to eq("Player won!")
        end 

        it "sets the correct result when dealer wins" do
            #player cards
            card1 = Card.new("Clubs", "10")
            card2 = Card.new("Hearts", "9")
            card3 = Card.new("Diamonds", "Ace")

            #dealer cards
            card4 = Card.new("Spades", "10")
            card5 = Card.new("Clubs", "King")
            card6 = Card.new("Hearts", "Ace")

            @blackjack = Blackjack.new(SUITS, RANKS)

            new_deck = [card6, card3, card2, card5, card1, card4]
            @blackjack.deck.replace_with new_deck
            @blackjack.deal
            @blackjack.hit  #player hits and get 20
            @blackjack.stand  #player stands; and it's the dealer's turn now
            @blackjack.hit  #dealer hits and also gets 21. Dealer won!

            expect(@blackjack.set_results).to eq("Dealer won!")
        end
    end
end