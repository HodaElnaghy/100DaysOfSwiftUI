import SwiftUI

struct LoginView: View {
    
    @State private var username = "kekkers"
    @State private var password = "kekkers"
    @State private var isUsernameEditing = false
    @State private var isPasswordEditing = false
    @FocusState private var isFocused : Bool
    @State private var isAuthenticated = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 0){
                    Image("eventhive-logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom,40)
                    VStack(alignment: .leading, spacing: 40){
                        
                        
                        
                        VStack(alignment: .leading ,spacing: 7){
                            Text ("Username")
                                .foregroundStyle(.secondary)
                                .font(.subheadline)
                            TextField("Username", text: $username)
                                .padding(10)
                                .background(Color("HiveWhite"))
                                .cornerRadius(10)
                                .keyboardType(.default)
                                .focused($isFocused)
                        }
                        
                        VStack(alignment: .leading ,spacing: 5){
                            Text ("Password")
                                .foregroundStyle(.secondary)
                                .font(.subheadline)
                            SecureField("Password", text: $password )
                                .padding(10)
                                .background(Color("HiveWhite"))
                                .cornerRadius(10)
                                .keyboardType(.default)
                                .focused($isFocused)
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 50)
                    .padding(.horizontal,30)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 1)
                    .padding(.bottom,40)
                    
                    NavigationLink(destination: Events(), isActive: $isAuthenticated) {
                        EmptyView()
                    }
                    
                    
                    
                    Button("Login") {
                        
                        login(username: username, password: password) { isAuthenticated in
                            self.isAuthenticated = isAuthenticated
                            UserDefaults.standard.set(isAuthenticated, forKey: "isLoggedIn")
                            // Perform any additional actions based on the authentication status
                        }
                    } 
                        .font(.headline)
                        .foregroundColor(Color("HiveWhite"))
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color("HiveButton"))
                        .cornerRadius(15.0)
                    
                    .navigationBarBackButtonHidden(true)
                    .disabled(false)
                    
                    
                }.padding(30)
                
            }
            
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        isFocused = false
                    }
                }
                
            }
            //.navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            
            
            
            // make sure it is authenticated
            
        }
        
    }
    
    
    
    // Is the user logged in
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
