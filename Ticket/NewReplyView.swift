import SwiftUI

struct NewReplyView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var previousPostUUID: UUID?
    @Binding var headPostUUID: UUID?
    @State private var postContent: PostContent = .text("")
    
    @State private var title = ""
    @State private var author = ""
    @State private var textContent = ""
    @State private var mediaURL = ""
    @State private var caption = ""
    @State private var contentType = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Post Information").font(.headline).padding(.top)) {
                    TextField("Title", text: $title)
                        .font(.body)
                    TextField("Author", text: $author)
                        .font(.body)
                    
                    Picker("Content Type", selection: $contentType) {
                        Text("Text").tag(0)
                        Text("Image").tag(1)
                        Text("Video").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical)
                    
                    switch contentType {
                    case 0:
                        TextField("Content", text: $textContent)
                            .font(.body)
                    case 1, 2:
                        TextField("Media URL", text: $mediaURL)
                            .font(.body)
                        TextField("Caption", text: $caption)
                            .font(.body)
                    default:
                        EmptyView()
                    }
                }
                Button(action: {
                                    // Unwrap the optional UUID
                                    if let headUUID = headPostUUID {
                                        if let prevUUID = previousPostUUID {
                                            // Determine the type of content
                                            switch contentType {
                                            case 0:
                                                postContent = .text(textContent)
                                            case 1:
                                                if let imageURL = URL(string: mediaURL) {
                                                    postContent = .image(imageURL, caption)
                                                }
                                            case 2:
                                                if let videoURL = URL(string: mediaURL) {
                                                    postContent = .video(videoURL, caption)
                                                }
                                            default:
                                                break
                                            }
                                            
                                            Post(title: title, author: author, content: postContent, isHead: false, rootPost: headUUID, repliedPost: prevUUID, upvotes: 0, downvotes: 0, comments: [])
                                            
                                            
                                            self.presentationMode.wrappedValue.dismiss() // Close the view
                                        } else {
                                            // Handle the case where previousPostUUID is nil
                                        }
                                        
                                        self.presentationMode.wrappedValue.dismiss() // Close the view
                                    } else {
                                        // Handle the case where previousPostUUID is nil
                                    }
                                    
                                }) {
                    Text("Create Reply")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .navigationBarTitle("New Reply", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss() // Close the view
            }) {
                Text("Cancel")
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            })
        }
    }
}

