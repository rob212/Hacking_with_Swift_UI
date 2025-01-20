import Foundation

// Protocols - video 1

// Protocols are equiavalent to interfaces in their purpose, just with more functionality via extensions (to come later)
// They let us define properties and methods a class/struct that conform/adopt to the protocol must implement

protocol Vehicle {
    var name: String { get }
    var currentPassengers: Int { get set }
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

/*
 These methods do not contain any code inside – there are no function bodies provided here. Instead, we’re specifying the method names, parameters, and return types. You can also mark methods as being throwing or mutating if needed.
 
 It also adds two properties:

    1. A string called name, which must be readable. That might mean it’s a constant, but it might also be a computed property with a getter.
    2. An integer called currentPassengers, which must be read-write. That might mean it’s a variable, but it might also be a computed property with a getter and setter.
 
 */

struct Car: Vehicle {
    let name = "Car"
    var currentPassengers = 1
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }

    func openSunroof() {
        print("It's a nice day!")
    }
}

/*
 There are a few things I want to draw particular attention to in that code:

    1. We tell Swift that Car conforms to Vehicle by using a colon after the name Car, just like how we mark subclasses.
    2. All the methods we listed in Vehicle must exist exactly in Car. If they have slightly different names, accept different parameters, have different return types, etc, then Swift will say we haven’t conformed to the protocol.
    3. The methods in Car provide actual implementations of the methods we defined in the protocol. In this case, that means our struct provides a rough estimate for how many minutes it takes to drive a certain distance, and prints a message when travel() is called.
    4. The openSunroof() method doesn’t come from the Vehicle protocol, and doesn’t really make sense there because many vehicle types don’t have a sunroof. But that’s okay, because the protocol describes only the minimum functionality conforming types must have, and they can add their own as needed.
 */


// commute function that makes use of the fact a car implements our protocols methods (this means we can write this for more that just a Car it's any vehicle

func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}


let car = Car()
commute(distance: 100, using: car)


// So now we can see this in action by having another vehicle that adopts the protocol

struct Bicycle: Vehicle {
    let name = "Bicycle"
    var currentPassengers = 1
    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }

    func travel(distance: Int) {
        print("I'm cycling \(distance)km.")
    }
}

let bike = Bicycle()
commute(distance: 50, using: bike)

// further example of using Vehicles in another function and passing an array of different vehicles
func getTravelEstimates(using vehicles: [Vehicle], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)km")
    }
}

getTravelEstimates(using: [car, bike], distance: 150)


/*
 Tip: You can conform to as many protocols as you need, just by listing them one by one separated with a comma. If you ever need to subclass something and conform to a protocol, you should put the parent class name first, then write your protocols afterwards.
 */


// -------------------------------------------------------------------------------------------------------------
print()
// How to use opaque return types - video 2


// Swift provides one really obscure, really complex, but really important feature called opaque return types, which let us remove complexity in our code

func getRandomNumber() -> Int {
    Int.random(in: 1...6)
}

func getRandomBool() -> Bool {
    Bool.random()
}

/*
 So, getRandomNumber() returns a random integer, and getRandomBool() returns a random Boolean.

 Both Int and Bool conform to a common Swift protocol called Equatable, which means “can be compared for equality.” The Equatable protocol is what allows us to use ==, like this:
 */

print(getRandomNumber() == getRandomNumber())

/*
 Because both of these types conform to Equatable, we could try amending our function to return an Equatable value, like this:
 
 */

//
//func getRandomNumber() ->  Equatable {
//    Int.random(in: 1...6)
//}
//
//func getRandomBool() ->  Equatable {
//    Bool.random()
//}

/*
 Think about sending back an Int or a Bool. Yes, both conform to Equatable, but they aren’t interchangeable – we can’t use == to compare an Int and a Bool, because Swift won’t let us regardless of what protocols they conform to.
 */

// print(5 == true)   -> this makes no sense even though both Int and Book confirm to equatable


/*
 This is where opaque return types come in: they let us hide information in our code, but not from the Swift compiler. This means we reserve the right to make our code flexible internally so that we can return different things in the future, but Swift always understands the actual data type being returned and will check it appropriately.

 To upgrade our two functions to opaque return types, add the keyword some before their return type, like this:
 */

func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

// Above, we see this is as getRandomNumbwe() will return "some kind if Equatable" and Swift can infer in the first instance it's Int and in the second its Bool.


/*
 And now we can call getRandomNumber() twice and compare the results using ==. From our perspective we still only have some Equatable data, but Swift knows that behind the scenes they are actually two integers.

 Returning an opaque return type means we still get to focus on the functionality we want to return rather than the specific type, which in turn allows us to change our mind in the future without breaking the rest of our code. For example, getRandomNumber() could switch to using Double.random(in:) and the code would still work great.
 */

