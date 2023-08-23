import SwiftUI

class AppState: ObservableObject {
    @Published var isLoggedIn = false
}

struct ContentView: View {
    @StateObject private var appState = AppState()
    
    var body: some View {
        if appState.isLoggedIn {
            MainPageView()
        } else {
            LoginView(appState: appState)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
