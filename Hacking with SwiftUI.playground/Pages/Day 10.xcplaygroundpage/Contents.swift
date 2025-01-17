import Foundation

// Structs - video 1

// Swift’s structs let us create our own custom, complex data types, complete with their own variables and their own functions.
// They are stored by value in the Stack (and every Thread has their own Stack in Swift - with the Heap being shared by an app and all it's Threads)


// struct is a type so should have a capitla letter just like String, Int, Bool as they are all structs too.
struct Album {
    let title: String
    let artist: String
    let year: Int

    func printSummary() {
        print("\(title) (\(year)) by \(artist)")
    }
}

let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
let wings = Album(title: "Wings", artist: "BTS", year: 2016)

print(red.title)
print(wings.title)

red.printSummary()
wings.printSummary()


print()
// When you want to have values in your struct that can change (i.e. vars)

struct Employee {
    let name: String
    var vacationRemaining: Int

   mutating func takeVacation(days: Int) {
        if vacationRemaining > days {
            vacationRemaining -= days
            print("I'm going on vacation!")
            print("Days remaining: \(vacationRemaining)")
        } else {
            print("Oops! There aren't enough days remaining.")
        }
    }
}

/*
 However, that won’t actually work without the mutating keyword on the function  – Swift will refuse to build the code. This is becuase line 39 in the takeVacation() we are attempting to mutatble (change) the value of vacationRemaining.

 You see, if we create an employee as a constant using let, Swift makes the employee and all its data constant – we can call functions just fine, but those functions shouldn’t be allowed to change the struct’s data because we made it constant.

 As a result, Swift makes us take an extra step: any functions that only read data are fine as they are, but any that change data belonging to the struct must be marked with a special mutating keyword.

 */

// This works as we have a variable archer.
var archer = Employee(name: "Sterling Archer", vacationRemaining: 14)
archer.takeVacation(days: 5)
print(archer.vacationRemaining)


// However, if we were to create a constant we are not able to call takeVacation() as it's a mutation function and Swift makes a let immutable INCLUDING ALL ITS PROPERTIES
// Will get the error "cannot use mutating member on immutable value: 'bart' is a 'let' constant"

//let bart = Employee(name: "Bart Simpson", vacationRemaining: 5)
//bart.takeVacation(days: 1)
//print(bart.vacationRemaining)

/*
 We’re going to explore structs in detail over the next few chapters, but first I want to give some names to things.

 - Variables and constants that belong to structs are called properties.
 - Functions that belong to structs are called methods.
 - When we create a constant or variable out of a struct, we call that an instance – you might create a dozen unique instances of the Album struct, for example.
 - When we create instances of structs we do so using an initializer like this: Album(title: "Wings", artist: "BTS", year: 2016).
 */




// -----------------------------------------------------------------------------------------------------------------
print()

// Computed properties - video 2


/*
    Structs can have two kinds of property: a stored property is a variable or constant that holds a piece of data inside an instance of the struct, and a computed property calculates the value of the property dynamically every time it’s accessed
 
 */

struct Employee2 {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0

    var vacationRemaining: Int {
        vacationAllocated - vacationTaken
    }
}

/*
 Now rather than making vacationRemaining something we can assign to directly as we did in video 1, it is instead calculated by subtracting how much vacation they have taken from how much vacation they were allotted.

 When we’re reading from vacationRemaining, it looks like a regular stored property:
 */

var gary = Employee2(name: "Gary")
gary.vacationTaken += 4
print(gary.vacationRemaining)

gary.vacationTaken += 4
print(gary.vacationRemaining)

/*
 This is really powerful stuff: we’re reading what looks like a property, but behind the scenes Swift is running some code to calculate its value every time.

 We can’t write to it, though, because we haven’t told Swift how that should be handled. To fix that, we need to provide both a getter and a setter – fancy names for “code that reads” and “code that writes” respectively.

 In this case the getter is simple enough, because it’s just our existing code. But the setter is more interesting – if you set vacationRemaining for an employee, do you mean that you want their vacationAllocated value to be increased or decreased, or should vacationAllocated stay the same and instead we change vacationTaken?

 I’m going to assume the first of those two is correct, in which case here’s how the property would look:
 */

