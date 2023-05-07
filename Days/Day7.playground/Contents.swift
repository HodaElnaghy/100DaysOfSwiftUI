import Cocoa

var greeting = "Hello, playground"

func compareString (word1 : String, word2 : String)-> Bool{
    
    return (word1.sorted() == word2.sorted())
}

let h:Bool = true
let y = (h == true) ? print("H") : print("G")

print(compareString(word1: "abc", word2: "cab"))


//let x = ("avc".sorted() == "vca".sorted())? print("V") : print("H")
func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}

let user = getUser()
let firstName = user.firstName
let lastName = user.lastName

print("Name: \(firstName) \(lastName)")
let (firstName, _) = getUser()
print("Name: \(firstName)")
