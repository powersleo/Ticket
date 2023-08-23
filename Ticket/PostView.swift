import SwiftUI
import AVKit




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
        VideoPlayer(player: AVPlayer(url: url))
            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
            .padding(.bottom, 10)
    }
}

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var currentIndex: Int = 0
    var atEnd = false
    init() {
           posts = [
               Post(title: "Text Post", author: "Author1", content: .text("This is a text post."), isHead: true, rootPost: nil, upvotes: 0, downvotes: 0, comments: []),
               Post(title: "Text Post", author: "Authorniunui", content: .text("This is a text post."), isHead: true, rootPost: nil, upvotes: 0, downvotes: 0, comments: []),
               Post(title: "Video Post", author: "Auth2or2", content: .video(URL(string: "https://www.sample-videos.com/video123/mp4/480/big_buck_bunny_480p_1mb.mp4")!, "test"), isHead: true, rootPost: nil, upvotes: 0, downvotes: 0, comments: []),
               Post(title: "Image Post", author: "Auth2321or3", content: .image(URL(string: "https://via.placeholder.com/300")!, "test"), isHead: true, rootPost: nil, upvotes: 0, downvotes: 0, comments: []),
               Post(title: "Image Post with Caption", author: "Author", content: .image(URL(string: "https://via.placeholder.com/300")!, "This is an image caption"), isHead: true, upvotes: 0, downvotes: 0, comments: []),
               Post(title: "Video Post", author: "Aut33hor2", content: .video(URL(string: "https://www.sample-videos.com/video123/mp4/480/big_buck_bunny_480p_1mb.mp4")!, "test"), isHead: true, rootPost: nil, upvotes: 0, downvotes: 0, comments: []),
               Post(title: "Text Post", author: "Author231", content: .text("This is a text post."), isHead: true, rootPost: nil, upvotes: 0, downvotes: 0, comments: []),
               Post(title: "Video Post", author: "Auth2or2", content: .video(URL(string: "https://www.sample-videos.com/video123/mp4/480/big_buck_bunny_480p_1mb.mp4")!, "test"), isHead: true, rootPost: nil, upvotes: 0, downvotes: 0, comments: []),
               Post(title: "Image Post", author: "Auth2321or3", content: .image(URL(string: "https://via.placeholder.com/300")!, "test"), isHead: true, rootPost: nil, upvotes: 0, downvotes: 0, comments: [])
           ]
       } 
    func incrementIndex() -> Bool {
        if currentIndex < posts.count - 1 {
            currentIndex += 1
            return true
        } else {
            return false
        }
    }

    func removePost(at index: Int) {
           if posts.indices.contains(index) {
               posts.remove(at: index)
           }
       }
}

struct PostView: View {
    @EnvironmentObject var postViewModel: PostViewModel
    @State private var showingNewPostView = false
    @State var dragAmount = CGSize.zero
    @State private var noMorePosts = false

    var body: some View {
        let post = postViewModel.posts[postViewModel.currentIndex]
        GeometryReader { geometry in
            if noMorePosts {
                Text("No more posts")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                // The rest of your PostView
                
                
                VStack() {
                    Spacer()
                    Text(post.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 5)
                        .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .leading)
                    
                    Text(post.author)
                        .font(.footnote)
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 10)
                        .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .leading)
                    
                    
                    switch post.content {
                        case .text(let text):
                            textContent(text: text)
                            
                        case .image(let url, let caption):
                            VStack {
                                imageContent(url:url)
                                if let caption = caption {
                                    Text(caption)
                                        .font(.caption)
                                        .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .leading)
                                        .multilineTextAlignment(.leading)

                                }
                            }
                            
                        case .video(let url, let caption):
                            VStack {
                                videoContent(url:url)
                                if let caption = caption {
                                    Text(caption)
                                        .font(.caption)
                                        .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .leading)
                                        .multilineTextAlignment(.leading)

                                }
                            }
                    }


    
                    VStack {
                        HStack {
                            Text("\(post.upvotes - post.downvotes)")
                            Spacer()
                            
                            NavigationLink(destination: Text("Replies")) {
                                Text("\(post.comments.count) replies")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                            Spacer()
                            
                            Button(action: {
                                print("Reply button tapped")
                                self.showingNewPostView = true
                            }) {
                                HStack {
                                    Image(systemName: "square.and.pencil.circle")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                }.sheet(isPresented: $showingNewPostView) {
                                    // Check if the post is a root post, if so, set headPostUUID to current post's id, else keep the original headPostUUID
                                    if post.isHead {
                                        NewReplyView(previousPostUUID: .constant(post.id), headPostUUID: .constant(post.id))
                                    } else {
                                        NewReplyView(previousPostUUID: .constant(post.id), headPostUUID: .constant(post.rootPost ?? UUID()))
                                    }
                                }
                                .foregroundColor(.blue)
                            }


                        }
                        .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .leading)
                    }
                    .padding(.top, 10)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .offset(x: self.dragAmount.width)
                .animation(.interactiveSpring())
                .gesture(
                    DragGesture()
                        .onChanged { self.dragAmount = $0.translation }
                        .onEnded { value in
                            if self.dragAmount.width < -geometry.size.width / 6{
                                if !self.postViewModel.incrementIndex() {
                                    self.noMorePosts = true
                                } else {
                                    self.dragAmount = CGSize(width: -geometry.size.width, height: 0)
                                }
                            } else if self.dragAmount.width > geometry.size.width / 6{
                                if !self.postViewModel.incrementIndex() {
                                    self.noMorePosts = true
                                } else {
                                    self.dragAmount = CGSize(width: geometry.size.width, height: 0)
                                }
                            }
                            self.dragAmount = CGSize.zero
                        }
                    
                )}
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        let dummyPost = Post(title: "Title", author: "Author", content: .text("This is a text post."), isHead: true, upvotes: 0, downvotes: 0, comments: [])
        let postViewModel = PostViewModel()
        postViewModel.posts = [dummyPost, dummyPost]

        return PostView().environmentObject(postViewModel)
    }
}

