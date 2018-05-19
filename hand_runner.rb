require_relative 'card'
require_relative 'hand'

puts "Dealer's Hand: "

card1 = Card.new('Diamonds', 'Jack')
card2 = Card.new('Clubs', 'Ace')

hand = Hand.new
hand.add_card card1
hand.add_card card2

value = hand.get_value
puts value
puts hand

puts "Player's hand:"

card1 = Card.new('Diamonds', 'Jack')
card2 = Card.new('Clubs', 'King')

hand = Hand.new
hand.add_card card1
hand.add_card card2

value = hand.get_value
puts value
puts hand