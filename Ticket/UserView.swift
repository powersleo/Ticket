import SwiftUI

struct UserView: View {
    @State private var username = "JohnDoe"
    @State private var email = "johndoe@example.com"
    @State private var bio = "Hello, I am John Doe. I love programming and SwiftUI."

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .foregroundColor(.gray)
                Spacer()
            }
            Text(username)
                .font(.title)
                .fontWeight(.bold)
            Text(email)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("Bio")
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top)
            Text(bio)
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
            Spacer()
        }
        .padding()
        .navigationBarTitle("User Profile", displayMode: .inline)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
