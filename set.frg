#lang forge/bsl "cm" "a6y73n2lxfy9zgai@gmail.com"

// abstract sig Characterestic {}
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

// example validOnlineGame is ValidDeck and GenerateValidSet for {
//     SetCard = `S1 + `S2 + `S3 + `S4 + `S5 + `S6 + `S7 + `S8 + `S9 + `S10 + `S11 + `S12
//     Diamond = `DIAMOND
//     Squiggle = `SQUIGGLE
//     Oval = `OVAL
//     Shape = Diamond + Squiggle + Oval
//     Red = `RED
//     Purple = `PURPLE
//     Green = `GREEN
//     Color = Red + Purple + Green
//     One = `ONE
//     Two = `TWO
//     Three = `THREE
//     Num = One + Two + Three
//     Solid = `SOLID
//     Striped = `STRIPED
//     Outline = `OUTLINE
//     Shading = Solid + Striped + Outline
//     shape = 
//     `S1 -> `DIAMOND +
//     `S2 -> `SQUIGGLE +
//     `S3 -> `SQUIGGLE +
//     `S4 -> `OVAL +
//     `S5 -> `OVAL +
//     `S6 -> `DIAMOND +
//     `S7 -> `DIAMOND +
//     `S8 -> `SQUIGGLE +
//     `S9 -> `DIAMOND +
//     `S10 -> `OVAL +
//     `S11 -> `SQUIGGLE + 
//     `S12 -> `DIAMOND
//     color =
//     `S1 -> `RED +
//     `S2 -> `RED +
//     `S3 -> `GREEN +
//     `S4 -> `RED +
//     `S5 -> `RED +
//     `S6 -> `PURPLE +
//     `S7 -> `GREEN +
//     `S8 -> `PURPLE +
//     `S9 -> `RED +
//     `S10 -> `PURPLE +
//     `S11 -> `PURPLE + 
//     `S12 -> `RED
//     num =
//     `S1 -> `ONE +
//     `S2 -> `THREE +
//     `S3 -> `TWO +
//     `S4 -> `TWO +
//     `S5 -> `THREE +
//     `S6 -> `THREE +
//     `S7 -> `TWO +
//     `S8 -> `TWO +
//     `S9 -> `TWO +
//     `S10 -> `THREE +
//     `S11 -> `ONE + 
//     `S12 -> `ONE
//     shading =
//     `S1 -> `STRIPED +
//     `S2 -> `OUTLINE +
//     `S3 -> `STRIPED +
//     `S4 -> `OUTLINE +
//     `S5 -> `SOLID +
//     `S6 -> `SOLID +
//     `S7 -> `OUTLINE +
//     `S8 -> `OUTLINE +
//     `S9 -> `OUTLINE +
//     `S10 -> `STRIPED +
//     `S11 -> `SOLID + 
//     `S12 -> `OUTLINE
//     Set = `SET1 + `SET2 + `SET3 + `SET4 + `SET5 + `SET6 
//     card1 =
//     `SET1 -> `S1 +
//     `SET2 -> `S1 +
//     `SET3 -> `S1 +
//     `SET4 -> `S2 +
//     `SET5 -> `S2 +
//     `SET6 -> `S4
//     card2 =
//     `SET1 -> `S3 +
//     `SET2 -> `S5 +
//     `SET3 -> `S6 +
//     `SET4 -> `S3 +
//     `SET5 -> `S4 +
//     `SET6 -> `S7
//     card3 =
//     `SET1 -> `S10 +
//     `SET2 -> `S9 +
//     `SET3 -> `S7 +
//     `SET4 -> `S11 +
//     `SET5 -> `S12 +
//     `SET6 -> `S8
// }

// produces a valid deck of cards
run {
    ValidDeck
} for exactly 82 SetCard

// run {
//     ValidDeck
//     GenerateValidSet
// } for exactly 6 Set, exactly 12 SetCard
