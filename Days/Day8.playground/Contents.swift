import Cocoa

let string = "12345"
enum PasswordError: Error {
    case short, obvious
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }

    if password == "12345" {
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

do {
    let result = try checkPassword(string)
    print("Password rating: \(result)")
} catch PasswordError.short {
    print("Please use a longer password.")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error.")
}

//error.localizedDescription
func parkCar(_ hel: String = "Tesla", automatically: Bool = true) {
    if automatically {
        print("Nice - my \(hel) parked itself!")
    } else {
        print("I guess I'll have to do it.")
    }
}
parkCar(automatically:false )
