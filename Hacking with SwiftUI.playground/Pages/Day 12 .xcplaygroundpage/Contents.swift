import Foundation

// Classes - video 1

/*
 I’ve already said that SwiftUI uses structs extensively for its UI design. Well, it uses classes extensively for its data: when you show data from some object on the screen, or when you pass data between your layouts, you’ll usually be using classes.
 */

/*
 classes differ from structs in five key places:

    1. You can make one class build upon functionality in another class, gaining all its properties and methods as a starting point. If you want to selectively override some methods, you can do that too.
    2. Because of that first point, Swift won’t automatically generate a memberwise initializer for classes. This means you either need to write your own initializer, or assign default values to all your properties.
    3. When you copy an instance of a class, both copies share the same data – if you change one copy, the other one also changes.
    4. When the final copy of a class instance is destroyed, Swift can optionally run a special function called a deinitializer.
    5. Even if you make a class constant, you can still change its properties as long as they are variables.
*/


/*
 However, SwiftUI uses classes extensively, mainly for point 3: all copies of a class share the same data. This means many parts of your app can share the same information, so that if the user changed their name in one screen all the other screens would automatically update to reflect that change.
 */


/*
 The other points matter, but are of varying use:

    1. Being able to build one class based on another is really important in Apple’s older UI framework, UIKit, but is much less common in SwiftUI apps. In UIKit it was common to have long class hierarchies, where class A was built on class B, which was built on class C, which was built on class D, etc.
    2. Lacking a memberwise initializer is annoying, but hopefully you can see why it would be tricky to implement given that one class can be based upon another – if class C added an extra property it would break all the initializers for C, B, and A.
    3. Being able to change a constant class’s variables links in to the multiple copy behavior of classes: a constant class means we can’t change what pot our copy points to, but if the properties are variable we can still change the data inside the pot. This is different from structs, where each copy of a struct is unique and holds its own data.
    4. Because one instance of a class can be referenced in several places, it becomes important to know when the final copy has been destroyed. That’s where the deinitializer comes in: it allows us to clean up any special resources we allocated when that last copy goes away.
 
 
 Before we’re done, let’s look at just a tiny slice of code that creates and uses a class:
 */

class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10


// ------------------------------------------------------------------------------------------------------------------
print()

// Class Inheritanvce - video 2

// parent class
class Employee {
    let hours: Int

    init(hours: Int) {
        self.hours = hours
    }
    
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

// child class inherits from Employee
class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
    
    override func printSummary() {
        print("I am a developer that will sometimes work \(hours) hours per day. Other day's I'll just use ChatGPT")
    }
}

// child class inherits from Employee
class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()


let jeff = Developer(hours: 8)
jeff.printSummary()


/*
 overriding a method from parent class.
 This is where Swift enforces a simple rule: if a child class wants to change a method from a parent class, you must use override in the child class’s version. This does two things:

 If you attempt to change a method without using override, Swift will refuse to build your code. This stops you accidentally overriding a method.
 If you use override but your method doesn’t actually override something from the parent class, Swift will refuse to build your code because you probably made a mistake.
 So, if we wanted developers to have a unique printSummary() method, we’d add this to the Developer class:
 */


/*
 Tip: If you know for sure that your class should not support inheritance, you can mark it as final. This means the class itself can inherit from other things, but can’t be used to inherit from – no child class can use a final class as its parent.
 */


// ------------------------------------------------------------------------------------------------------------------
print()

// Class Initializers - video 3


// Class initializers in Swift are more complicated than struct initializers. If a child class has any custom initializers, it must always call the parent’s initializer after it has finished setting up its own properties, if it has any

// Like I said previously, Swift won’t automatically generate a memberwise initializer for classes. So you either write your own or provide default values for all properties.

class Vehicle {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}



class Car: Vehicle {
    let isConvertible: Bool

    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

let fiesta = Car(isElectric: false, isConvertible: false)


// Tip: If a subclass does not have any of its own initializers, it automatically inherits the initializers of its parent class. I.e. if the Car class had a default value of false for the isConvertable propoerty then it would not need an init and would still get to use the Vehicle init.


// ------------------------------------------------------------------------------------------------------------------
print()

// How to copy classes - video 4

// As classes are reference type, here is proof

class User {
    var username = "Anonymous"
}

var user1 = User()
var user2 = user1
user2.username = "Taylor"

print(user1.username)
print(user2.username)

// As you’ll see, SwiftUI relies very heavily on classes for its data, specifically because they can be shared so easily.

/*
 In comparison, structs do not share their data amongst copies, meaning that if we change class User to struct User in our code we get a different result: it will print “Anonymous” then “Taylor”, because changing the copy didn’t also adjust the original.
 */


// If you want to make a unique copy of a class (a deep copy):

class User2 {
    var username = "Anonymous"

