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

function makeCard() {
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
    for (const ind in cards.tuples()) {
        const card = cards.tuples()[ind]
        const cardShape = card.join(shape).toString().slice(0,-1)
        const cardColor = card.join(color).toString().slice(0,-1)
        const cardNum = convStrToInNum(card.join(num).toString().slice(0,-1))
        const cardShading = card.join(shading).toString().slice(0,-1)
        
        newCard = makeCard()
        for (let i = 0; i < cardNum; i++) {
            newCard.append(makeShape(cardShape, cardColor, cardShading))
        }
        div.append(newCard)
    }
}
div.style.display = "flex"
div.style['flex-direction'] = "row"
div.style['flex-wrap'] = "wrap"
div.style.overflow = "scroll"
div.replaceChildren()
console.log("HELOOOOOOOOOOOO")
loadCards()