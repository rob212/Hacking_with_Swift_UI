import Foundation

// Default values for function parameters - video 1

func printTimesTables(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5, end: 20)
printTimesTables(for: 8)


// Apple example in Foundations on array removeAll(keepingCapacity: true)
// default is false to not save memory allocated to the array


// -----------------------------------------------------------------------------------------------
print()
// Error handling: Throwing and Catching - video 2

/*
 3 Steps of how you need to handle errors in Swift:
 
    1) Telling Swift about the possible errors that can happen.
    2) Writing a function that can flag up errors if they happen.
    3) Calling that function, and handling any errors that might happen.
 */


// Let’s work through a complete example: if the user asks us to check how strong their password is, we’ll flag up a serious error if the password is too short or is obvious.

// Define our own Error enum that extends Error

enum PasswordError: Error {
    case short, obvious
}

// Note the "throws" keyword but we DON'T have to define the kind of error, just generic
func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }
    
    if password == "password" {
        throw PasswordError.obvious
    }
    
    if password.count < 8 {
        return "OK"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}


/*
 Let’s break that down…

    1. If a function is able to throw errors without handling them itself, you must mark the function as throws before the return type.
    2. We don’t specify exactly what kind of error is thrown by the function, just that it can throw errors.
    3. Being marked with throws does not mean the function must throw errors, only that it might.
    4. When it comes time to throw an error, we write throw followed by one of our PasswordError cases. This immediately exits the function, meaning that it won’t return a string.
    5. If no errors are thrown, the function must behave like normal – it needs to return a string.
 */

// Now how to call that function and handle possible Errors

let myPassword = "cherries3"

do {
    let result = try checkPassword(myPassword)
    print("Password rating: \(result)")
} catch {
    print("Handle errors here \(error.localizedDescription)")
}

// Tip: Most errors thrown by Apple provide a meaningful message that you can present to your user if needed. Swift makes this available using an error value that’s automatically provided inside your catch block, and it’s common to read error.localizedDescription to see exactly what happened.

// You can use "try!" to force the fact you don;t need do or catch. "I think this function is safe to throw without any errors". Use EXTREMELY specifically otherwise you risk a FATAL error i.e. a crash.


// You can look for specific errors if you want to to provide a chance for besoike error messages and behaviour
print()

let myPassword2 = "hi"

do {
    let result = try checkPassword(myPassword2)
    print("Password rating: \(result)")
} catch PasswordError.short {
    print("Please use a longer password.")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error.")
}


// -----------------------------------------------------------------------------------------------
print()
// Summary of Functions - video 3

/*
 We’ve covered a lot about functions in the previous chapters, so let’s recap:

    - Functions let us reuse code easily by carving off chunks of code and giving it a name.
    - All functions start with the word func, followed by the function’s name. The function’s body is contained inside opening and closing braces.
    - We can add parameters to make our functions more flexible – list them out one by one separated by commas: the name of the parameter, then a colon, then the type of the parameter.
    - You can control how those parameter names are used externally, either by using a custom external parameter name or by using an underscore to disable the external name for that parameter.
    - If you think there are certain parameter values you’ll use repeatedly, you can make them have a default value so your function takes less code to write and does the smart thing by default.
    - Functions can return a value if you want, but if you want to return multiple pieces of data from a function you should use a tuple. These hold several named elements, but it’s limited in a way a dictionary is not – you list each element specifically, along with its type.
    - Functions can throw errors: you create an enum defining the errors you want to happen, throw those errors inside the function as needed, then use do, try, and catch to handle them at the call site.
 
 */



// -----------------------------------------------------------------------------------------------
print()
// Checkpoint 4

/*
 The challenge is this:
 
 Write a function that accepts an integer from 1 through 10,000, and returns the integer square root of that number. That sounds easy, but there are some catches:
 
    1. You can’t use Swift’s built-in sqrt() function or similar – you need to find the square root yourself.
    2. If the number is less than 1 or greater than 10,000 you should throw an “out of bounds” error.
    3. You should only consider integer square roots – don’t worry about the square root of 3 being 1.732, for example.
    4. If you can’t find the square root, throw a “no root” error.
 
 */


enum SquareRootError: Error {
    case outOfBounds, noRoot
}


func squareRootof(_ number: Int) throws -> Int {
    // validate the input number
    let range = 1...10000
    if !range.contains(number) {
        throw SquareRootError.outOfBounds
    }
    
    for i in 0...number {
        if i * i == number {
            return i
        }
    }
    
    throw SquareRootError.noRoot
}


for i in 1...25 {
    
    let input = i
    do{
        let answer = try squareRootof(input)
        print("The square root of \(input) is: \(answer)")
    } catch SquareRootError.outOfBounds {
        print("Out of Bounds: please enter a number between 1 and 10,000")
    } catch SquareRootError.noRoot {
        print("There is no square root of: \(input)")
    }
    catch {
        print("Generic Error: \(error.localizedDescription)")
    }
    
}