struct Employee3 {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0

    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }
        
        set {
            vacationAllocated = vacationTaken + newValue
        }
    }
}

print()
/*
 Notice how get and set mark individual pieces of code to run when reading or writing a value. More importantly, notice newValue – that’s automatically provided to us by Swift, and stores whatever value the user was trying to assign to the property.

 With both a getter and setter in place, we can now modify vacationRemaining:
 */

var bob = Employee3(name: "Bob", vacationAllocated: 14)
bob.vacationTaken += 4
print(bob.vacationRemaining)
bob.vacationRemaining = 5
print(bob.vacationAllocated)


// -----------------------------------------------------------------------------------------------------------------
print()

// How to take action when a property changes via observers (didSet, didGet) - video 3

/*
 Swift lets us create property observers, which are special pieces of code that run when properties change. These take two forms: a didSet observer to run when the property just changed, and a willSet observer to run before the property changed.
 
 To see why property observers might be needed, think about code like this, If I forgot to write another print at the end. We could prevent this with a didSet Observer
 */

struct Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var game = Game()
game.score += 10
game.score -= 3
game.score += 1


print()
// You can also use automatic provided Swift info "oldValue" inside "didSet" and "newValue" inside "willSet"
// We can demonstrate all this functionality in action using one code sample, which will print messages as the values change so you can see the flow when the code is run:

struct App {
    var contacts = [String]() {
        willSet {
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)")
        }

        didSet {
            print("There are now \(contacts.count) contacts.")
            print("Old value was \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian E")
app.contacts.append("Allen W")
app.contacts.append("Ish S")


/*
 In practice, willSet is used much less than didSet, but you might still see it from time to time so it’s important you know it exists. Regardless of which you choose, please try to avoid putting too much work into property observers – if something that looks trivial such as game.score += 1 triggers intensive work, it will catch you out on a regular basis and cause all sorts of performance problems.
 */


// -----------------------------------------------------------------------------------------------------------------
print()

// How to create custom initializers - video 4

/*
 
    Silently generated init() by swift initializes our Struct by ensuring initial values are set for ALL the properties in the Struct
 
 You can create your own init provided you follow one golden rule: ALL PROPERTIES MUST HAVE A VALUE BY THE TIME THE INITIALIZER ENDS
 
 Let’s start by looking again at Swift’s default initializer for structs:
 */


struct Player {
    let name: String
    let number: Int
}

// This is called the MEMBERWISE initializer - (it accepts each property in the order in which it was defined in the struct)
let player = Player(name: "Megan R", number: 15)


// Now lets define our own init:


struct Player2 {
    let name: String
    let number: Int
    
    init(name: String, number: Int) {
        self.name = name
        self.number = number
    }
}

/*
 
 However, there are a couple of things I want you to notice:

    1. There is no func keyword. Yes, this looks like a function in terms of its syntax, but Swift treats initializers specially.
    2. Even though this creates a new Player instance, initializers never explicitly have a return type – they always return the type of data they belong to.
    3. I’ve used self to assign parameters to properties to clarify we mean “assign the name parameter to my name property”.
 */


/*
 
 Of course, our custom initializers don’t need to work like the default memberwise initializer Swift provides us with. For example, we could say that you must provide a player name, but the shirt number is randomized:
 */

struct Player3 {
    let name: String
    let number: Int
    
    init(name: String) {
        self.name = name
        self.number = Int.random(in: 1...99)
    }
}

let megan = Player3(name: "Megan")
print("\(megan.name), number: \(megan.number)")

/*
 Important: Although you can call other methods of your struct inside your initializer, you can’t do so before assigning values to all your properties – Swift needs to be sure everything is safe before doing anything else.

 You can add multiple initializers to your structs if you want, as well as leveraging features such as external parameter names and default values. However, as soon as you implement your own custom initializers you’ll lose access to Swift’s generated memberwise initializer unless you take extra steps to retain it. This isn’t an accident: if you have a custom initializer, Swift effectively assumes that’s because you have some special way to initialize your properties, which means the default one should no longer be available.
 
 */
