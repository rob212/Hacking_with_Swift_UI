import Foundation

// Functions (part one) - video 1


func showWelcome() {
  print("Welcome to my app!")
  print("By default This prints out a conversion")
  print("chart from centimeters to inches, but you")
  print("can also set a custom range if you want.")
}


// Params - named parameters. E.g. with times table function that takes the table as a parameter and the length of multiples to print

func printTimesTables(number: Int, end: Int) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(number: 5, end: 20)

// You MUST pass the parameters in the same order as defined despite being named:

// INVALID
// printTimesTables(end: 20, number: 5)



// -------------------------------------------------------------------------------------------------------------------------
print()

// How to return values from functions - video 2

// Example Apples sqrt() function from Foundation module

let root = sqrt(169)
print(root)

// arrow syntax to show return type

func rollDice() -> Int {
    return Int.random(in: 1...6)
}

let result = rollDice()
print(result)


// example: do two strings contain the same letters, regardless of their order?

func areLettersIdentical(firstWord: String, secondWord: String) -> Bool {
    let sortedFirstWord = firstWord.lowercased().sorted()
    let sortedSecondWord = firstWord.lowercased().sorted()
    return sortedFirstWord == sortedSecondWord
}

print(areLettersIdentical(firstWord: "Cat", secondWord: "tac"))



/*
 Do you remember the Pythagorean theorem from school? It states that if you have a triangle with one right angle inside, you can calculate the length of the hypotenuse by squaring both its other sides, adding them together, then calculating the square root of the result - Both solutions work
 */

func pythagoras(a: Double, b: Double) -> Double {
    return sqrt(((a * a) + (b * b)))
//    return ((a * a) + (b * b)).squareRoot()
}

print(pythagoras(a: 3.0, b: 4.0))


// You can still use return to exit out of the function at any time

func hello() {
    return
}


// -------------------------------------------------------------------------------------------------------------------------
print()

// How to return multiple values from functions - video 3

// If you want to return two or more values from a function, you "could" (but prob don't do this as hard to remember what each index represents) use an array. For example, here’s one that sends back a user’s details:

func getUser() -> [String] {
    ["Taylor", "Swift"]
}

let user = getUser()
print("Name: \(user[0]) \(user[1])")

// The best way to do this in swift is "tuples"

/*
 Like arrays, dictionaries, and sets, tuples let us put multiple pieces of data into a single variable, but unlike those other options tuples have a fixed size and can have a variety of data types.
 */


func getUser2() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}

let user2 = getUser2()
print("Name: \(user2.firstName) \(user2.lastName)")

// So what is the difference between a dictionary and a tuple?:
/*
 - When you access values in a dictionary, Swift can’t know ahead of time whether they are present or not. Yes, we knew that user["firstName"] was going to be there, but Swift can’t be sure and so we need to provide a default value.
 - When you access values in a tuple, Swift does know ahead of time that it is available because the tuple says it will be available.
 - We access values using user.firstName: it’s not a string, so there’s also no chance of typos.
 - Our dictionary might contain hundreds of other values alongside "firstName", but our tuple can’t – we must list all the values it will contain, and as a result it’s guaranteed to contain them all and nothing else.
 */


// There are three other things it’s important to know when using tuples

/*
 First, if you’re returning a tuple from a function, Swift already knows the names you’re giving each item in the tuple, so you don’t need to repeat them when using return. So, this code does the same thing as our previous tuple:
 */

func getUser3() -> (firstName: String, lastName: String) {
    ("Taylor", "Swift")
}

print(getUser3())


/*
 Second, sometimes you’ll find you’re given tuples where the elements don’t have names. When this happens you can access the tuple’s elements using numerical indices starting from 0, like this:
 */

func getUser4() -> (String, String) {
    ("Taylor", "Swift")
}

let user4 = getUser4()
print("Name: \(user4.0) \(user4.1)")


/*
 Finally, if a function returns a tuple you can actually pull the tuple apart into individual values if you want to. Destructuring. You can also underscore where variable isn't needed.

 To understand what I mean by that, first take a look at this code:
 */

func getUser5() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}

let (firstName, lastName) = getUser5()

print("Name: \(firstName) \(lastName)")


// -------------------------------------------------------------------------------------------------------------------------
print()

// How to customise parameter labels - video 4


// function naming is so important in Swift that the parameter names are taken into consideration when uniquely identifying different functions with the same name. The
// below hireEmployee functions are x3 completely seperate functions and aren't overloaded like in other languages

func hireEmployee(name: String) { }
func hireEmployee(title: String) { }
func hireEmployee(location: String) { }


// Sometimes these parameter labels aren't always helpful. E.g. why doesn't the String function "hasPrefix" not got a named parameter?:

let lyric = "I see a red door and I want it painted black"
print(lyric.hasPrefix("I see"))


// We can actually add 2 names for each parameter, one for the caller and one to be used internally in the function to identify the arguement E.g. it would be weird naming the arg to isUppercase() (made up function)

func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}

let string = "HELLO, WORLD"
let result2 = isUppercase(string)

// Instead it would read better as:

func isUppercase2(_ string: String) -> Bool {
    string == string.uppercased()
}

let result3 = isUppercase2(string)
print(result3)


// Example of using an internal name for param in a function to make it read better. We can't use the reserverd word "for" in a function but we can if it is an external param name

func printTimesTables(for number: Int) {
    for i in 1...12 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5)
printTimesTables(for: 2)
