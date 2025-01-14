
import Foundation


// Arrays - video  1

// Ordered data are stored in arrays

var beatles = ["John", "Paul", "George", "Ringo"]
let numbers = [4, 8, 16, 23, 42]
var temperatures = [25.3, 28.2, 26.4]

// adding to the end of an array with append
beatles.append("Rob")
print(beatles)
print(beatles[1])

// arrays are type safe so you cannot add a String to a Double array
//temperatures.append = "cat"


// You can also create an empty array in two ways

var myScores = [Int]()
var highScores = Array<Int>()

myScores.append(123)
print(myScores)


highScores.append(345)
print(highScores)

// add mulitple values at once
highScores.append(contentsOf: [234, 456, 765])
print(highScores)

print(highScores.count)
highScores.remove(at:2)

myScores.removeAll()

// contains
let bondMovies = ["Casino Royale", "Spectre", "No Time To Die"]
print(bondMovies.contains("Frozen"))


// sorting - alphabetical or numerical by default
let cities = ["London", "Tokyo", "Rome", "Budapest"]
print(cities.sorted())


// reversing array
let presidents = ["Bush", "Obama", "Trump", "Biden"]
// it doesn't actually reverse all the contents but remembers whenever you make a call to look from the other end for efficiency
let reversedPresidents = presidents.reversed()
print(reversedPresidents)
print(presidents[0])
print(reversedPresidents.first)

// -----------------------------------------------------------------------------------

// Dictionaries - video 2

// Non ordered, key-value collection

let employee = [
    "name": "Taylor Swift",
    "profession": "Singer",
    "city": "Nashville"
]

// retrieve by keys - note that Swift will return as optionals unless you use the default value
print(employee["name"])
print(employee["status"])

print(employee["name", default: "Unknown"])


print("\(employee["name"]) is a \(employee["profession", default: "unemployed"]).")


// Integer key example

let olympics = [
    2012: "London",
    2016: "Rio de Janeiro",
    2021: "Tokyo"
]

print(olympics[2012, default: "Unknown"])


// You can also create an empty dictionary using whatever explicit types you want to store, then set keys one by one:

var heights = [String: Int]()
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216
heights["LeBron James"] = 206
print(heights["Yao Ming", default: 250])


// Because each dictionary item must exist at one specific key, dictionaries don’t allow duplicate keys to exist. Instead, if you set a value for a key that already exists, Swift will overwrite whatever was the previous value.

var archEnemies = [String: String]()
archEnemies["Batman"] = "The Joker"
archEnemies["Superman"] = "Lex Luthor"

print(archEnemies["Batman"])
archEnemies["Batman"] = "Penguin"

print(archEnemies["Batman"])

//  count and removeAll() both exists for dictionaries, and work just like they do for arrays.


// -----------------------------------------------------------------------------------

// Set - video 3

// Non ordered and they don't allow duplicates. You have to pass an array to a Set.

let people = Set(["Denzel Washington", "Tom Cruise", "Nicolas Cage", "Samuel L Jackson"])
print(people)


// To add values to a Set you need to use .insert() rather than using append() as there is no order remember
var actors = Set<String>()
actors.insert("Denzel Washington")
actors.insert("Tom Cruise")

// Alongside contains(), you’ll also find count to read the number of items in a set, and sorted() to return a sorted array containing the the set’s items.
// Sets are extremely fast as seeking unlike arrays.



// -----------------------------------------------------------------------------------

// enums - video 4

// An enum is a set of named values we can create and use in our code. They are safe an efficient

//  they let us define a new data type with a handful of specific values that it can have. Think of a Boolean, that can only have true or false – you can’t set it to “maybe” or “probably”, because that isn’t in the range of values it understands. Enums are the same: we get to list up front the range of values it can have, and Swift will make sure you never make a mistake using them.


enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
}

var day = Weekday.monday
print(day)
day = Weekday.tuesday


// Swift does two things that make enums a little easier to use. First, when you have many cases in an enum you can just write case once, then separate each case with a comma:

//enum Weekday {
//    case monday, tuesday, wednesday, thursday, friday
//}


// Second, remember that once you assign a value to a variable or constant, its data type becomes fixed – you can’t set a variable to a string at first, then an integer later on. Well, for enums this means you can skip the enum name after the first assignment, like this:

var dayOfWeek: Weekday = .monday
dayOfWeek = .wednesday

print(dayOfWeek)
