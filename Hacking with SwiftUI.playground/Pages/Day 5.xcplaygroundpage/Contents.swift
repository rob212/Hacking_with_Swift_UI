import Foundation

// Conditions true or false - video 1

/*
    if someCondition {
        print("Do something")
    }
*/

let score = 85

if score > 80 {
    print("Great job!")
}


// String ordering alphabetically can be done with a comparison operator,

let ourName = "Dave Lister"
let friendName = "Arnold Rimmer"

if ourName < friendName {
    print("It's \(ourName) before \(friendName)")
} else {
    print("It's \(friendName) before \(ourName)")
}


// isEmpty() great for checking strings, arrays, dictionaries and sets.
// far more efficient that checking string.count == 0 as theat has to count all the characters in the string first

// Create the username variable
var username = "taylorswift13"


// If `username` contains an empty string
/*
    if username == "" {
        // Make it equal to "Anonymous"
        username = "Anonymous"
}

    if username.count == 0 {
        username = "Anonymous"
    }
 */

// most efficient
if username.isEmpty {
    username = "Anonymous"
}

// Now print a welcome message
print("Welcome, \(username)!")


// ----------------------------------------------------------------------------------------------

// How to check multiple conditions - video 2

// to avoid having this nested mess:

let temp = 25

if temp > 20 {
    if temp < 30 {
        print("It's a nice day.")
    }
}

// you can instead use logical operators, such as &&, ||

if temp > 20 && temp < 30 {
    print("It's a nice day.")
}

// Or examples ||
let userAge = 14
let hasParentalConsent = true

if userAge >= 18 || hasParentalConsent {
    print("You can buy the game")
}


// A bigger example of if else and logical operators with an enum

enum TransportOption {
    case airplane, helicopter, bicycle, car, scooter
}

let transport = TransportOption.helicopter

if transport == .airplane || transport == .helicopter {
    print("let's fly")
} else if transport == .bicycle {
    print("I hope there's a bike path")
} else if transport == .car {
    print("Time to get stuck in traffic")
} else {
    print("I'm going to hire a scooter now!")
}


// ----------------------------------------------------------------------------------------------

// Switch statements - video 3

// baseline example with a lot of if else conditions

enum Weather {
    case sun, rain, wind, snow, unknown
}

let forecast = Weather.snow

if forecast == .sun {
    print("It should be a nice day.")
} else if forecast == .rain {
    print("Pack an umbrella.")
} else if forecast == .wind {
    print("Wear something warm")
} else if forecast == .snow {
    print("School is cancelled.")
} else {
    print("Our forecast generator is broken!")
}


// this can be replaced with a switch. They must be exhaustive, no breaks required and has the ability to have a default
// Remember that swift checks cases in order, so the first one it matches it will stop at that point.


switch forecast {
case .sun:
    print("It should be a nice day.")
case .rain:
    print("Pack an umbrella")
case .wind:
    print("Wear something warm")
case .snow:
    print("School is cancelled.")
default:
    print("Our forecast generator is broken!")
}


// You are able to add a 'fallthrough' if you want the switch to continue through executing subsequent cases. Not commonly used but possible to match other switch statments in Java or C etc

let day = 5
print("My true love gave to me…")

switch day {
case 5:
    print("5 golden rings")
    fallthrough
case 4:
    print("4 calling birds")
    fallthrough
case 3:
    print("3 French hens")
    fallthrough
case 2:
    print("2 turtle doves")
    fallthrough
default:
    print("A partridge in a pear tree")
}



// switch can work for enums, int, string, double etc

let place = "Metropolis"

switch place {
case "Gotham":
    print("You're Batman!")
case "Mega-City One":
    print("You're Judge Dredd!")
case "Wakanda":
    print("You're Black Panther!")
default:
    print("Who are you?")
}


// ----------------------------------------------------------------------------------------------

// Ternary conditional operator - video 4


// more short hand way to check conditions in Swift - The ternary consitional operator
// standard stuff, if true use value aftetr ? =, if false use that after :

let age = 18
let canVote = age >= 18 ? "Yes" : "No"
print("Can vote: \(canVote)")


let hour = 23
print(hour < 12 ? "It's before noon" : "It's after noon")


let names = ["Jayne", "Kaylee", "Mal"]
let crewCount = names.isEmpty ? "No one" : "\(names.count) people"
print(crewCount)
