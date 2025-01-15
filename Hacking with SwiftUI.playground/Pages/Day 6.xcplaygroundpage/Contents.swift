import Foundation

// For loop - video 1

// Swift uses the naming 'for x in collection/string/range'

let platforms = ["iOS", "macOs", "tvOS", "watchOS"]

for os in platforms {
    print("Swift works great on \(os)")
}

// Xcode has a nice autcompletion if you start writing 'for plat...' it autocompletes for you


// String

let word = "animals"

for i in word {
    print(i)
}

// for loop over a range (...) inclusive (..<) exlusive

// pronounced 1 through 12
for i in 1...12 {
   print(i)
}
print()
// pronounced 1 up to 5 - useful for arrays that count from 0 to up n
for i in 1..<5 {
    print("Counting 1 up to 5: \(i)")
}

print("5 times table")
for i in 1...12 {
   print("5 x \(i) is \(5 * i)")
}

print()
// You can do nested loops as with all languages

for i in 1...12 {
    print("The \(i) times table:")
    
    for j in 1...12 {
        print("\(i) * \(j) = \(i * j)")
    }
}



// If you don't need the loop variable, replace it with _ to stop swift complaining you don't use it

var lyric = "Haters gonna"

for _ in 1...5 {
    lyric += " hate"
}

print(lyric)


// --------------------------------------------------------------------------------------------------


// While loop - video 2

// always runs once, and runs until. Less common than for loop.

var countdown = 10

while countdown > 0 {
    print("\(countdown)...")
    countdown -= 1
}
print("Blastoff")


// Very useful when you don't know how many times we will go round. E.g. some random amount using hand rangeed random function. Will example with dice roll game

// nice random logic
let id = Int.random(in: 1...20)

// Dice game - 12 sided dice, keep going until we roll a 20

// create an integer to store our roll
var roll = 0

// carry on looping until we reach 20
while roll != 20 {
    // roll a new dice and print what it was
    roll = Int.random(in: 1...20)
    print("I rolled a \(roll)")
}

// if we're here it means the loop ended – we got a 20!
print("Critical hit!")


// --------------------------------------------------------------------------------------------------


// How to skip loop items with break and continue - video 3


// Swift gives us two ways to skip one or more items in a loop:
//'continue' skips the current loop iteration
// 'break' skips all remaining iterations.

// Continue example to skip non .jpg filenames from loop
let filenames = ["me.jpg", "work.txt", "sophie.jpg", "logo.psd"]

for filename in filenames {
    if filename.hasSuffix(".jpg") == false {
        continue
    }

    print("Found picture: \(filename)")
}


// Break example - calculate 10 common multiples of 2 numbers. stop running once with have the ten, tracked in the multiples array

let number1 = 4
let number2 = 14
var multiples = [Int]()

for i in 1...100_000 {
    if i.isMultiple(of: number1) && i.isMultiple(of: number2) {
        multiples.append(i)

        if multiples.count == 10 {
            break
        }
    }
}

print(multiples)



// --------------------------------------------------------------------------------------------------


// Summary of conditions and loops  - video 4

/*
 - We use if statements to check a condition is true. You can pass in any condition you want, but ultimately it must boil down to a Boolean.
 - If you want, you can add an else block, and/or multiple else if blocks to check other conditions. Swift executes these in order.
 - You can combine conditions using ||, which means that the whole condition is true if either subcondition is true, or &&, which means the whole condition is true if both subconditions are true.
 - If you’re repeating the same kinds of check a lot, you can use a switch statement instead. These must always be exhaustive, which might mean adding a default case.
 - If one of your switch cases uses fallthrough, it means Swift will execute the following case afterwards. This is not used commonly.
 - The ternary conditional operator lets us check WTF: What, True, False. Although it’s a little hard to read at first, you’ll see this used a lot in SwiftUI.
 - for loops let us loop over arrays, sets, dictionaries, and ranges. You can assign items to a loop variable and use it inside the loop, or you can use underscore, _, to ignore the loop variable.
 - while loops let us craft custom loops that will continue running until a condition becomes false.
 - We can skip some or all loop items using continue or break respectively.

 */


// --------------------------------------------------------------------------------------------------
print()
print()

// Checkpoint 3 - Fizzbuzz

// Loop from 1 through 100 and for each number if it's a multiple of 3 print "Fizz", if it's a multiple of 5 print "Buzz". If it's a multiple of 3 and 5 print "FizzBuzz" or print the number

let fizzNumber = 3
let buzzNumber = 5

for i in 1...100 {
    if i.isMultiple(of: fizzNumber) && i.isMultiple(of: buzzNumber) {
        print("FizzBuzz")
    } else if i % fizzNumber == 0 {
        print("Fizz")
    } else if i % buzzNumber == 0 {
        print("Buzz")
    } else {
        print(i)
    }
}
