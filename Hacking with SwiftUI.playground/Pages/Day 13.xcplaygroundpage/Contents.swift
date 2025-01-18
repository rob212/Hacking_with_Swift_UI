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

// How to use opaque return types - video 2
