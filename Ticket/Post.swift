//
//  Post.swift
//  Ticket
//
//  Created by Leo Powers on 7/5/23.
//

import Foundation

enum PostContent {
    case text(String)
    case image(URL, String?)
    case video(URL, String?)
}



struct Post: Identifiable {
    var id = UUID()
    let title: String
    let author: String
    let content: PostContent
    let isHead: Bool
    var rootPost: UUID?
    var repliedPost: UUID?
    var upvotes: Int
    var downvotes: Int
    var comments: [String]
    
    init(title: String, author: String, content: PostContent = .text("Missing Content"), isHead: Bool, rootPost: UUID? = nil,repliedPost: UUID? = nil, upvotes: Int = 0, downvotes: Int = 0, comments: [String] = []) {
           self.id = UUID()
           self.title = title
           self.author = author
           self.content = content
           self.isHead = isHead
           self.rootPost = rootPost
           self.repliedPost = repliedPost 
           self.upvotes = upvotes
           self.downvotes = downvotes
           self.comments = comments
       }
}
