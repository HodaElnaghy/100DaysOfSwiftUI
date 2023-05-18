import SwiftUI
import CodeScanner

struct QRCodeScannerExampleView: View {
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?
    @State private var selectedTicket = ""
    @State var isValid = false
    @State var showAlert = false
    
    
    // Add a variable to hold the event object
    @State var event: MyObject
    
    enum EventTypes: CaseIterable {
        case Regular, Vip, VVip
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                
                
                
                AsyncImage(url: URL(string: event.img)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    case .failure(_):
                        // Placeholder view if image fails to load
                        Color.gray
                    case .empty:
                        // Placeholder view while the image is being loaded
                        Color.gray
                    @unknown default:
                        // Placeholder view for any unknown state
                        Color.gray
                    }
                }
                
                
                
                
                Text(event.name)
                    .font(.title3.bold())
                    .padding(.bottom,1)
                Text(event.date)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                
                
                
                
                ForEach(0..<event.tickettypes.count) { i in
                    Button(action: {
                        selectedTicket = event.tickettypes[i].name
                    }) {
                        HStack {
                            Text(event.tickettypes[i].name)
                                .foregroundColor(Color("HiveButton"))
                            if selectedTicket == event.tickettypes[i].name {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color("HiveButton"))
                            }
                        }
                    }
                }
  
                Button("Scan") {
                    isPresentingScanner = true
                }
                .font(.headline)
                .foregroundColor(Color("HiveWhite"))
                .padding()
                .frame(width: 300, height: 50)
                .background(Color("HiveButton"))
                .cornerRadius(15.0)
                
                
            }
            .sheet(isPresented: $isPresentingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson") { result in
                    switch result {
                    case .success(let code):
                        print("Scanned text: \(code)")
                        scannedCode = code.string
                        
                        EventHive_QrCode.isValid(qrData: scannedCode ?? "", name: selectedTicket, eventid: event.id) { isValid in
                            self.isValid = isValid
                            print(isValid)
                            showAlert = true
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                .alert(Text(isValid ? "Allow the user" : "Don't allow the user"), isPresented: $showAlert) {
                    Button("OK", action: endScanning)
                }
                
                
                
                
            }
            

            
        }
    }
    private func endScanning (){
        isPresentingScanner = false
    }
    
    
    
    
}

