require_relative 'card'

suit = "Clubs"
rank = "9"

card = Card.new(suit, rank)

puts "Suit of card: #{card.suit}"
puts "Rank of card: #{card.rank}"
puts "Card: #{card}"    #to_s

card.show = false
puts "Card: #{card}"

card.show = true
puts "Card: #{card}"