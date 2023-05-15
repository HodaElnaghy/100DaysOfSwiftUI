import SwiftUI
import CodeScanner

struct QRCodeScannerExampleView: View {
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?
    @State private var fetchedData: String?
    @State var event : MyObject
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                if let code = scannedCode {
                    NavigationLink("Next page", destination: NextView(codeTypes: code), isActive: .constant(true)).hidden()
                }
                
                
                
                
                Button("\(event.name)") {
                    isPresentingScanner = true
                    print(h)
                }
                .font(.headline)
                .foregroundColor(Color("HiveWhite"))
                .padding()
                .frame(width: 300, height: 50)
                .background(Color("HiveButton"))
                .cornerRadius(15.0)
                Text(scannedCode ?? "")
                Text(fetchedData ?? "")
                
                //Text("Scan a QR code to begin")
            }
            .sheet(isPresented: $isPresentingScanner) {
                CodeScannerView(codeTypes: [.qr]) { response in
                    if case let .success(result) = response {
                        let request = URLRequest(url: URL(string: result.string)!)
                        URLSession.shared.dataTask(with: request) { data, response, error in
                            guard let data = data else { return }
                            do {
                                let decodedData = try JSONDecoder().decode(TicketStatus.self, from: data)
                                fetchedData = decodedData.isValid ? "This person is allowed" : "This person is not allowed"
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
    
//    struct ContentView_Previews: PreviewProvider {
//        @Binding var event: MyObject
//
//        static var previews: some View {
//            QRCodeScannerExampleView(event: event)
//        }
//    }

