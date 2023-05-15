import Foundation

func isValid(qrData: String, name: String, eventid: Int, token: String) {
  let isValidURL = URL(string: "https://dummyjson.com/auth/login")!
  var request = URLRequest(url: isValidURL)
    let body = ["qrData": qrData, "name": name, "eventid": eventid] as [String : Any]
    let bodyData = try? JSONSerialization.data(withJSONObject: body)
  request.httpMethod = "POST"
  request.httpBody = bodyData
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
  request.addValue("application/json", forHTTPHeaderField: "Content-Type")
  URLSession.shared.dataTask(with: request) { data, response, error in
    guard let data = data else { return }

    let responseJSON = try? JSONSerialization.jsonObject(with: data)
      
    if let responseJSON = responseJSON as? [String: Any] {
      guard let token = responseJSON["token"] as? String else { return }
        print(token)
      KeychainHelper.shared.save( token.data(using: .utf8)!, service: "access-token", account: "edgeUI")
      let tokenData = KeychainHelper.shared.read(service: "access-token", account: "edgeUI")
      print(String(data: tokenData!, encoding: .utf8)!)
    }
  }.resume()
}
