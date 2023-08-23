import SwiftUI

struct LoginView: View {
    @ObservedObject var appState: AppState

    @State private var username = ""
    @State private var password = ""

    var body: some View {
        VStack {
            Text("Welcome")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 50)

            TextField("Username", text: $username)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .autocapitalization(.none)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .autocapitalization(.none)

            Button(action: {
                // Handle login here, then:
                self.appState.isLoggedIn = true
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
////        LoginView()
//    }
//}
