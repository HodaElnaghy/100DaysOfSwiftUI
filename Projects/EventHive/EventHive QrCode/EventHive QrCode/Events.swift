import SwiftUI
public var h = "hoda"

struct Events: View {
    @State public var eventArray = [MyObject]()
    @State public var selectedEventID: Int?
    
    var body: some View {
        VStack {
            List(eventArray, id: \.id) { object in
                ForEach($eventArray, id: \.id) { $event in
                    NavigationLink(
                        destination: QRCodeScannerExampleView(event : event),
                        label: {
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
        let url = URL(string: "http://localhost:3001/")
        do {
            let (data, _) = try await URLSession.shared.data(from: url!)
            eventArray = try JSONDecoder().decode(MyObjects.self, from: data)
            print(eventArray)
        } catch {
            print(error)
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
            Image(event.img)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 10))
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

