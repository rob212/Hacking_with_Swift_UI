import Foundation

// Struct access control - video 1

/*
 By default, Swift’s structs let us access their properties and methods freely, but often that isn’t what you want – sometimes you want to hide some data from external access.

 Want to ensure that funds should be private. To solve this, we can tell Swift that funds should be accessible only inside the struct – by methods that belong to the struct, as well as any computed properties, property observers, and so on. Access contorl can apply to properties or methods
 */


struct BankAccount {
    private(set) var funds = 0

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount()
account.deposit(amount: 100)
let success = account.withdraw(amount: 200)

if success {
    print("Withdrew money successfully")
    } else {
        print("Failed to get the money")
    }

/*
 And now accessing funds from outside the struct isn’t possible, but it is possible inside both deposit() and withdraw(). If you try to read or write funds from outside the struct Swift will refuse to build your code.

 This is called access control, because it controls how a struct’s properties and methods can be accessed from outside the struct.

 Swift provides us with several options, but when you’re learning you’ll only need a handful:

    - Use private for “don’t let anything outside the struct use this.”
    - Use fileprivate for “don’t let anything outside the current file use this.”
    - Use public for “let anyone, anywhere use this.”
 */

// Error: "'funds' is inaccessible due to 'private' protection level"
// account.funds = 10000

/*
 There’s one extra option that is sometimes useful for learners, which is this: private(set). This means “let anyone read this property, but only let my methods write it.” If we had used that with BankAccount, it would mean we could print account.funds outside of the struct, but only deposit() and withdraw() could actually change the value.
 
 - private(set) = "anyone can read but only my members can write" - prob the best option for us here
 */



// IMPORTANT: If you use private access control for one or more properties, chances are you’ll need to create your own initializer.



print()
// ----------------------------------------------------------------------------------------------------------------

// Static properties and methods - video 2

/*
 Sometimes – only sometimes – you want to add a property or method to the struct itself, rather than to one particular instance of the struct, which allows you to use them directly. I use this technique a lot with SwiftUI for two things:
    1. creating example data
    2. storing fixed data that needs to be accessed in various places.
 
 First, let’s look at a simplified example of how to create and use static properties and methods:
 */

//struct School {
//    
//    static var studentCount = 0
//
//    static func add(student: String) {
//        print("\(student) joined the school.")
//        studentCount += 1
//    }
//}

/*
 Notice the keyword static in there, which means both the studentCount property and add() method belong to the School struct itself, rather than to individual instances of the struct.

 To use that code, we’d write the following:
 */

//School.add(student: "Taylor Swift")
//print(School.studentCount)


/*
 I haven’t created an instance of School – we can literally use add() and studentCount directly on the struct. This is because those are both static, which means they don’t exist uniquely on instances of the struct.

 This should also explain why we’re able to modify the studentCount property without marking the method as mutating – that’s only needed with regular struct functions for times when an instance of struct was created as a constant, and there is no instance when calling add().

 If you want to mix and match static and non-static properties and methods, there are two rules:

    1. To access non-static code from static code… you’re out of luck: static properties and methods can’t refer to non-static properties and methods because it just doesn’t make sense – which instance of School would you be referring to?
    2. To access static code from non-static code, always use your type’s name such as School.studentCount. You can also use Self to refer to the current type.
 
 Now we have self and Self, and they mean different things: self REFERS TO THE CURRENT VALUE OF THE STRUCT, AND Self refers to the current type.

 TIP: It’s easy to forget the difference between self and Self, but if you think about it it’s just like the rest of Swift’s naming – we start all our data types with a capital letter (Int, Double, Bool, etc), so it makes sense for Self to start with a capital letter too.

 Now, that sound you can hear is a thousand other learners saying “why the heck is this needed?” And I get it – this can seem like a rather redundant feature at first. So, I want to show you the two main ways I use static data.

 First, I use static properties to organize common data in my apps. For example, I might have a struct like User Settings or AppData to store lots of shared values I use in many places:
 */

struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.hackingwithswift.com"
}


/*
 Using this approach, everywhere I need to check or display something like my app’s version number – an about screen, debug output, logging information, support emails, etc – I can read AppData.version.

 The second reason I commonly use static data is to create examples of my structs. As you’ll see later on, SwiftUI works best when it can show previews of your app as you develop, and those previews often require sample data. For example, if you’re showing a screen that displays data on one employee, you’ll want to be able to show an example employee in the preview screen so you can check it all looks correct as you work.

 This is best done using a static example property on the struct, like this:
 */

struct Employee {
    let username: String
    let password: String

    static let example = Employee(username: "cfederighi", password: "hairforceone")
}

/*
 And now whenever you need an Employee instance to work with in your design previews, you can use Employee.example and you’re done.

 Like I said at the beginning, there are only a handful of occasions when a static property or method makes sense, but they are still a useful tool to have around.


 */


print()
// ----------------------------------------------------------------------------------------------------------------

// Summary: Structs

/*
 Structs are used almost everywhere in Swift: String, Int, Double, Array and even Bool are all implemented as structs, and now you can recognize that a function such as isMultiple(of:) is really a method belonging to Int.

 Let’s recap what else we learned:

    - You can create your own structs by writing struct, giving it a name, then placing the struct’s code inside braces.
    - Structs can have variable and constants (known as properties) and functions (known as methods)
    - If a method tries to modify properties of its struct, you must mark it as mutating.
    - You can store properties in memory, or create computed properties that calculate a value every time they are accessed.
    - We can attach didSet and willSet property observers to properties inside a struct, which is helpful when we need to be sure that some code is always executed when the property changes.
    - Initializers are a bit like specialized functions, and Swift generates one for all structs using their property names.
    - You can create your own custom initializers if you want, but you must always make sure all properties in your struct have a value by the time the initializer finishes, and before you call any other methods.
    - We can use access to mark any properties and methods as being available or unavailable externally, as needed.
    - It’s possible to attach a property or methods directly to a struct, so you can use them without creating an instance of the struct.
 */


print()
// ----------------------------------------------------------------------------------------------------------------

// Checkpoint 6: Structs

/*
 create a struct to store information about a car, including its model, number of seats, and current gear, then add a method to change gears up or down. Have a think about variables and access control: what data should be a variable rather than a constant, and what data should be exposed publicly? Should the gear-changing method validate its input somehow?
 */

enum CarModel {
    case ford, toyota, vw
}


struct Car {
    let model: CarModel
    let numberOfSeats: Int
    private(set) var currentGear: Int
    
    mutating func changeGear(up: Bool) {
        if up && (currentGear != 10) {
            self.currentGear += 1
        } else if !up && (currentGear != 1) {
            self.currentGear -= 1
        }
    }
}

var fiesta = Car(model: .ford, numberOfSeats: 5, currentGear: 5)
fiesta.changeGear(up: true)
print(fiesta.currentGear)
fiesta.changeGear(up: false)
fiesta.changeGear(up: false)
print(fiesta.currentGear)