// E.g. I could change the first funtion to this, without having to change return type
//func getRandomNumber() -> some Equatable {
//    Double.random(in: 1...6)
//}


//  It’s a subtle distinction, but returning Vehicle means "any sort of Vehicle type but we don't know what", whereas returning some Vehicle means "a specific sort of Vehicle type but we don't want to say which one.”


// -------------------------------------------------------------------------------------------------------------
print()
// How to create and use extensions- video 3

// Extensions let us add functionality to any type, whether we created it or someone else created it – even one of Apple’s own types.

// To demonstrate this, I want to introduce you to a useful method on strings, called trimmingCharacters(in:). This removes certain kinds of characters from the start or end of a
// string, such as alphanumeric letters, decimal digits, or, most commonly, whitespace and new lines.

/*
 Whitespace is the general term of the space character, the tab character, and a variety of other variants on those two. New lines are line breaks in text, which might sound simple but in practice of course there is no single one way of making them, so when we ask to trim new lines it will automatically take care of all the variants for us.

 For example, here’s a string that has whitespace on either side:
 */

var quote = "   The truth is rarely pure and never simple   "

// If we wanted to trim the whitespace and newlines on either side, we could do so like this:

let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)

/*
 The .whitespacesAndNewlines value comes from Apple’s Foundation API, and actually so does trimmingCharacters(in:) – like I said way back at the beginning of this course, Foundation is really packed with useful code!

 Having to call trimmingCharacters(in:) every time is a bit wordy, so let’s write an extension to make it shorter:
 */

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

/*
 Let’s break that down…

    1. We start with the extension keyword, which tells Swift we want to add functionality to an existing type.
    2. Which type? Well, that comes next: we want to add functionality to String.
    3. Now we open a brace, and all the code until the final closing brace is there to be added to strings.
    4. We’re adding a new method called trimmed(), which returns a new string.
    5. Inside there we call the same method as before: trimmingCharacters(in:), sending back its result.
    6. Notice how we can use self here – that automatically refers to the current string. This is possible because we’re currently in a string extension.

 */

print(quote.trimmed())

// That’s saved some typing, but is it that much better than a regular function?

//Well, the truth is that we could have written a function like this:

func trim(_ string: String) -> String {
    string.trimmingCharacters(in: .whitespacesAndNewlines)
}

let trimmed2 = trim(quote)
print(trimmed2)


/*
 That’s less code than using an extension, both in terms of making the function and using it. This kind of function is called a global function, because it’s available everywhere in our project.

 However, the extension has a number of benefits over the global function, including:

    1. When you type quote. Xcode brings up a list of methods on the string, including all the ones we add in extensions. This makes our extra functionality easy to find.
    2. Writing global functions makes your code rather messy – they are hard to organize and hard to keep track of. On the other hand, extensions are naturally grouped by the data type they are extending.
    3. Because your extension methods are a full part of the original type, they get full access to the type’s internal data. That means they can use properties and methods marked with private access control, for example.
 What’s more, extensions make it easier to modify values in place – i.e., to change a value directly, rather than return a new value.

 For example, earlier we wrote a trimmed() method that returns a new string with whitespace and newlines removed, but if we had  wanted to modify the string directly we could add this to the extension instead:
 */


 extension String {
     mutating func trim() {
         self = self.trimmed()
     }
 }
 
 quote.trim()

/*
 Notice how the method has slightly different naming now: when we return a new value we used trimmed(), but when we modified the string directly we used trim(). This is intentional, and is part of Swift’s design guidelines: if you’re returning a new value rather than changing it in place, you should use word endings like ed or ing, like reversed().

 Tip: Previously I introduced you to the sorted() method on arrays. Now you know this rule, you should realize that if you create a variable array you can use sort() on it to sort the array in place rather than returning a new copy.
 */
 
 
/*
 You can also use extensions to add properties to types, but there is one rule: they must only be computed properties, not stored properties. The reason for this is that adding new stored properties would affect the actual size of the data types – if we added a bunch of stored properties to an integer then every integer everywhere would need to take up more space in memory, which would cause all sorts of problems.

 Fortunately, we can still get a lot done using computed properties. For example, one property I like to add to strings is called lines, which breaks the string up into an array of individual lines. This wraps another string method called components(separatedBy:), which breaks the string up into a string array by splitting it on a boundary of our choosing. In this case we’d want that boundary to be new lines, so we’d add this to our string extension:
 */

extension String {
    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
}

