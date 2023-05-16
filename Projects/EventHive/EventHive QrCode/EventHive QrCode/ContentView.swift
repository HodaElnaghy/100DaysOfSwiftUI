import SwiftUI
import CodeScanner

struct QRCodeScannerExampleView: View {
    @State private var isPresentingScanner = false
    @State private var scannedCode: String?
    @State private var selectedTicket = ""
    @State var isValid : Bool? = nil
    @State var showAlert = false
    
    
    // Add a variable to hold the event object
    @State var event: MyObject
    
    enum EventTypes: CaseIterable {
        case Regular, Vip, VVip
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                if let code = scannedCode {
                    NavigationLink(
                        destination: NextView(codeTypes: code),
                        isActive: .constant(true),
                        label: { EmptyView() }
                    ).hidden()
                }
                
                ForEach(0..<event.tickettypes.count) { i in
                    Button(action: {
                        selectedTicket = event.tickettypes[i].name
                    }) {
                        HStack {
                            Text(event.tickettypes[i].name)
                            if selectedTicket == event.tickettypes[i].name {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.accentColor)
                            }
                        }
                    }
                }
  
                Button("\(selectedTicket)") {
                    isPresentingScanner = true
                }
                .font(.headline)
                .foregroundColor(Color("HiveWhite"))
                .padding()
                .frame(width: 300, height: 50)
                .background(Color("HiveButton"))
                .cornerRadius(15.0)
                
                Text(scannedCode ?? "")
                
            }
            .sheet(isPresented: $isPresentingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson") { result in
                    switch result {
                    case .success(let code):
                        print("Scanned text: \(code)")
                        scannedCode = code.string
                        
                        EventHive_QrCode.isValid(qrData: scannedCode ?? "", name: selectedTicket, eventid: event.id) { isValid in
                            self.isValid = isValid
                            showAlert = true
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                .alert("h", isPresented: $showAlert) {
                    Button("OK", action: endScanning)
                }
                
                
                
                
            }
            

            
        }
    }
    private func endScanning (){
        isPresentingScanner = false
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
