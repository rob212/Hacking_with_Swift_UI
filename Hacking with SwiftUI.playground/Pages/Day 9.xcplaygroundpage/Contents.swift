import Foundation


// Closures how to create and use them - video 1


// You can store a copy of a function in variable. Just don't add parenthesis when you do so

func greetUser() {
    print("Hi there!")
}

greetUser()
var greetCopy = greetUser
greetCopy()


// But what if you wanted to skip creating a separate function, and just assign the functionality directly to a constant or variable? Well, it turns out you can do that too:
// I.e. note you aren't declaring a function name at all here. It's effectively the same as above.

let sayHello = {
    print("Howdy!")
}

sayHello()


// If you want the clousure to accept parameters, you need a slightly different syntax. You put the parameter types and return values inside the braces distinguised by the "in" keyword. The
// in keyword defines the boundary between the params , return type and the body of the closure.

let sayHello2 = { (name: String) -> String in
    return "Hi \(name)!"
}

print(sayHello2("Rob"))
// Note we lose the parameter name when we take a copy and use as a closure.


// Functions themselves have a type. They have to as they can be assigned to a variable and Swift is Type Safe. Let's look at an example with the greetUser() function

var greetCopy3: () -> Void = greetUser
greetCopy3()

/*
 Let’s break that down…

    1. The empty parentheses marks a function that takes no parameters.
    2. The arrow means just what it means when creating a function: we’re about to declare the return type for the function.
    3. Void means “nothing” – this function returns nothing. Sometimes you might see this written as (), but we usually avoid that because it can be confused with the empty parameter list.
 
 Every function’s type depends on the data it receives and sends back. That might sound simple, but it hides an important catch: the names of the data it receives are not part of the function’s type.

 We can demonstrate this with some more code:
*/

func getUserData(for id: Int) -> String {
    if id == 1989 {
        return "Taylor Swift"
    } else {
        return "Anonymous"
    }
}

let data: (Int) -> String = getUserData
let user = data(1989)
print(user)

// the getUserData() functions type is: "A function that takes an Integer and returns a String". It has nothing to do with the functions name. It also doesn't include the external param name, when we copy it that is lost.


/*
 
 That uses no parameter name, just like when we copy functions. So, again: external parameter names only matter when we’re calling a function directly, not when we create a closure or when we take a copy of the function first.

 You’re probably still wondering why all this matters, and it’s all about to become clear. Do you remember I said we can use sorted() with an array to have it sort its elements?

 It means we can write code like this:
 */

let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)

/*
 That’s really neat, but what if we wanted to control that sort – what if we always wanted one person to come first because they were the team captain, with the rest being sorted alphabetically?

 Well, sorted() actually allows us to pass in a custom sorting function to control exactly that. This function must accept two strings, and return true if the first string should be sorted before the second, or false if the first string should be sorted after the second.

 If Suzanne were the captain, the function would look like this:
 */
 

// So, if the first name is Suzanne, return true so that name1 is sorted before name2. On the other hand, if name2 is Suzanne, return false so that name1 is sorted after name2. If neither name is Suzanne, just use < to do a normal alphabetical sort.
func captainFirstSorted(name1: String, name2: String) -> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
}


/*
 Like I said, sorted() can be passed a function to create a custom sort order, and as long as that function a) accepts two strings, and b) returns a Boolean, sorted() can use it.

 That’s exactly what our new captainFirstSorted() function does, so we can use it straight away:
 
 */

let captainFirstTeam = team.sorted(by: captainFirstSorted)
print(captainFirstTeam)


// So we can create closures as anonymous functions and stash them in variables
// You've also seen that you can pass other functions into other functions if they have the same type.

/*
 The power of closures is that we can put these two together: sorted() wants a function that will accept two strings and return a Boolean, and it doesn’t care if that function was created formally using func or whether it’s provided using a closure.
 */


let captainFirstTeamClosureExample = team.sorted(by: {(name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
})

print(captainFirstTeamClosureExample)


/*
 But first I want to break down what’s happening there:

    1. We’re calling the sorted() function as before.
    2. Rather than passing in a function, we’re passing a closure – everything from the opening brace after by: down to the closing brace on the last line is part of the closure.
    3. Directly inside the closure we list the two parameters sorted() will pass us, which are two strings. We also say that our closure will return a Boolean, then mark the start of the closure’s code by using in.
    4. Everything else is just normal function code.
 
 */



// -----------------------------------------------------------------------------------------------------
print()


// Trainling closures and shorthand syntax - video 2

// Given the fact Swift is Type Safe and will fail at compile time, types of closures can be inferred so our above captainFirstTeamClosureExample closure can be simplified


let captainFirstTeam2 = team.sorted(by:{ name1, name2 in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
})

// We also get "Trailing closure syntax" meaning we can remove the "(by:" and closing ")" to give us the below. So we can just start the closure without extra typing. This makes the "in" all the more key to distinguish what is the closure signature vs the body of the closure.

let captainFirstTeam3 = team.sorted { name1, name2 in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
}


/*
 There’s one last way Swift can make closures less cluttered: Swift can automatically provide parameter names for us, using shorthand syntax. With this syntax we don’t even write name1, name2 in any more, and instead rely on specially named values that Swift provides for us: $0 and $1, for the first and second strings respectively.

 Using this syntax our code becomes even shorter:
 
 */

let captainFirstTeam4 = team.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }

    return $0 < $1
}

