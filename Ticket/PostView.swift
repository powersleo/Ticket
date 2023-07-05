import SwiftUI
import AVKit

enum PostContent {
    case text(String)
    case image(URL)
    case video(URL)
}

struct Post: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let content: PostContent
    let isHead: Bool
    var rootPost: UUID?
    var upvotes: Int
    var downvotes: Int
    var comments: [String]
}



struct textContent: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.body)
            .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .leading)
            .clipped()
            .cornerRadius(10)
            .padding(.bottom, 10)
    }
}

struct imageContent: View {
    var url: URL

    var body: some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if phase.error != nil {
                Text("Error loading image")
            } else {
                ProgressView()
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
        .clipped()
        .cornerRadius(10)
        .padding(.bottom, 10)
    }
}

struct videoContent: View {
    var url: URL

    var body: some View {
        // Replace this with actual video player
        VideoPlayer(player: AVPlayer(url: url))
            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
            .padding(.bottom, 10)
    }
}

struct PostView: View {
    @State var post: Post

    var body: some View {
        VStack(alignment: .leading) {
            Text(post.title)
                .fontWeight(.bold)
                .padding(.bottom, 5)
            Text(post.author)
                .font(.footnote)
                .foregroundColor(.blue)
                .padding(.bottom, 10)
            
            switch post.content {
            case .text(let text):
                textContent(text: text)
            case .image(let url):
                imageContent(url:url)
            case .video(let url):
                videoContent(url:url)
            }
            HStack {
                Button(action: {
                    post.upvotes += 1
                }) {
                    HStack {
                        Image(systemName: "arrow.up")
                            .foregroundColor(.green)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                Text("\(post.upvotes - post.downvotes)")
                    .foregroundColor(.green)
                Button(action: {
                    post.downvotes += 1
                }) {
                    HStack {
                        Image(systemName: "arrow.down")
                            .foregroundColor(.red)

                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: Text("Replies")) {
                    Text("\(post.comments.count) replies")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            .padding(.top, 10)
        }
        .padding()
//        .frame(maxWidth: UIScreen.main.bounds.width * 0.80) // Restricts the width but allows vertical growth
    }
}


struct PostView_Previews: PreviewProvider {
    @State static var dummyPost = Post(title: "Title", author: "Author", content: .text("This is a text post."), isHead: true, upvotes: 0, downvotes: 0, comments: [])

    static var previews: some View {
        PostView(post: dummyPost)
    }
}