    func copy() -> User {
        let user = User()
        user.username = username
        return user
    }
}

let john = User2()
let sally = john.copy()
john.username = "Captain"

print(john.username)
print(sally.username)



// ------------------------------------------------------------------------------------------------------------------
print()

// How to create a deinitializer for a class - video 5


/*
 
 Swift’s classes can optionally be given a deinitializer, which is a bit like the opposite of an initializer in that it gets called when the object is destroyed rather than when it’s created.
 
 This comes with a few small provisos:

    1. Just like initializers, you don’t use func with deinitializers – they are special.
    2. Deinitializers can never take parameters or return data, and as a result aren’t even written with parentheses.
    3. Your deinitializer will automatically be called when the final copy of a class instance is destroyed. That might mean it was created inside a function that is now finishing, for example.
    4. We never call deinitializers directly; they are handled automatically by the system.
    5. Structs don’t have deinitializers, because you can’t copy them.
 */

// final copy is deinitialized when the scope of the last referencing instance is destroyed.

// To demonstrate this, we could create a class that prints a message when it’s created and destroyed, using an initializer and deinitializer:

class User3 {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    deinit {
        print("User \(id): I'm dead!")
    }
}

// Now we can create and destroy instances of that quickly using a loop – if we create a User instance inside the loop, it will be destroyed when the loop iteration finishes:

for i in 1...3 {
    let user = User3(id: i)
    print("User \(user.id): I'm in control!")
}


// ------------------------------------------------------------------------------------------------------------------
print()

// How to create work with variables inside classes - video 6


class User4 {
    var name = "Paul"
}

let user = User4()
// you are able to change the name property as its a var EVEN through the user is a constant.
user.name = "Taylor"
print(user.name)


// Now, if we had made the name property a constant using let, then it could not be changed

// In contrast, what happens if we made both the user instance and the name property variables?
var user3 = User4()
user3.name = "Taylor"
user3 = User4()
print(user.name)


/*
 So, we end up with four options:

    1. Constant instance, constant property – a signpost that always points to the same user, who always has the same name.
    2. Constant instance, variable property – a signpost that always points to the same user, but their name can change.
    3. Variable instance, constant property – a signpost that can point to different users, but their names never change.
    4. Variable instance, variable property – a signpost that can point to different users, and those users can also change their names.
 
 This might seem awfully confusing, and perhaps even pedantic. However, it serves an important purpose because of the way class instances get shared.
 */


/*
 Let’s say you’ve been given a User instance. Your instance is constant, but the property inside was declared as a variable. This tells you not only that you can change that property if you want to, but more importantly tells you there’s the possibility of the property being changed elsewhere – that class you have could be a copy from somewhere else, and because the property is variable it means some other part of code could change it by surprise.

 When you see constant properties it means you can be sure neither your current code nor any other part of your program can change it, but as soon as you’re dealing with variable properties – regardless of whether the class instance itself is constant or not – it opens up the possibility that the data could change under your feet.

 This is different from structs, because constant structs cannot have their properties changed even if the properties were made variable. Hopefully you can now see why this happens: structs don’t have the whole signpost thing going on, they hold their data directly. This means if you try to change a value inside the struct you’re also implicitly changing the struct itself, which isn’t possible because it’s constant.

 One upside to all this is that classes don’t need to use the mutating keyword with methods that change their data. This keyword is really important for structs because constant structs cannot have their properties changed no matter how they were created, so when Swift sees us calling a mutating method on a constant struct instance it knows that shouldn’t be allowed.

 With classes, how the instance itself was created no longer matters – the only thing that determines whether a property can be modified or not is whether the property itself was created as a constant. Swift can see that for itself just by looking at how you made the property, so there’s no more need to mark the method specially.
 */


// ------------------------------------------------------------------------------------------------------------------
print()

// Summary Classes

/*
 Classes aren’t quite as commonly used as structs, but they serve an invaluable purpose for sharing data, and if you ever choose to learn Apple’s older UIKit framework you’ll find yourself using them extensively.

 Let’s recap what we learned:

    - Classes have lots of things in common with structs, including the ability to have properties and methods, but there are five key differences between classes and structs.
    - First, classes can inherit from other classes, which means they get access to the properties and methods of their parent class. You can optionally override methods in child classes if you want, or mark a class as being final to stop others subclassing it.
    - Second, Swift doesn’t generate a memberwise initializer for classes, so you need to do it yourself. If a subclass has its own initializer, it must always call the parent class’s initializer at some point.
    - Third  , if you create a class instance then take copies of it, all those copies point back to the same instance. This means changing some data in one of the copies changes them all.
    - Fourth, classes can have deinitializers that run when the last copy of one instance is destroyed.
    - Finally, variable properties inside class instances can be changed regardless of whether the instance itself was created as variable.
 
 */


// ------------------------------------------------------------------------------------------------------------------
print()

// Checkpoint 7: Class hierachy for animals

/*
 Your challenge is this: make a class hierarchy for animals, starting with Animal at the top, then Dog and Cat as subclasses, then Corgi and Poodle as subclasses of Dog, and Persian and Lion as subclasses of Cat.

 But there’s more:

    1. The Animal class should have a legs integer property that tracks how many legs the animal has.
    2. The Dog class should have a speak() method that prints a generic dog barking string, but each of the subclasses should print something slightly different.
    3. The Cat class should have a matching speak() method, again with each subclass printing something different.
    4. The Cat class should have an isTame Boolean property, provided using an initializer.
 */

class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() {
        print("Bark")
    }
}

class Cat: Animal {
    let isTame: Bool
    
    init(isTame: Bool, legs: Int) {
        self.isTame = isTame
        super.init(legs:legs)
    }
    
    func speak() {
        print("Meow")
    }
}


class Corgi: Dog {
    override func speak() {
        print("ruff")
    }
}

class Poodle: Dog {
    override func speak() {
        print("woof")
    }
}
