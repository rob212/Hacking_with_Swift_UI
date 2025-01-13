import Foundation

// Variables - video 1
var greeting = "Hello, playground"

var name = "Ted"
name = "Rebecca"
name = "Keeley"

let character = "Daphne"

var playerName = "Roy"
print(playerName)


let managerName = "Michael Scott"

// --------------------------------------------------------------

// Strings - video 2

let quote = "Then he tapped a sign saying \"Believe\" and walked away."
print(quote)

let multiLineString = """
A day in
the life of an 
Apple engineer
"""
print(multiLineString)

// count of the number of characters
print(quote.count)

// uppercased function
print(quote.uppercased())

// hasPrefix to show if a String starts with something. Be carfeul String s are case sensitive
print(multiLineString.hasPrefix("a day")) // false
print(multiLineString.hasPrefix("A day")) // true

// --------------------------------------------------------------

// Int - video 3

let score = 100
let bigScore = 1_000_000

// Int allows positive and negative WHOLE numbers

// basic operators
let lowerscore = score - 2
var counter = 10
counter += 5
counter *= 2
counter /= 3
counter -= 1
print(counter)

// isMultipleOf function
print(counter.isMultiple(of: 3))


// --------------------------------------------------------------

// Double - video 4

// double position floating point number. Swift allocates double the amount of memory than an Int.
let number = 0.1 + 0.2
print(number)

// Type safety, you can't mix types unless you explicitly cast
let a = 1
let b = 2.0
let c = Double(a) + b
print(c)

var rating = 10
rating *= 2
print(rating)
