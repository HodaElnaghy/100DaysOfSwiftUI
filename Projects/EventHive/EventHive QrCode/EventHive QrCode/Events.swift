import SwiftUI
public var h = "hoda"

struct Events: View {
    @State public var eventArray = [MyObject]()
    @State public var selectedEventID: Int?
    @State var tokenData = "d"
    
    var body: some View {
        VStack {
            List(eventArray, id: \.id) { object in
                ForEach($eventArray, id: \.id) { $event in
                    NavigationLink(
                        destination: QRCodeScannerExampleView(event : event),
                        label: {
                            //let _ = print(tokenData)
                            ExtractedView(event: $event)
                        }
                    )
                    .disabled(!event.isEnabled)
                    .navigationBarBackButtonHidden(true)
    
                    
                    
                }
            }
            
            .listStyle(PlainListStyle())
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("eventhive-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .scrollIndicators(.hidden)
            .onAppear {
                Task {
                    await fetchData()
                }
            }
        }
    }
    
    private func fetchData() async {
        guard let tokenData = KeychainHelper.shared.read(service: "access-token", account: "edgeUI") else {
            print("Token not found in keychain")
            return
        }
        
        let token = String(data: tokenData, encoding: .utf8) ?? ""
        
        let urlString = "http://34.125.23.115:8000/api/event/app"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            eventArray = try JSONDecoder().decode(MyObjects.self, from: data)
            print(eventArray)
        } catch {
            print("Error: \(error)")
        }
    }

}

struct Events_Previews: PreviewProvider {
    static var previews: some View {
        Events()
    }
}

struct ExtractedView: View {
    @Binding var event : MyObject
    var body: some View {
        VStack(alignment: .leading){
            
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
        }
        .padding()
    }
}

