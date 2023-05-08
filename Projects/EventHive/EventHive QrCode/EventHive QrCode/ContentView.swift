import SwiftUI
import CodeScanner

struct QRCodeScannerExampleView: View {
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?
    @State private var fetchedData: String?
    
    var body: some View {
        VStack(spacing: 10) {
            if let code = scannedCode {
                NavigationLink("Next page", destination: NextView(codeTypes: code), isActive: .constant(true)).hidden()
            }
            AsyncImage(url: URL(string: "https://picsum.photos/id/237/200/300"))
            Button("Scan Code") {
                isPresentingScanner = true
            }
            Text(scannedCode ?? "")
            Text(fetchedData ?? "")
            
            Text("Scan a QR code to begin")
        }
        .sheet(isPresented: $isPresentingScanner) {
            CodeScannerView(codeTypes: [.qr]) { response in
                if case let .success(result) = response {
                    let request = URLRequest(url: URL(string: result.string)!)
                    URLSession.shared.dataTask(with: request) { data, response, error in
                        guard let data = data else { return }
                        do {
                            let decodedData = try JSONDecoder().decode(Welcome.self, from: data)
                            fetchedData = "name: \(decodedData[0].name)\nemail: \(decodedData[0].email)"
                        } catch {
                            print(error)
                        }
                    }.resume()
                    
                    if case let .success(result) = response {
                        scannedCode = result.string
                        isPresentingScanner = false
                    }
                }
            }
        }
    }
}
    
    struct NextView: View {
        var codeTypes: String
        var body: some View {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding()
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            QRCodeScannerExampleView()
        }
    }