// Some prople hate this syntax as its less clear. Personally TwoStraws wouldn't use it here as each parameter is being used multiple times so not easy to read.

// but would use it if it was simpler:

let reverseTeam = team.sorted { $0 > $1 }


/*
 There are no fixed rules about when to use shorthand syntax and when not to, but in case it’s helpful I use shorthand syntax unless any of the following are true:

    1. The closure’s code is long.
    2. $0 and friends are used more than once each.
    3. You get three or more parameters (e.g. $2, $3, etc).
 If you’re still unconvinced about the power of closures, let’s take a look at two more examples.
 
 */


/*
 First up, the filter() function lets us run some code on every item in the array, and will send back a new array containing every item that returns true for the function. So, we could find all team players whose name begins with T like this:
 */

let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly)


/*
 And second, the map() function lets us transform every item in the array using some code of our choosing, and sends back a new array of all the transformed items:
 */

let upperCaseTeam = team.map { $0.uppercased()}
print(upperCaseTeam)

/*
 
 Tip: When working with map(), the type you return doesn’t have to be the same as the type you started with – you could convert an array of integers to an array of strings, for example.
 
 Like I said, you’re going to be using closures a lot with SwiftUI:
 
    1. When you create a list of data on the screen, SwiftUI will ask you to provide a function that accepts one item from the list and converts it something it can display on-screen.
    2. When you create a button, SwiftUI will ask you to provide one function to execute when the button is pressed, and another to generate the contents of the button – a picture, or some text, and so on.
    3. Even just putting stacking pieces of text vertically is done using a closure.
 Yes, you can create individual functions every time SwiftUI does this, but trust me: you won’t. Closures make this kind of code completely natural, and I think you’ll be amazed at how SwiftUI uses them to produce remarkably simple, clean code.
 
 */



// -----------------------------------------------------------------------------------------------------
print()


// How to accept functions as parameters - video 3

// Here’s a function that generates an array of integers by repeating a function a certain number of times:

func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()

    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }

    return numbers
}


let rolls = makeArray(size: 5) { Int.random(in: 1...10) }
print(rolls)

/*
 Let’s break that down…

    1. The function is called makeArray(). It takes two parameters, one of which is the number of integers we want, and also returns an array of integers.
    2. The second parameter is a function. This accepts no parameters itself, but will return one integer every time it’s called.
    3. Inside makeArray() we create a new empty array of integers, then loop as many times as requested.
    4. Each time the loop goes around we call the generator function that was passed in as a parameter. This will return one new integer, so we put that into the numbers array.
    5. Finally the finished array is returned.
 
 The body of the makeArray() is mostly straightforward: repeatedly call a function to generate an integer, adding each value to an array, then send it all back.

 The complex part is the very first line:
 */



// There’s one last thing before we move on: you can make your function accept multiple function parameters if you want, in which case you can specify multiple trailing closures. The syntax here is very common in SwiftUI, so it’s important to at least show you a taste of it here.

// To demonstrate this here’s a function that accepts three function parameters, each of which accept no parameters and return nothing:

func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done!")
}


doImportantWork() {
    print("a")
} second: {
    print("b")
} third: {
    print("c")
}


/*
 
 Having three trailing closures is not as uncommon as you might expect. For example, making a section of content in SwiftUI is done with three trailing closures: one for the content itself, one for a head to be put above, and one for a footer to be put below.
 */



// -----------------------------------------------------------------------------------------------------
print()


// Summary : Closures

    /*
     
     We’ve covered a lot about closures in the previous chapters, so let’s recap:

     - You can copy functions in Swift, and they work the same as the original except they lose their external parameter names.
     - All functions have types, just like other data types. This includes the parameters they receive along with their return type, which might be Void – also known as “nothing”.
     - You can create closures directly by assigning to a constant or variable.
     - Closures that accept parameters or return a value must declare this inside their braces, followed by the keyword in.
     - Functions are able to accept other functions as parameters. They must declare up front exactly what data those functions must use, and Swift will ensure the rules are followed.
     - In this situation, instead of passing a dedicated function you can also pass a closure – you can make one directly. Swift allows both approaches to work.
     - When passing a closure as a function parameter, you don’t need to explicitly write out the types inside your closure if Swift can figure it out automatically. The same is true for the return value – if Swift can figure it out, you don’t need to specify it.
     - If one or more of a function’s final parameters are functions, you can use trailing closure syntax.
     - You can also use shorthand parameter names such as $0 and $1, but I would recommend doing that only under some conditions.
     - You can make your own functions that accept functions as parameters, although in practice it’s much more important to know how to use them than how to create them.

     */

// -----------------------------------------------------------------------------------------------------
print()


// Checkpoint5: Closures and chaining functional code

/*
 You’ve already met sorted(), filter(), map(), so I’d like you to put them together in a chain – call one, then the other, then the other back to back without using temporary variables.

 Your input is this:
 
 */

let luckyNumbers = [7, 4, 38, 21, 16, 15, 12, 33, 31, 49]

/*
 Your job is to:

    1. Filter out any numbers that are even
    2. Sort the array in ascending order
    3. Map them to strings in the format “7 is a lucky number”
    4. Print the resulting array, one item per line
 
 So, your output should be as follows:
 7 is a lucky number
 15 is a lucky number
 21 is a lucky number
 31 is a lucky number
 33 is a lucky number
 49 is a lucky number
 */



luckyNumbers.filter{ !$0.isMultiple(of:2) }.sorted().map{ "\($0) is a lucky number"}.forEach{ print($0) }
