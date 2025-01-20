import Foundation

// Optionals Summary:

/*
 
 In these chapters we’ve covered one of Swift’s most important features, and although most people find optionals hard to understand at first almost everyone agrees they are useful in practice.

 Let’s recap what we learned:

    - Optionals let us represent the absence of data, which means we’re able to say “this integer has no value” – that’s different from a fixed number such as 0.
    - As a result, everything that isn’t optional definitely has a value inside, even if that’s just an empty string.
    - Unwrapping an optional is the process of looking inside a box to see what it contains: if there’s a value inside it’s sent back for use, otherwise there will be nil inside.
    - We can use if let to run some code if the optional has a value, or guard let to run some code if the optional doesn’t have a value – but with guard we must always exit the function afterwards.
    - The nil coalescing operator, ??, unwraps and returns an optional’s value, or uses a default value instead.
    - Optional chaining lets us read an optional inside another optional with a convenient syntax.
    - If a function might throw errors, you can convert it into an optional using try? – you’ll either get back the function’s return value, or nil if an error is thrown.
 */




// ----------------------------------------------------------------

// Optionals - Checkpoint 9

/*
 
 write a function that accepts an optional array of integers, and returns one randomly. If the array is missing or empty, return a random number in the range 1 through 100.

 If that sounds easy, it’s because I haven’t explained the catch yet: I want you to write your function in a single line of code. No, that doesn’t mean you should just write lots of code then remove all the line breaks – you should be able to write this whole thing in one line of code.
 
 */


func randomPick(from values: [Int]?) -> Int {
    values?.randomElement() ?? Int.random(in: 1...100)
}

print(randomPick(from: [1, 2, 3]))
print(randomPick(from: nil))
