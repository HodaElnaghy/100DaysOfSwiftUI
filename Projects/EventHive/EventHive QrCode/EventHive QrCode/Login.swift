import Foundation

func login(username: String, password: String) {
  let loginURL = URL(string: "https://dummyjson.com/auth/login")!
  var request = URLRequest(url: loginURL)
  let body = ["username": username, "password": password]
    let bodyData = try? JSONSerialization.data(withJSONObject: body)
  request.httpMethod = "POST"
  request.httpBody = bodyData
  request.addValue("application/json", forHTTPHeaderField: "Content-Type")
  URLSession.shared.dataTask(with: request) { data, response, error in
    guard let data = data else { return }

    let responseJSON = try? JSONSerialization.jsonObject(with: data)
      print(responseJSON)
    if let responseJSON = responseJSON as? [String: Any] {
      print(responseJSON)
      guard let token = responseJSON["token"] as? String else { return }
      KeychainHelper.shared.save( token.data(using: .utf8)!, service: "access-token", account: "edgeUI")
      let tokenData = KeychainHelper.shared.read(service: "access-token", account: "edgeUI")
      print(String(data: tokenData!, encoding: .utf8)!)
    }
  }.resume()
}