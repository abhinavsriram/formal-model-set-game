function makeShape(shape, color, shading) {
    if (shape == "Diamond") {
        return makeDiamond(color, shading)
    } else if (shape == "Squiggle") {
        return makeSquiggle(color, shading)
    } else if (shape == "Oval") {
        return makeOval(color, shading)
    }
}

function makeDiamond(color, shading) {
    e = document.createElement("div")
    e.style.width = "15px"
    e.style.height = "15px"
    e.style.transform = "rotate(45deg)"
    e.style.border = "thin solid " + color
    e.style.margin = "5px"

    if (shading == "Solid") {
        e.style.backgroundColor = color
    } else if (shading == "Striped") {
        e.style.background = "repeating-linear-gradient(45deg," + color + "," + color + " 5px,white 5px,white 10px)"
    }
    return e
}

function makeOval(color, shading) {
    e = document.createElement("div")
    e.style.width = "15px"
    e.style.height = "20px"
    e.style["border-radius"] = "50%"
    e.style.border = "thin solid " + color
    e.style.margin = "5px"

    if (shading == "Solid") {
        e.style.backgroundColor = color
    } else if (shading == "Striped") {
        e.style.background = "repeating-linear-gradient(45deg," + color + "," + color + " 5px,white 5px,white 10px)"
    }
    return e
}

function makeSquiggle(color, shading) {
    e = document.createElement("div")
    e.style.width = "15px"
    e.style.height = "20px"
    e.style["border-radius"] = "50% 25% 50% 25%"
    e.style.border = "thin solid " + color
    e.style.margin = "5px"

    if (shading == "Solid") {
        e.style.backgroundColor = color
    } else if (shading == "Striped") {
        e.style.background = "repeating-linear-gradient(45deg," + color + "," + color + " 5px,white 5px,white 10px)"
    }
    return e
}

function makeCardDiv() {
    var card = document.createElement("div")
    card.style.width = "80px"
    card.style.height = "50px"
    card.style.border = "thin solid black"
    card.style.display = "flex"
    card.style['align-items'] = "center"
    card.style['justify-content'] = "center"
    card.style.margin = "5px"
    return card
}


function convStrToInNum(n) {
    if (n == "One") {
        return 1
    } else if (n == "Two") {
        return 2
    } else if (n == "Three") {
        return 3
    }
}

function loadCards() {
    const cards = SetCard
    cardsDiv = document.createElement("div")
    cardsDiv.style.display = "flex"
    cardsDiv.style['flex-direction'] = "row"
    cardsDiv.style['flex-wrap'] = "wrap"
    cardsDiv.style.overflow = "scroll"
    cardsDiv.style.width = "370px"
    cardsDiv.style.height = "300px"
    cardsDiv.style.border = "thick solid black"
    cardsDiv.style.margin = "5px"
    // cardsDiv.innerHTML = "<h1> All Cards </h1> <br>"
    for (const ind in cards.tuples()) {
        const card = cards.tuples()[ind]
        cardsDiv.append(makeCard(card))
    }
    div.append(cardsDiv)
}

function makeCard(card) {
    const cardShape = card.join(shape).toString().slice(0,-1)
    const cardColor = card.join(color).toString().slice(0,-1)
    const cardNum = convStrToInNum(card.join(num).toString().slice(0,-1))
    const cardShading = card.join(shading).toString().slice(0,-1)
        
    newCard = makeCardDiv()
    for (let i = 0; i < cardNum; i++) {
        newCard.append(makeShape(cardShape, cardColor, cardShading))
    } 
    return newCard
}

function loadSets() {
    const cards = SetCard
    const sets = SetSet
    setsDiv = document.createElement("div")
    setsDiv.style.display = "flex"
    setsDiv.style['flex-direction'] = "column"
    setsDiv.style.overflow = "scroll"
    setsDiv.style.width = "370px"
    setsDiv.style.height = "300px"
    setsDiv.style.border = "thick solid black"
    setsDiv.style.margin = "5px"
    setsDiv.innerHTML = "<h1> Set Solutions </h1>"
    for (const ind in sets.tuples()) {
        setDiv = document.createElement("div")
        setDiv.style.display = "flex"
        setDiv.style.height = "60px"
        setDiv.style.width = "270px"
        setDiv.style['flex-direction'] = "row"
        setDiv.style.border = "thin solid black"
        setDiv.style.margin = "5px"
        // setDiv.innerHTML = "Set " + ind
        const set = sets.tuples()[ind]
        setDiv.append(makeCard(set.join(card1)))
        setDiv.append(makeCard(set.join(card2)))
        setDiv.append(makeCard(set.join(card3)))
        setsDiv.append(setDiv)
    }
    div.append(setsDiv)
}

div.replaceChildren()
loadCards()
loadSets()