import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}


//{
//    name : "h",
//    image : "url"
//    isAvailabe : false
//}

struct EventHive : Codable {
    let name : String
    let image : String
    let isAvailable : Bool
}



// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String
}

typealias Welcome = [WelcomeElement]