let lyrics = """
But I keep cruising
Can't stop, won't stop moving
It's like I got this music in my mind
Saying it's gonna be alright
"""

print(lyrics.lines)
print(lyrics.lines.count)


/*
 Whether they are single lines or complex pieces of functionality, extensions always have the same goal: to make your code easier to write, easier to read, and easier to maintain in the long term.

 Before we’re done, I want to show you one really useful trick when working with extensions.
 */

// Before we’re done, I want to show you one really useful trick when working with extensions. You’ve seen previously how Swift automatically generates a memberwise initializer for structs, like this:

struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
}

let lotr = Book(title: "Lord of the Rings", pageCount: 1178, readingHours: 24)


/*
 If Swift were to keep the memberwise initializer in this instance, it would skip our logic for calculating the approximate reading time.

 However, sometimes you want both – you want the ability to use a custom initializer, but also retain Swift’s automatic memberwise initializer. In this situation it’s worth knowing exactly what Swift is doing: if we implement a custom initializer inside our struct, then Swift disables the automatic memberwise initializer.

 That extra little detail might give you a hint on what’s coming next: if we implement a custom initializer inside an extension, then Swift won’t disable the automatic memberwise initializer. This makes sense if you think about it: if adding a new initializer inside an extension also disabled the default initializer, one small change from us could break all sorts of other Swift code.

 So, if we wanted our Book struct to have the default memberwise initializer as well as our custom initializer, we’d place the custom one in an extension, like this:
 */

    extension Book {
        init(title: String, pageCount: Int) {
            self.title = title
            self.pageCount = pageCount
            self.readingHours = pageCount / 50
        }
    }




// -------------------------------------------------------------------------------------------------------------
print()
// How to create and use protocol extensions- video 4

// Protocols let us define contracts that conforming types must adhere to, and extensions let us add functionality to existing types. But what would happen if we could write extensions on protocols?

/*
 Well, wonder no more because Swift supports exactly this using the aptly named protocol extensions: we can extend a whole protocol to add method implementations, meaning that any types conforming to that protocol get those methods.

 Let’s start with a trivial example. It’s very common to write a condition checking whether an array has any values in, like this:
 */

let guests = ["Mario", "Luigi", "Peach"]

if guests.isEmpty == false {
    print("Guest count: \(guests.count)")
}

//Some people prefer to use the Boolean ! operator, like this:

if !guests.isEmpty {
    print("Guest count: \(guests.count)")
}

// I’m not really a big fan of either of those approaches, because they just don’t read naturally to me “if not some array is empty”?

//We can fix this with a really simple extension for Array, like this:

extension Array {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}


 // Now we can write code that I think is easier to understand:
if guests.isNotEmpty {
    print("Guest count: \(guests.count)")
}

/*
 But we can do better. You see, we just added isNotEmpty to arrays, but what about sets and dictionaries? Sure, we could repeat ourself and copy the code into extensions for those, but there’s a better solution: Array, Set, and Dictionary all conform to a built-in protocol called Collection, through which they get functionality such as contains(), sorted(), reversed(), and more.

 This is important, because Collection is also what requires the isEmpty property to exist. So, if we write an extension on Collection, we can still access isEmpty because it’s required. This means we can change Array to Collection in our code to get this:
 */

extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}

/*
 With that one word change in place, we can now use isNotEmpty on arrays, sets, and dictionaries, as well as any other types that conform to Collection. Believe it or not, that tiny extension exists in thousands of Swift projects because so many other people find it easier to read.

 More importantly, by extending the protocol we’re adding functionality that would otherwise need to be done inside individual structs. This is really powerful, and leads to a technique Apple calls protocol-oriented programming – we can list some required methods in a protocol, then add default implementations of those inside a protocol extension. All conforming types then get to use those default implementations, or provide their own overrides is need to.

 For example, if we had a protocol like this one:
 */

protocol Person {
    var name: String { get }
    func sayHello()
}

// That means all conforming types must add a sayHello() method, but we can also add a default implementation of that as an extension like this:

extension Person {
    func sayHello() {
        print("Hi, I'm \(name)")
    }
}

/* And now conforming types can add their own sayHello() method if they want, but they don’t need to – they can always rely on the one provided inside our protocol extension.
 
 So, we could create an employee without the sayHello() method:
 */

struct Employee: Person {
    let name: String
}

let taylor = Employee(name: "Taylor Swift")
taylor.sayHello()

/*
 Swift uses protocol extensions a lot, but honestly you don’t need to understand them in great detail just yet – you can build fantastic apps without ever using a protocol extension. At this point you know they exist and that’s enough!
 */
