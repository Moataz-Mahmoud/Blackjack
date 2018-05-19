require_relative 'deck'

SUITS = ['Spades', 'Hearts', 'Clubs', 'Diamonds']
RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

deck = Deck.new(SUITS, RANKS)
puts deck.shuffle
puts
puts "Dealt card details:"
card = deck.deal_card
puts card.rank 
puts card.suit 

deck_of_cards = []
deck_of_cards.push(Card.new("Spades", "8"))
deck_of_cards.push(Card.new("Hearts", "8"))
deck_of_cards.push(Card.new("Diamonds", "8"))

deck.replace_with deck_of_cards
puts "New deck of cards:"
puts deck.shuffle