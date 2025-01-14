import Foundation

// Swift uses type inference, you can explicitly define types

// Type Annotations - video 1

let surname: String = "Lasso"
var score: Double = 0

// array
var albums: [String] = ["Red", "Fearless"]

// dictionary
var user: [String: String] = ["id": "@twostraws"]

// Set
var books: Set<String> = Set(["The Bluest Eye", "Foundation", "Girl, Woman, Other"])


// If you dont want to provide initial values you can can an empty array
var teams: [String] = [String]()
print(teams) // prints []

// You can also use this syntax
var cities: [String] = []

// Note that Hacking with Swift instructor likes to be as explicit as possible with types so favours var teams: [String] = [String]() syntax

// enums type

// remember enums create new types of our own and the values of the enum have the same type as the enum itself

enum UIStyle {
    case light, dark, system
}

var style = UIStyle.light
var specificStyle: UIStyle = .light


// You should prefer to use inference. The most common exception is constants that does not have a value yet and get a value from it passed in later on. Swift ensures it cannot be used until set.


let username: String
// lots of complex logic
username = "rob212"
// more logic
print(username)

// -----------------------------------------------------------------------------------

// Summary of complex data

/*
 - Arrays (most common in iOS dev) let us store lots of values in one place, then read them out using integer indices. Arrays must always be specialized so they contain one specific type, and they have helpful functionality such as count, append(), and contains().
 - Dictionaries also let us store lots of values in one place, but let us read them out using keys we specify. They must be specialized to have one specific type for key and another for the value, and have similar functionality to arrays, such as contains() and count.
 - Sets are a third way of storing lots of values in one place, but we don’t get to choose the order in which they store those items. Sets are really efficient at finding whether they contain a specific item.
 - Enums let us create our own simple types in Swift so that we can specify a range of acceptable values such as a list of actions the user can perform, the types of files we are able to write, or the types of notification to send to the user.
 - Swift must always know the type of data inside a constant or variable, and mostly uses type inference to figure that out based on the data we assign. However, it’s also possible to use type annotation to force a particular type.
 
 
 */


// --------------------------------------------------------------------------------------

// Checkpoint 2

// create an array of strings, and write some code that prints the number of items in the array as well as the number of unique items in the array.

let names = ["Rob", "Susan", "Chiara", "Bill", "George", "Susan", "Sarah", "Billy", "Sarah", "Dave", "George"]

print("The number of items in the names array is: \(names.count)")

let uniqueNames = Set(names)
print(uniqueNames)

print("The number of unique names in the array is: \(uniqueNames.count)")
