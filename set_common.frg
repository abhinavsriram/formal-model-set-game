#lang forge/bsl "cm" "a6y73n2lxfy9zgai@gmail.com"

abstract sig Shape {}
one sig Diamond extends Shape {}
one sig Squiggle extends Shape {}
one sig Oval extends Shape {}

abstract sig Color {}
one sig Red extends Color {}
one sig Purple extends Color {}
one sig Green extends Color {}

abstract sig Num {}
one sig One extends Num {}
one sig Two extends Num {}
one sig Three extends Num {}

abstract sig Shading {}
one sig Solid extends Shading {}
one sig Striped extends Shading {}
one sig Outline extends Shading {}

sig SetCard {
    shape: one Shape,
    color: one Color,
    num: one Num,
    shading: one Shading
}

sig SetSet {
    card1: one SetCard,
    card2: one SetCard,
    card3: one SetCard
}

// ensures there are no 2 identical cards, creating a valid deck of 81 cards
// since there are 4 attributes with 3 values each we get 3^4 = 81 unique cards
pred validDeck {
    all disj sc1, sc2: SetCard | {
        sc1.shape != sc2.shape or
        sc1.color != sc2.color or
        sc1.num != sc2.num or
        sc1.shading != sc2.shading
    }
}

// a Set consists of 3 cards in which each of the cards’ features, looked at one‐by‐one, 
// are the same on each card, or, are different on each card.

// all 3 cards have the same shape or different shape
pred validShapes[sc1: SetCard, sc2: SetCard, sc3: SetCard] {
    (sc1.shape = sc2.shape and sc2.shape = sc3.shape and sc1.shape = sc3.shape) or 
    (sc1.shape != sc2.shape and sc2.shape != sc3.shape and sc1.shape != sc3.shape)
}

// all 3 cards have the same color or different color
pred validColors[sc1: SetCard, sc2: SetCard, sc3: SetCard] {
    (sc1.color = sc2.color and sc2.color = sc3.color and sc1.color = sc3.color) or 
    (sc1.color != sc2.color and sc2.color != sc3.color and sc1.color != sc3.color)
}

// all 3 cards have the same number or different number
pred validNums[sc1: SetCard, sc2: SetCard, sc3: SetCard] {
    (sc1.num = sc2.num and sc2.num = sc3.num and sc1.num = sc3.num) or 
    (sc1.num != sc2.num and sc2.num != sc3.num and sc1.num != sc3.num)
}

// all 3 cards have the same shading or different shading
pred validShadings[sc1: SetCard, sc2: SetCard, sc3: SetCard] {
    (sc1.shading = sc2.shading and sc2.shading = sc3.shading and sc1.shading = sc3.shading) or 
    (sc1.shading != sc2.shading and sc2.shading != sc3.shading and sc1.shading != sc3.shading)
}

// all 3 cards have the same or different feature for each features
pred validSet[sc1: SetCard, sc2: SetCard, sc3: SetCard] {
    validShapes[sc1, sc2, sc3] 
    validColors[sc1, sc2, sc3] 
    validNums[sc1, sc2, sc3] 
    validShadings[sc1, sc2, sc3]
}

// ensures all sets are valid
pred generateValidSet {
    all se: SetSet | {
        se.card1 != se.card2 and se.card2 != se.card3 and se.card1 != se.card3 and
        validSet[se.card1, se.card2, se.card3]
    }
}

// validate that there are 3240 sets in a valid deck
// test expect {
//     {
//         validDeck
//         generateValidSet
//     }
//     for exactly 3240 SetSet, exactly 81 SetCard is sat
// }

// validate that there are no more than 3240 sets in a valid deck
// test expect {
//     {
//         validDeck
//         generateValidSet
//     }
//     for exactly 3241 SetSet, exactly 81 SetCard is unsat
// }

// produces a valid deck of cards
// no forced guarantee that there are any sets
// however, by nature of the game, there are 1080 unique sets or 3240 sets in a valid deck
// run {
//     validDeck
//     generateValidSet
// } for exactly 3240 SetSet, exactly 81 SetCard