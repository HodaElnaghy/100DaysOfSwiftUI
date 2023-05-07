import Cocoa

struct Hoda: Decodable {}
let data = Data()
do {
    try JSONDecoder().decode(Hoda.self, from: data)

} catch {
    print(error.localizedDescription)
}
