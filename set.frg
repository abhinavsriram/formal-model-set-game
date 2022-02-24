#lang forge/bsl "cm" "a6y73n2lxfy9zgai@gmail.com"

abstract sig Shape {}
abstract sig Color {}
abstract sig Num {}
abstract sig Shading {}

one sig Diamond extends Shape {}
one sig Squiggle extends Shape {}
one sig Oval extends Shape {}

one sig Red extends Color {}
one sig Purple extends Color {}
one sig Green extends Color {}

one sig One extends Num {}
one sig Two extends Num {}
one sig Three extends Num {}

one sig Solid extends Shading {}
one sig Striped extends Shading {}
one sig Outline extends Shading {}

sig SetCard {
    shape: one Shape,
    color: one Color,
    num: one Num,
    shading: one Shading
}

sig Set {
    card1: one SetCard,
    card2: one SetCard,
    card3: one SetCard
}

pred ValidDeck {
    all disj sc1, sc2: SetCard | {
        sc1.shape != sc2.shape or
        sc1.color != sc2.color or
        sc1.num != sc2.num or
        sc1.shading != sc2.shading
    }
}

pred ValidShapes[s1: SetCard, s2: SetCard, s3: SetCard] {
    (s1.shape = s2.shape and s2.shape = s3.shape and s1.shape = s3.shape) or 
    (s1.shape != s2.shape and s2.shape != s3.shape and s1.shape != s3.shape)
}

pred ValidColors[s1: SetCard, s2: SetCard, s3: SetCard] {
    (s1.color = s2.color and s2.color = s3.color and s1.color = s3.color) or 
    (s1.color != s2.color and s2.color != s3.color and s1.color != s3.color)
}

pred ValidNums[s1: SetCard, s2: SetCard, s3: SetCard] {
    (s1.num = s2.num and s2.num = s3.num and s1.num = s3.num) or 
    (s1.num != s2.num and s2.num != s3.num and s1.num != s3.num)
}

pred ValidShadings[s1: SetCard, s2: SetCard, s3: SetCard] {
    (s1.shading = s2.shading and s2.shading = s3.shading and s1.shading = s3.shading) or 
    (s1.shading != s2.shading and s2.shading != s3.shading and s1.shading != s3.shading)
}

pred ValidSet[s1: SetCard, s2: SetCard, s3: SetCard] {
    ValidShapes[s1, s2, s3] 
    ValidColors[s1, s2, s3] 
    ValidNums[s1, s2, s3] 
    ValidShadings[s1, s2, s3]
}

pred GenerateValidSet {
    all s: Set | {
        s.card1 != s.card2 and s.card2 != s.card3 and s.card1 != s.card3 and
        ValidSet[s.card1, s.card2, s.card3]
    }
}

example validOnlineGame is ValidDeck and GenerateValidSet for {
    SetCard = `CARD1 + `CARD2 + `CARD3 + `CARD4 + `CARD5 + `CARD6 + `CARD7 + `CARD8 + `CARD9 + `CARD10 + `CARD11 + `CARD12
    Diamond = `DIAMOND
    Squiggle = `SQUIGGLE
    Oval = `OVAL
    Shape = Diamond + Squiggle + Oval
    Red = `RED
    Purple = `PURPLE
    Green = `GREEN
    Color = Red + Purple + Green
    One = `ONE
    Two = `TWO
    Three = `THREE
    Num = One + Two + Three
    Solid = `SOLID
    Striped = `STRIPED
    Outline = `OUTLINE
    Shading = Solid + Striped + Outline
    shape = 
    `CARD1 -> `DIAMOND +
    `CARD2 -> `SQUIGGLE +
    `CARD3 -> `SQUIGGLE +
    `CARD4 -> `OVAL +
    `CARD5 -> `DIAMOND +
    `CARD6 -> `DIAMOND +
    `CARD7 -> `DIAMOND +
    `CARD8 -> `SQUIGGLE +
    `CARD9 -> `DIAMOND +
    `CARD10 -> `OVAL +
    `CARD11 -> `SQUIGGLE + 
    `CARD12 -> `DIAMOND
    color =
    `CARD1 -> `RED +
    `CARD2 -> `RED +
    `CARD3 -> `GREEN +
    `CARD4 -> `RED +
    `CARD5 -> `RED +
    `CARD6 -> `PURPLE +
    `CARD7 -> `GREEN +
    `CARD8 -> `PURPLE +
    `CARD9 -> `RED +
    `CARD10 -> `PURPLE +
    `CARD11 -> `PURPLE + 
    `CARD12 -> `RED
    num =
    `CARD1 -> `ONE +
    `CARD2 -> `THREE +
    `CARD3 -> `TWO +
    `CARD4 -> `TWO +
    `CARD5 -> `THREE +
    `CARD6 -> `THREE +
    `CARD7 -> `TWO +
    `CARD8 -> `TWO +
    `CARD9 -> `TWO +
    `CARD10 -> `THREE +
    `CARD11 -> `ONE + 
    `CARD12 -> `ONE
    shading =
    `CARD1 -> `STRIPED +
    `CARD2 -> `OUTLINE +
    `CARD3 -> `STRIPED +
    `CARD4 -> `OUTLINE +
    `CARD5 -> `SOLID +
    `CARD6 -> `SOLID +
    `CARD7 -> `OUTLINE +
    `CARD8 -> `OUTLINE +
    `CARD9 -> `OUTLINE +
    `CARD10 -> `STRIPED +
    `CARD11 -> `SOLID + 
    `CARD12 -> `OUTLINE
    Set = `SET1 + `SET2 + `SET3 + `SET4 + `SET5 + `SET6 
    card1 =
    `SET1 -> `CARD1 +
    `SET2 -> `CARD1 +
    `SET3 -> `CARD1 +
    `SET4 -> `CARD2 +
    `SET5 -> `CARD2 +
    `SET6 -> `CARD4
    card2 =
    `SET1 -> `CARD3 +
    `SET2 -> `CARD5 +
    `SET3 -> `CARD6 +
    `SET4 -> `CARD3 +
    `SET5 -> `CARD4 +
    `SET6 -> `CARD7
    card3 =
    `SET1 -> `CARD10 +
    `SET2 -> `CARD9 +
    `SET3 -> `CARD7 +
    `SET4 -> `CARD11 +
    `SET5 -> `CARD12 +
    `SET6 -> `CARD8
}

// produces a valid deck of cards
// run {
//     ValidDeck
// } for exactly 0 Set, exactly 81 SetCard

// produces a valid deck for online version of set
// run {
//     ValidDeck
//     GenerateValidSet
// } for exactly 6 Set, exactly 12 SetCard
