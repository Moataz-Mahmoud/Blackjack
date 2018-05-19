# Description
This project is an implementation of the complete TDD course with Ruby on Udemy. The course is teaching you what's TDD (Test Deriven Development) and implement it step by step using Ruby and Rspec.

This project shows you how to play blackjack (as a player) againist the computer (as a dealer). It got separated into many files for the sake of readability. And you can know what each file contains from its name, or simply by going through it reading.

If you are not familiar with Blackjack. Here is a quick guide: 

1. Blackjack will be played between the dealer (computer) and the player (you)

2. There will be a deck of 52 cards. This deck will be shuffled to set up the game

3. The deck is face down so the first card to be dealt from the top of the deck (which is face down) is technically the last card in the deck. This card usually goes to the player, then the next card goes to the dealer which is face down (ie no one gets to see the card or know its value), the next card to the player and the next to the dealer. But this card of the dealer is face up while both the cards of the player is face up (value and rank of both cards are showing)

4. So both player and dealer end up with 2 cards. But the player can only see 1 card of the dealer that is showing while the other card is face down

5. We will change it up a little (because we can) and give the first card to the dealer and the next card to the player and so on 

6. Once the 2 cards each have been dealt, it's the player's turn to act. They can take a card (hit), or they can choose to take no more cards (stand) in which case they close out their turn and it's the dealer's turn to act

7. Player can take more than 1 card (can hit multiple times if they chose) before closing out their turn as can the dealer

Objective: The objective of the game is to get a total value of 21 among the cards dealt (or as close to 21 as possible) WITHOUT going over 21. If the value of the cards in the hand dealt to the player exceed 21, then the player 'busts' and loses the game. If the value of the dealer's hand exceeds 21 and the player had NOT busted when it was their turn to play, then the dealer 'busts' and the player wins the hand

8. Getting a blackjack, i.e. 2 cards that add up to 21, results in an automatic win for the player (unless the dealer also gets a blackjack in which case there is a tie)

9. Jack, Queen, King all carry values of 10. Ace can have value of 1 or 11. All other cards have value that is listed. i.e. 2 has value 2, 3 is worth 3 and so on. So a hand consisting of Jack of Diamonds and an 8 of spades carries a value of 18, a hand consisting of Ace of clubs, 5 of diamonds and 4 of spades (11 + 5 + 4) carries a value of 20

10. So when a player gets any combo of Ace and face card (King, Queen, Jack) or a 10 as their two dealt cards, they automatically win and don't have to act anymore in the hand. This is called Blackjack

11. The dealer has to keep hitting unless the total value of their 2 cards is 17 or above. For example if a dealer has 10 of spades and a 6 of hearts for total value of 16. They are forced to take a card from the deck. In the same scenario a player may choose to 'stand' and not take anymore cards and end their turn

Take a look at some youtube videos for further demos, I found one called "How To Play Blackjack" by gathertogethergames which was pretty good but note this video shows multiple players playing against the dealer, we will only implement a single player playing against the dealer

Notes on our game:

- We are not playing with money (objective is NOT gambling here, objective is to learn how to implement a game)

- Therefore we donot involve bets or payout calculations in our game. It's simply win or lose scenario

- For simplicity we will skip 2 features of blackjack called Splitting and Doubling down. Both of them have money objectives and are therefore not necessary for our game.
