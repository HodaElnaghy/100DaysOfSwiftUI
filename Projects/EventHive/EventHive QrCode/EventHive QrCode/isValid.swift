import Foundation


func isValid(qrData: String, name: String, eventid: Int, completion: @escaping (Bool) -> Void) {
    guard let tokenData = KeychainHelper.shared.read(service: "access-token", account: "edgeUI") else {
        print("Token not found in keychain")
        completion(false)
        return
    }
    
    let token = String(data: tokenData, encoding: .utf8) ?? ""
    
    let isValidURL = URL(string: "http://34.125.23.115:8000/api/ticket/verify")!
    var request = URLRequest(url: isValidURL)
    let body = ["ticketId": qrData, "gate": name, "eventId": eventid] as [String: Any]
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
        print(responseJSON)
        if let responseDict = responseJSON as? [String: Any], let isValidNumber = responseDict["valid"] as? NSNumber {
            let isValid = isValidNumber.boolValue
            print(isValid)
            
            completion(isValid)
        } else {
            completion(false)
        }

    }.resume()
}



