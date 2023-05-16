import Foundation


func isValid(qrData: String, name: String, eventid: Int, completion: @escaping (Bool) -> Void) {
    guard let tokenData = KeychainHelper.shared.read(service: "access-token", account: "edgeUI") else {
        print("Token not found in keychain")
        completion(false)
        return
    }
    
    let token = String(data: tokenData, encoding: .utf8) ?? ""
    
    let isValidURL = URL(string: "https://dummyjson.com/auth/login")!
    var request = URLRequest(url: isValidURL)
    let body = ["qrData": qrData, "name": name, "eventid": eventid] as [String: Any]
    let bodyData = try? JSONSerialization.data(withJSONObject: body)
    request.httpMethod = "POST"
    request.httpBody = bodyData
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            completion(false)
            return
        }
        
        let responseJSON = try? JSONSerialization.jsonObject(with: data)
        
        if let responseDict = responseJSON as? [String: Any], let isValid = responseDict["isValid"] as? Bool {
            completion(isValid)
        } else {
            completion(false)
        }
    }.resume()
}



