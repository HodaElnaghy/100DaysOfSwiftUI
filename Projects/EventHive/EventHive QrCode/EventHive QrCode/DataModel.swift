import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

//struct UserLoginResponse : Decodable {
//    let username : String
//    let token : String
//}

struct qrCodeScanRespone : Decodable {
    let isValid : String
}

struct EventData : Codable, Hashable {
    let id : Int
    let eventid : Int
    let name : String
    let price : Int
}

struct MyObject: Codable {
    var id: Int
    let img : String
    let name : String
    let isEnabled :Bool
    let date : String
    let tickettypes : [EventData]
}

typealias MyObjects = [MyObject]




//{
//    [{
//        name : "h",
//        image : "url"
//        isAvailabe : false
//    },
//     {
//         name : "g",
//         image : "ur"
//         isAvailabe : false
//     }
//    ]
//}

struct EventHive : Codable {
    let name : String
    let image : String
    let isAvailable : Bool
}
struct TicketStatus : Codable{
    let isValid : Bool
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
